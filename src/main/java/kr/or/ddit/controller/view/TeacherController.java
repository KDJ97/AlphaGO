package kr.or.ddit.controller.view;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

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
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.ExamInsertCommand;
import kr.or.ddit.command.JimoonProblemCommand;
import kr.or.ddit.command.MakeFileName;
import kr.or.ddit.command.ProblemSearchCommand;
import kr.or.ddit.command.QRMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.TeacherRegistCommand;
import kr.or.ddit.command.TMyPageModifyCommand;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.ClassProgVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.dto.WeekPlanVO;
import kr.or.ddit.dto.TecounseltVO;
import kr.or.ddit.dto.WrongVO;
import kr.or.ddit.service.AssignService;
import kr.or.ddit.service.AttendanceService;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.ExamService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.NoticeService;
import kr.or.ddit.service.TMyPageService;
import kr.or.ddit.service.TclassService;
import kr.or.ddit.service.TeacherService;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
	  @Autowired
	  TeacherService service;
	  @Autowired
	  TMyPageService tmyPageService;
	  @Autowired
	  MemberService memberService;
	  @Autowired
	  private NoticeService noticeService;
	  @Autowired
	  private AssignService assignService;
	  @Autowired
	  private TclassService tclassService;
	  @Autowired
	  private AttendanceService attendService;
	  @Autowired
	  private AttendanceService attendanceService;
	  @Autowired
	  private ExamService examService;
	  @Resource(name = "qrPath")
	  private String qrPath;
	  
	  @Autowired
		private DmService dmService;
	  
	  
	  
	  private static final Logger logger = LoggerFactory.getLogger(TeacherController.class);
	  
	   @RequestMapping("/home")
		public String home(HttpServletRequest request, HttpSession session, Model model) throws Exception {
			String url = "teacher/home";
			
			MemberVO member = (MemberVO) session.getAttribute("loginUser");
			if(member == null) {
				//로그인 session 정보가 없을 때
				url = "redirect:/common/loginTimeOut";
				logger.info("loginMember 정보가 없음");
				return url;
			}

			String id = member.getId();
			
			//시간표
			List<TimeTableCommand> timeList = memberService.getTimeTableForTeacher(id);
			for(TimeTableCommand tableCommand :timeList) {
				logger.info(tableCommand.toString());
			}
			model.addAttribute("timeList", timeList);
			
			
			//수업진도현황
			List<ClassVO> classList = tclassService.selectClassesForHome(id);
			model.addAttribute("classList",classList);
			
			
			//QR 출석체크 생성
			LocalDate now = LocalDate.now();
			DateTimeFormatter QRformatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			String QRdate = now.format(QRformatter);

			String fileName = QRdate + "-" + id +".png";
			String filePath = qrPath + fileName;

			//qrPath 의 directory생성
			File directory = new File(qrPath);
			directory.mkdirs();

			QRMaker.make(filePath, "http://" + InetAddress.getLocalHost().getHostAddress() + request.getContextPath() + "/teacher/attendQR.go?id=" + id +"&date=" + QRdate);

			String qrUrl = request.getContextPath() + "/member/getQR.go?fileName=" + fileName;
			model.addAttribute("qrUrl", qrUrl);
			
			//출결 상태
			AttendanceVO attend = attendanceService.getAttendance(id);
			model.addAttribute("attend", attend);
			
			//출석일	결석일	지각일	조퇴일	외출일  (전체기간)
			List<AttendanceVO> totalList = attendService.getAttendanceList(member.getId(), "0");

			int day1 = 0;
			int day2 = 0;
			int day3 = 0;
			int day4 = 0;
			int day5 = 0;

			for(AttendanceVO attendVO : totalList) {
				if(attendVO.getAttendanceStatus() == 1) day1++;
				if(attendVO.getAttendanceStatus() == 2) day2++;
				if(attendVO.getAttendanceStatus() == 3) day3++;
				if(attendVO.getAttendanceStatus() == 4) day4++;
				if(attendVO.getAttendanceStatus() == 5) day5++;
			}

			Map<String, Integer> dayMap = new HashMap<String, Integer>();
			dayMap.put("day1", day1);
			dayMap.put("day2", day2);
			dayMap.put("day3", day3);
			dayMap.put("day4", day4);
			dayMap.put("day5", day5);

			model.addAttribute("dayMap", dayMap);
			
			//오늘 수업 리스트
			List<Map<String, String>> classListForToday = memberService.selectMemberTodayClass(id);
			model.addAttribute("classListForToday", classListForToday);

			//오늘의 과제
			List<AssignNameVO> assignList = assignService.getAssign(id);
			model.addAttribute("assignList", assignList);
			//오늘의 상담일정
			List<TecounseltVO> counseltList = tclassService.selectTodayConsult(id);
			model.addAttribute("counseltList", counseltList);
			
			List<ExamVO> examList = tclassService.selectTodayTest(id);
			model.addAttribute("examList", examList);
			
			
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
			String url = "member/attendQRForTeacher";

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
			attendanceService.attendQRForTeacher(attend);

			return url;
		}
	   
	   @ResponseBody
	   @RequestMapping(value="/homeNotice",method=RequestMethod.GET)
		public ResponseEntity<Map<String,Object>> homeNotice(){
			ResponseEntity<Map<String,Object>> entity = null;
			
			Map<String,Object> dataMap = new HashMap<String,Object>();
			
			try {
				List<NoticeVO> noticeAllList = noticeService.getNoticeList();
				List<NoticeVO> noticeList = new ArrayList<NoticeVO>();
				if(noticeAllList != null) {
					for(int i = 0; i < 5; i++) {	//5개
						noticeList.add(noticeAllList.get(i));
					}
				}
				dataMap.put("noticeList", noticeList);
				entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return entity;
		}
	   
	   @ResponseBody
	   @RequestMapping(value="/homeHomework",method=RequestMethod.GET)
		public ResponseEntity<Map<String,Object>> homeHomework(HttpSession session){
			ResponseEntity<Map<String,Object>> entity = null;
			
			MemberVO member = (MemberVO) session.getAttribute("loginUser");
			String id = member.getId();
			
			Map<String,Object> dataMap = new HashMap<String,Object>();
			
			try {
				dataMap = assignService.selectSubmitStudentForHome(id);
				entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return entity;
		}
	   
	   @ResponseBody
	   @RequestMapping(value="/homeProgress",method=RequestMethod.GET)
	   public ResponseEntity<Map<String,Object>> homeProgress(@RequestParam Map<String, Object> map){
		   ResponseEntity<Map<String,Object>> entity = null;
		   
		   String cpno = (String)map.get("cpno");
		   
		   Map<String, Object> dataMap = new HashMap<String, Object>();
		   
		   try {
			   dataMap = tclassService.selectProgressForHome(cpno);
			   entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
		   } catch (Exception e) {
			   e.printStackTrace();
			   entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
		   }
		   
		   return entity;
	   }
	   
	   
	   //근태조회
	   @RequestMapping("/list")
		public String attend(Criteria cri, @RequestParam(defaultValue = "all")String month,HttpSession session, Model model) throws Exception {
			String url = "teacher/attend";
			
			MemberVO member = (MemberVO) session.getAttribute("loginUser");

			//오늘 출석 정보
			AttendanceVO today = attendService.getAttendance(member.getId());
			model.addAttribute("today", today);

			//출력할 기간내의 출결 내역 -
			Map<String, Object> dataMap = attendService.getAttendanceListForPage(member.getId(), month, cri);
			model.addAttribute("dataMap", dataMap);

			//	출석일	결석일	지각일	조퇴일	외출일
			List<AttendanceVO> totalList = attendService.getAttendanceList(member.getId(), month);

			int day1 = 0;
			int day2 = 0;
			int day3 = 0;
			int day4 = 0;
			int day5 = 0;

			for(AttendanceVO attend : totalList) {
				if(attend.getAttendanceStatus() == 1) day1++;
				if(attend.getAttendanceStatus() == 2) day2++;
				if(attend.getAttendanceStatus() == 3) day3++;
				if(attend.getAttendanceStatus() == 4) day4++;
				if(attend.getAttendanceStatus() == 5) day5++;
			}

			Map<String, Integer> dayMap = new HashMap<String, Integer>();
			dayMap.put("day1", day1);
			dayMap.put("day2", day2);
			dayMap.put("day3", day3);
			dayMap.put("day4", day4);
			dayMap.put("day5", day5);

			model.addAttribute("dayMap", dayMap);
			
			return url;
		}
	   @RequestMapping("/modifyForm")
	   public String modify(Model model, HttpServletRequest request) throws Exception {
		   String url = "teacher/modify";
		   
		   HttpSession session=request.getSession();
		   MemberVO member=(MemberVO)session.getAttribute("loginUser");
		   String id=member.getId();
		   
		   MemberVO member2 = new MemberVO();
		   List<CareerVO> careerVOList = new ArrayList<CareerVO>();
		   member2 = tmyPageService.selectInfoForMypage(id);
		   careerVOList = tmyPageService.selectTeacherCareerList(id);
		   
		   model.addAttribute("member2", member2);
		   model.addAttribute("careerVOList", careerVOList);
		   
		   return url;
	   }
	   
	   @RequestMapping(value="/modify", method = RequestMethod.POST)
	   public String modify(TMyPageModifyCommand tMyPage, HttpServletRequest request)throws Exception{
			String url="teacher/modify_success";
			
			HttpSession session=request.getSession();
			MemberVO member2=(MemberVO)session.getAttribute("loginUser");
			String id=member2.getId();
			
			MemberVO member = tMyPage.toMemberVO();
			member.setId(id);
			
			tmyPageService.modifyTeacherInfo(member);
			
			String[] startDates = request.getParameterValues("startDate");
			String[] endDates = request.getParameterValues("endDate");
			String[] contents = request.getParameterValues("cacontent");
			String[] careerCode = request.getParameterValues("careerCode");
			
			CareerVO career = new CareerVO();
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			
			for(int i=0; i<startDates.length; i++) {
				career.setCacontent(contents[i]);
				System.out.println("String startDate : " + startDates[i]);
				career.setStartDate(fm.parse(startDates[i]));
				career.setEndDate(fm.parse(endDates[i]));
				career.setCareerCode(careerCode[i]);
				tmyPageService.modifyCareer(career);
			}
			
			return url;
		}

	   @RequestMapping("/mypage")
		public String mypage(Model model, HttpServletRequest request) throws Exception {
			String url = "teacher/mypage";
			
			HttpSession session=request.getSession();
		   MemberVO member=(MemberVO)session.getAttribute("loginUser");
		   String id=member.getId();
		   
		   MemberVO member2 = new MemberVO();
		   List<CareerVO> careerVOList = new ArrayList<CareerVO>();
		   member2 = tmyPageService.selectInfoForMypage(id);
		   careerVOList = tmyPageService.selectTeacherCareerList(id);
		   
		   model.addAttribute("member2", member2);
		   model.addAttribute("careerVOList", careerVOList);
		   
		   return url;
		}
	   
	   @RequestMapping("/mypagePass")
	   public String mypagePass(String pwd, Model model, HttpServletRequest request) throws Exception {
		   String url = "teacher/mypage";
		   
		   HttpSession session=request.getSession();
		   MemberVO member=(MemberVO)session.getAttribute("loginUser");
		   String id=member.getId();
		   
		   MemberVO member2 = new MemberVO();
		   List<CareerVO> careerVOList = new ArrayList<CareerVO>();
		   member2 = tmyPageService.selectInfoForMypage(id);
		   careerVOList = tmyPageService.selectTeacherCareerList(id);
		   
		   System.out.println("마이페이지 로그인 id : " + id);
		   System.out.println("커리어VO리스트 : "+careerVOList);
		   
		   if(member2.getPwd().equals(pwd)) {
			   url="teacher/mypage";
		   }
		   System.out.println("url : " + url); 
		   model.addAttribute("member2", member2);
		   model.addAttribute("careerVOList", careerVOList);
		   
		   return url;
	   }
	   
	   @Resource(name = "picturePath")
	   private String picturePath;
	   public String savePicture(String oldPicture, MultipartFile multi)throws Exception{
		      String fileName = null;
		      
		      /* 파일저장폴더설정 */
		      String uploadPath = picturePath;
		      
		      /* 파일유무확인 */
		      if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
		         fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
		         File storeFile = new File(uploadPath, fileName);
		         
		         // 파일경로 생성
		         storeFile.mkdirs();
		         
		         //local HDD에 저장
		         multi.transferTo(storeFile);
		      }
		      
		      // 기존파일 삭제
		      if(oldPicture != null && !oldPicture.isEmpty()) {
		         File oldFile = new File(uploadPath, oldPicture);
		         if(oldFile.exists()) {
		            oldFile.delete();
		         }
		      }
		      return fileName;
		   }
	   
	   @RequestMapping(value = "/getPicture", produces = "text/plain;charset=utf-8")
		public ResponseEntity<byte[]> getPicture(Model model, HttpServletRequest request) throws Exception {
			ResponseEntity<byte[]> entity = null;
			
			HttpSession session=request.getSession();
		   MemberVO member=(MemberVO)session.getAttribute("loginUser");
		   String id=member.getId();
		   
		   MemberVO member2 = new MemberVO();
		   member2 = tmyPageService.selectInfoForMypage(id);
		   String picture = member2.getPicture();
		   String imgPath = this.picturePath;
		   InputStream in = null;
		   
		   try {
				in = new FileInputStream(new File(imgPath, picture));

				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), 
							HttpStatus.CREATED);

			} finally {
				if(in!=null)in.close();
			}
			
			return entity;
		}
        
		@ResponseBody
		@RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
		   public ResponseEntity<String> picture(@RequestParam("pictureFile")MultipartFile multi, String oldPicture)throws Exception{
		      
		      ResponseEntity<String> entity = null;
		      String result = "";
		      HttpStatus status = null;
		      
		      /* 파일저장확인 */
		      if((result = savePicture(oldPicture, multi)) == null) {
		         result = "업로드 실패했습니다.!";
		         status = HttpStatus.BAD_REQUEST;
		      }else {
		         status = HttpStatus.OK;
		      }
		      
		      entity = new ResponseEntity<String>(result, status);
		      return entity;
		       
		   }
		
	   
	   @RequestMapping("/studentmanage_home")
	   public String detail(HttpServletRequest request,Model md) throws Exception {
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		
		   String id=(String)loginUser.getId();
		  System.out.println("id:"+id);
		   List<String>classList=service.getclassList(id);
		  
		   md.addAttribute("classList",classList);
		   String url = "teacher/studentmanage_home";
		   return url;
	   }
	   
	   @RequestMapping("/studentmanage_exam")
		public String exam(HttpServletRequest request,Model md) throws Exception {
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
            String id=(String)loginUser.getId();
		   
		   List<Map<String,Object>>data=service.getProcess(id);
		   
		   md.addAttribute("data",data);
		   
		   
		   
		   
			String url = "teacher/studentmanage_exam";
			return url;
		}
	   @RequestMapping("/studentmanage_attendance")
	 		public String attendance() throws Exception {
	 			String url = "teacher/studentmanage_attendance";
	 			return url;
	 		}
	   @RequestMapping("/studentmanage_school")
		public String schooltest(SearchCriteria cri,Model md,HttpServletRequest request) throws Exception {
		   HttpSession session=request.getSession();
			   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
			   String id=loginUser.getId();
			  Map<String,String> dt=service.idSearchName(id);
			  Map<String,Object>dataMap= service.teacherstudenttotalList(id,cri);
			  dataMap.put("name",dt.get("name"));
			  dataMap.put("subject",dt.get("subject"));
			  System.out.println(dataMap);
			  md.addAttribute("dataMap",dataMap);
			 // System.out.println("?");
			 // System.out.println(dataMap.get("studentTotalList"));
			String url = "teacher/studentmanage_school";
			return url;
		}
	   @RequestMapping("/studentmanage_acardemy")
			public String acardemytest(HttpServletRequest request,Model md) throws Exception {
		   
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		String subject=loginUser.getSubject();
		   String id=(String)loginUser.getId();
		  System.out.println("id:"+id);
		   List<String>classList=service.getclassList(id);
		  List<ClassVO>classCList=service.getclassClist(id);
		
		   md.addAttribute("classList",classCList);
		   md.addAttribute("subject",subject);
				String url = "teacher/studentmanage_acardemy";
				return url;
			}
	   @RequestMapping("/exammanage")
		public String exammange(HttpServletRequest request,Model md) throws Exception {
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		 
		   String id=(String)loginUser.getId();
		   
		   List<Map<String,Object>>data=service.getProcess(id);
		   System.out.println("데이터체크:"+data);
		   md.addAttribute("data",data);
		  

			
			String url = "teacher/exammanage";
			return url;
		}
	   
	   @RequestMapping("/exammanage2")
			public String exammange2() throws Exception {
				String url = "teacher/exammanage2";
				return url;
			}
	   @RequestMapping("/submitproblem")
			public String submitproblem(String endDate,String processName,String examName,String startDan,String endDan,String startDate,String pc,String clcode,Model md) throws Exception {
		           System.out.println(endDate);
		           System.out.println(startDate);
		           System.out.println(processName);
		           System.out.println(examName);
		           System.out.println(startDan);
		           System.out.println(endDan);
		           System.out.println(pc);
		         
		       Map<String,Object>data=new HashMap<String,Object>();
		       data.put("endDate",endDate);
		       data.put("processCode",processName);
		       data.put("examName",examName);
		       data.put("startDan",startDan);
		       data.put("endDan",endDan);
		       data.put("startDate",startDate);
		       data.put("probCount",pc);
		       data.put("classCode",clcode);
		       md.addAttribute("data",data);
				String url = "teacher/submitproblem";
				return url;
			}
	   
	   @RequestMapping("/problemmanage")
			public String problemmanage(ProblemSearchCommand cri,Model md,HttpServletRequest request) throws Exception {
			   HttpSession session=request.getSession();
			   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
			   
			   String id=loginUser.getId();
			
			 
			   	System.out.println("이것은 크리다:"+cri);
			   Map<String,Object>dataMap=service.problemList(id,cri);
			   
			   List<ProblemVO>repotProblemList=service.repotproblemlist(id);
			   System.out.println("==============================");
			   System.out.println("repot:"+repotProblemList);
			   System.out.println(repotProblemList.size());
			 //  System.out.println("selectgo:"+selectgo);
			   System.out.println("셀렉된거:"+cri.getSelectgogo());
			   System.out.println(cri.getPage());
			   System.out.println("==============================");
			   dataMap.put("repotProblemList",repotProblemList);
			   md.addAttribute("dataMap",dataMap);
		   
					String url = "teacher/problemmanage";
					return url;
				}
	   @RequestMapping("/problemDetail")
		public String problemDetail(int prC,Model md,HttpServletRequest request) throws Exception {
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   String id=loginUser.getId();
		   
		
		  
		   Map<String,Object> problem=service.getProblem(prC);
		   System.out.println(problem.get("jimoon"));
		    ProblemVO pr=(ProblemVO)problem.get("problem");
		    System.out.println("==================================");
		    System.out.println(problem);
		    System.out.println("==================================");
		  
		   problem.put("idid",id);
		   	md.addAttribute("dataMap",problem);
		   	
				String url = "teacher/problemDetail";
				return url;
			}
	   
	   
	   
	   
	   
	   @RequestMapping("/problemModify")
	          public String problemmodify(int prC,Model md,HttpServletRequest request)throws Exception{
		   String url="";
		   HttpSession session=request.getSession();
			   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
			   String id=loginUser.getId();
			   Map<String,Object>data2=service.createGdata(id);
		   Map<String,Object> problem=service.getProblem(prC);
		    ProblemVO prt=(ProblemVO)problem.get("problem");
		    System.out.println("get유형내임:"+prt.getSaname());
		   Map<String,Object>data=service.createGdata(id);
		  // String danwon=service.danwonSearch(prC);
		   String danwon="크크크";
		   String detailSubj=service.detailSubjecSearch(prC);
		 
		   data.put("subject",service.idSearchName(id).get("subject"));
		   data.put("dan",danwon);
		   data.put("detailSubj",detailSubj);
		   md.addAttribute("dataMap",problem);
		   md.addAttribute("data", data);
		   md.addAttribute("data2", data2);
		   System.out.println("이것은 view단에 보내는 dataMap"+problem);
		   System.out.println("이것은 view단에 보내는 data"+data);
		  ProblemVO pr=(ProblemVO)problem.get("problem");
		  System.out.println("=================================================");
		  String jimoon=String.valueOf(problem.get("jimoon"));
		  System.out.println("subject:"+service.idSearchName(id).get("subject"));
		  System.out.println("dan:"+danwon);
		  System.out.println("detailSubj:"+detailSubj);
		  System.out.println(problem);
		  System.out.println(data);
		  System.out.println("=================================================");

		  if(pr.getLproblem().equals("객관식")&&jimoon.equals("null")) {
			  System.out.println("마 이거뭐냥 어 뭐냐고");
			  url="teacher/problemModify2";
		  }
		  if(pr.getLproblem().equals("주관식")&&jimoon.equals("null")) {
			  url="teacher/problemModify3";
		  }
		  if(!jimoon.equals("null")) {
			  url="teacher/problemModify4";
		  }
		    
		   return url;
	   }
	   @RequestMapping("/problemcreateG")
       public String problemcreateG(HttpServletRequest request,Model md)throws Exception{
		   HttpSession session=request.getSession();
					   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
					   String id=loginUser.getId();
					   
					   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
					   Map<String,Object>data=service.createGdata(id);
					  data.put("subject",service.idSearchName(id).get("subject"));
					  System.out.println("문제만들기:");
					  System.out.println(data);
					  md.addAttribute("data", data);
		   
		   
		   
	   String url="teacher/problemcreateG";
	   return url;
}
	   @RequestMapping("/problemcreateJ")
       public String problemcreateJ(HttpServletRequest request,Model md)throws Exception{
		   HttpSession session=request.getSession();
		   MemberVO member=(MemberVO)session.getAttribute("loginUser");
		   String id=member.getId();
		   
		   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
		   Map<String,Object>data=service.createGdata(id);
		   data.put("subject",service.idSearchName(id).get("subject"));
           md.addAttribute("data", data);

	   String url="teacher/problemcreateJ";
	   return url;
}
	   @RequestMapping("/problemjcreateG")
       public String problemjcreateG(HttpServletRequest request,Model md)throws Exception{
			   HttpSession session=request.getSession();
			   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
			   String id=loginUser.getId();
			   
			   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
			   Map<String,Object>data=service.createGdata(id);
			  data.put("subject",service.idSearchName(id).get("subject"));
              md.addAttribute("data", data);
		   
	   String url="teacher/problemjcreateG";
	   return url;
}
	   
	   @RequestMapping("/problemjcreateJ")
       public String problemjcreateJ()throws Exception{
	   String url="teacher/problemjcreateJ";
	   return url;
}
	   
	   @RequestMapping("/wrongnote")
       public String wrongnote(HttpServletRequest request,Model md,SearchCriteria cri)throws Exception{
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   String id=loginUser.getId();
		   System.out.println("wrongnote크리정보:"+cri);
		  if(cri.getSearchType()!=null&&(cri.getSearchType().trim()).equals("")){
			              cri.setSearchType(null);
		  }
		  if(cri.getKeyword()!=null&&(cri.getKeyword().trim()).equals("")){
              cri.setKeyword(null);
}
		   Map<String,Object>data=service.getAllExamList(id,cri);
		   List<ClassVO>classList=service.getListClass(id);
		   data.put("classList",classList);
		
		   md.addAttribute("dataMap",data);
		   
		
		   
		   
		   
		   
		   
		   
	   String url="teacher/wrongnote";
	   return url;
}
	   @RequestMapping("/teacherconsult")
       public String teacherconsult()throws Exception{
	   String url="teacher/teacherconsult";
	   return url;
}
	   @RequestMapping("/teacherconsultdetail")
       public String teacherconsultdetail()throws Exception{
	   String url="teacher/teacherconsultdetail";
	   return url;
}
	   @RequestMapping("/teacherconsultend")
       public String teacherconsultend()throws Exception{
	   String url="teacher/teacherconsultend";
	   return url;
}
	   
	
	   @RequestMapping("/teacherconsultcancel")
       public String teacherconsultcancel()throws Exception{
	   String url="teacher/teacherconsultcancel";
	   return url;
}
	   @RequestMapping("/teacheranalysis")
       public String teacheranalysis()throws Exception{
	   String url="teacher/teacheranalysis";
	   return url;
}
	   
	   @RequestMapping(value="/problemCreatego", method = RequestMethod.POST)
       public String problemCreatego(ProblemVO problem,HttpServletRequest request)throws Exception{
		   System.out.println(problem);
		   String url="";
		  int cnt=0;
		  HttpSession session=request.getSession();
		  MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		  problem.setMaker(loginUser.getId());
		  String subdetailCode=problem.getSubdetailCode();
		  String saname=problem.getSaname();
		  int sano=service.searchSanoCode(saname,subdetailCode);
		    problem.setSano(sano);
		  cnt=service.insertProblem(problem);
		  if(problem.getLproblem().equals("객관식")) {
			  url="redirect:problemmanage.go";
		  }else {
			  url="redirect:problemmanage.go";
		  }
	 
	   return url;
}
	   @RequestMapping(value="/problemjCreatego", method = RequestMethod.POST)
       public String problemjCreatego(JimoonProblemCommand problem,HttpServletRequest request)throws Exception{
		   System.out.println(problem);
		   
		   HttpSession session=request.getSession();
			  MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   problem.setMaker(loginUser.getId());
		   String url="redirect:problemmanage.go";
		   int cnt=0;
		 //service.insertProblem(problem);
		cnt=service.insertJProblem(problem);
	
	   return url;
}
	   
	   @RequestMapping(value="/problemModifygo", method = RequestMethod.POST)
       public String problemModifygo(ProblemVO problem)throws Exception{
		   System.out.println("수정하는 내용의 문제:"+problem);
		   int prC=problem.getProblemCode();
		   
		   String url="redirect:problemDetail.go?prC="+prC;
		   int cnt=0;
		 //service.insertProblem(problem);
		cnt=service.modifyProblem(problem);
	
	   return url;
} 
	   
	   @RequestMapping(value="/problemjModify", method = RequestMethod.POST)
       public String problemjModify(JimoonProblemCommand problem,HttpServletRequest request)throws Exception{
		   HttpSession session=request.getSession();
		   MemberVO loginUser=(MemberVO)session.getAttribute("loginUser");
		   String id=loginUser.getId();
		   	
		   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
		   int cnt=0;
			
			cnt=service.updateJProblem(problem);
			System.out.println("??????????????????????????");
			String url="redirect:problemmanage.go";
	   return url;
} 
	   
	   
	   //시험 등록하기
	   @RequestMapping(value="/examInsertGO", method = RequestMethod.POST)
       public String examInsertGO(ExamInsertCommand exam,HttpServletRequest request)throws Exception{
		   	
		   	
		   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
		   int cnt=0;
		   System.out.println("class코드 실험이다.:"+exam.getClassCode());
		   System.out.println("exam:"+exam);
			cnt=service.examInsertGo(exam);
		
			
			service.colExamgo(cnt,exam);
			
		
			String url="redirect:studentmanage_exam.go";
	   return url;
} 	   
	   
	   //자동 시험 등록하기
	   @RequestMapping(value="/examInsertGO2", method = RequestMethod.POST)
       public String examInsertGO2(ExamInsertCommand exam,HttpServletRequest request)throws Exception{
		   	
		   	
		   //객관식 문제만들기 화면 전처리 데이터들 받는 서비스
		   int cnt=0;
		   System.out.println("class코드 실험이다.:"+exam.getClassCode());
		   exam.setExamStart(exam.getExamStart().substring(2));
		      exam.setExamEnd(exam.getExamEnd().substring(2));
		   System.out.println("exam:"+exam);
			cnt=service.examInsertGo(exam);
		   
			service.colExamgo(cnt,exam);
			
		
			String url="redirect:studentmanage_exam.go";
	   return url;
} 	   
	   
	   //Pdf 생성하기
	   @RequestMapping(value="/problemPdf", method = RequestMethod.GET)
       public String problemPdf(ExamInsertCommand exam,Model md,HttpServletRequest request,String examCode)throws Exception{
			List<ProblemVO>getExamProblemList=service.getExamProblem(examCode);
			List<List<ProblemVO>>previewPrList=service.getExamSendGo(getExamProblemList);
			int cnt=0; 
			   for(int i=0;i<previewPrList.size();i++) {
				   for(int j=0;j<previewPrList.get(i).size();j++) {
					   if(i>=1) {
						   if(j==0) {
							   cnt+=previewPrList.get(i-1).size();
						   }
						   previewPrList.get(i).get(j).setExamNo(cnt+(j+1));
					   }else {
						   previewPrList.get(i).get(j).setExamNo((j+1));
					   }
					   
				   }
			   }
			  md.addAttribute("previcePrList",previewPrList);
			  md.addAttribute("examCode",examCode); 
			String url="teacher/problemPdf";
	  
		return url;
} 	   
	   
	   @RequestMapping(value="/answerProblem", method = RequestMethod.GET)
       public String answerProblem(HttpServletRequest request,String examCode,Model md,String proNo)throws Exception{
		                System.out.println("examCode잘왔나?:"+examCode);
		                WrongVO wrong=service.wrongGet(examCode);
		               
		                Map<String,Object>problemData=service.getProblem(wrong.getProblemCode());
		                ProblemVO problem=(ProblemVO)problemData.get("problem");
		                String jimoon=String.valueOf(problemData.get("jimoon"));
		                problemData.put("examCode",examCode);
		                problemData.put("pno",proNo);
		                System.out.println(wrong.getQuestion());
		                problemData.put("que",wrong.getQuestion());
		                problemData.put("idim",wrong.getId());
		               HttpSession session=request.getSession();
		               String answerId=((MemberVO)session.getAttribute("loginUser")).getId();
		               problemData.put("answerId",answerId);
		                md.addAttribute("dataMap",problemData);
		                
			String url="teacher/answerProblem";
	  
		return url;
} 	   
	   
	   @RequestMapping(value="/modifyAnswer", method = RequestMethod.GET)
       public String modifyAnswer(HttpServletRequest request,String examCode,Model md,String proNo,String quid)throws Exception{
		                System.out.println("examCode잘왔나?:"+examCode);
		                WrongVO wrong=service.wrongGet(examCode);
		                Map<String,Object>problemData=service.getProblem(wrong.getProblemCode());
		                ProblemVO problem=(ProblemVO)problemData.get("problem");
		                String jimoon=String.valueOf(problemData.get("jimoon"));
		                HttpSession session=request.getSession();
			               String answerId=((MemberVO)session.getAttribute("loginUser")).getId();
		                problemData.put("examCode",examCode);
		                problemData.put("pno",proNo);
		                problemData.put("idim",wrong.getId());
		                System.out.println(wrong.getQuestion());
		                problemData.put("que",wrong.getQuestion());
		                problemData.put("answer",wrong.getAnswer());
		                problemData.put("answerId",answerId);
		                System.out.println(problemData);
		                System.out.println("오답한 아이디:"+wrong.getId());
		                
		                
		                
		                
		                
		                
		                md.addAttribute("dataMap",problemData);
		                
			String url="teacher/modifyAnswer";
	  
		return url;
} 	   	   
	   
	   
	   
	   @RequestMapping(value="/answerInput", method = RequestMethod.GET)
       public String answerInput(HttpServletRequest request,String examCode,Model md,String answer,String id,String answerId)throws Exception{
		               int cnt=service.insertWrongAnswer(examCode,answer);
		             
		           
		    		
		    			
		    			//쪽지를 받을 사람
		    		     List<String> to = new ArrayList<String>();
		    		     to.add(id);
		    		      
		    		     //쪽지를 보내는 사람
		    		
		    		     String from = answerId;
		    		      
		    		     String title= "질문에대한 답변이에요~";
		    		     String content= "답변내용 내용 : " + answer;
		    		     dmService.sendDm(to, from, title, content);
		    			
		    	
		               

		                
		                
		                
			String url="teacher/answerResult";
	  
		return url;
} 	      
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
}
