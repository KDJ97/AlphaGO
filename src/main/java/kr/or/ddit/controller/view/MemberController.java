package kr.or.ddit.controller.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.QRMaker;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.FavoritesVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.service.AssignService;
import kr.or.ddit.service.AttendanceService;
import kr.or.ddit.service.ExamService;
import kr.or.ddit.service.FavoritesService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.NoticeService;
import kr.or.ddit.service.PdsService;
import kr.or.ddit.service.ScoreService;
import kr.or.ddit.service.StudyPlanService;
import kr.or.ddit.service.UniversityService;

@Controller
@RequestMapping("/member")
public class MemberController {


	@Autowired
	private MemberService memberService;

//   @Autowired
//   private ExceptionLoggerHelper exceptionLogger;

	@Autowired
	private FavoritesService favoritesService;

	@Autowired
	private PdsService pdsService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private StudyPlanService studyPlanService;

	@Autowired
	private AttendanceService attendanceService;

	@Autowired
	private UniversityService universityService;

	@Autowired
	private ScoreService scoreService;

	@Autowired
	private ExamService examService;

	@Autowired
	private AssignService assignService;


	@Resource(name = "qrPath")
	private String qrPath;


	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping("/home")
	public String main(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		String url = "member/main";

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		if(member == null) {
			//로그인 session 정보가 없을 때
			url = "redirect:/common/loginTimeOut";
			logger.info("loginMember 정보가 없음");
			return url;
		}

		String id = member.getId();

		//즐겨찾기
		List<FavoritesVO> favList = favoritesService.getFavoritesListById(id);
		List<Map<String, Object>> likeData = pdsService.getLikePdsList(favList);

		model.addAttribute("likeData", likeData);

		// 최근 공지사항
		List<NoticeVO> noticeAllList = noticeService.getNoticeList();
		List<NoticeVO> noticeList = new ArrayList<NoticeVO>();
		if(noticeAllList != null) {
			int length = noticeAllList.size();
			if(length >= 5) length = 5;

			for(int i = 0; i < length; i++) {	//5개
				noticeList.add(noticeAllList.get(i));
			}
		}
		model.addAttribute("noticeList", noticeList);

		// 학습계획표
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String date = now.format(formatter);

		int spCode = studyPlanService.getSpCode(date, id);
		List<StudyPlanVO> planList = studyPlanService.getPlanList(spCode);

		model.addAttribute("planList", planList);

		//QR 출석체크 생성
		DateTimeFormatter QRformatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String QRdate = now.format(QRformatter);

		String fileName = QRdate + "-" + id +".png";
		String filePath = qrPath + fileName;

		//qrPath 의 directory생성
		File directory = new File(qrPath);
		directory.mkdirs();

		QRMaker.make(filePath, "http://" + InetAddress.getLocalHost().getHostAddress() + request.getContextPath() + "/member/attendQR.go?id=" + id +"&date=" + QRdate);

		String qrUrl = request.getContextPath() + "/member/getQR.go?fileName=" + fileName;
		model.addAttribute("qrUrl", qrUrl);

		//출결 상태
		AttendanceVO attend = attendanceService.getAttendance(id);
		model.addAttribute("attend", attend);

		//오늘 수업 리스트
		List<Map<String, String>> classList = memberService.selectMemberTodayClass(id);
		model.addAttribute("classList", classList);

		//오늘의 시험
		List<ExamVO> examList = examService.getExam(id);
		model.addAttribute("examList", examList);

		//오늘의 과제
		List<AssignNameVO> assignList = assignService.getAssign(id);
		model.addAttribute("assignList", assignList);

		//시간표
		List<TimeTableCommand> timeList = memberService.getTimeTable(id);
		for(TimeTableCommand command : timeList) {
			logger.info(command.toString());
		}
		model.addAttribute("timeList", timeList);

		//성적 그래프용 데이터(이전성적, 최근성적) : 학교 school / 학원 academy
		Map<String, Map<String, Integer>> scoreData = scoreService.getScoreDataForGraph(id);
		model.addAttribute("scoreData", scoreData);

		return url;
	}


	// 마이페이지 -> 회원정보 상세보기
	@RequestMapping("/list")
	public String list(Model model) throws SQLException {
		String url = "member/list";

		return url;
	}





	@RequestMapping("/getQR")
	@ResponseBody
	public ResponseEntity<byte[]> getQR(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;


		String savePath = qrPath.replace("/", File.separator);
		File sendFile = new File(savePath, fileName);

		InputStream in = null;

		try {
			in = new FileInputStream(sendFile);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		} finally {
			if(in != null)
				try {
					in.close();
				}catch (IOException e) {
					e.printStackTrace();
					entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
				}
		}

		return entity;
	}




	@RequestMapping("/attendQR")
	public String attendQR(String id, String date, Model model) throws SQLException, Exception{
		String url = "member/attendQR";

		//date - yyyyMMdd
		AttendanceVO attend = new AttendanceVO();
		attend.setId(id);


		LocalDate now = LocalDate.now();
		DateTimeFormatter QRformatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		if(!now.format(QRformatter).equals(date)) {
			//유효하지 않은 접근 - 오늘 날짜가 아닌 QR코드
			model.addAttribute("error", "유효하지 않은 접근입니다");
			return url;
		}

		// 문자열 -> Date
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		attend.setRegDate(formatter.parse(date));


		// 출석 처리하기
		attendanceService.attendQR(attend);

		return url;
	}



	// 회원정보 비밀번호 입력창
	@RequestMapping(value = "/detailPass", method = RequestMethod.GET)
	public String infoPass() {
		String url = "/member/detailPass";

		return url;
	}

	// 회원정보 상세
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String info() {
		String url = "/member/detail";

		return url;
	}

	// 회원정보 수정
	@RequestMapping(value = "/modifyForm", method = RequestMethod.GET)
	public String infoModify(Model model) throws SQLException {
		String url = "/member/modify";


		return url;
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(HttpSession session ,MemberVO member, RedirectAttributes rttr) throws Exception {
		String url = "redirect:detail.go";

		memberService.modify(member);

		//세션정보 변경
		session.setAttribute("loginUser", memberService.getMember(member.getId()));

		 rttr.addFlashAttribute("reload","modify");

		return url;
	}

	// 팝업
	@RequestMapping("/selectUni")
	public void selectUni(Model model) throws SQLException{

		// 대학 리스트
		List<UniversityVO> uniList = universityService.getUniversityList();
		model.addAttribute("uniList", uniList);
	}



}
