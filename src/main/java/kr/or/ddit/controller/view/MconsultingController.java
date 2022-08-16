package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mconsulting")
public class MconsultingController {

	@Autowired

	private StudentService studentService;

	@Autowired
	private TeacherMasService teacherMasService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private PacounseltService counseltService;

	@RequestMapping("/list")
	public String consultlist(SearchCriteria cri, HttpSession session, Model model, Integer pcCode) throws Exception {
		String url = "mconsulting/list";
		Map<String, Object> dataMap = null;
		Map<String, Object> da = null;
		

		try {
			// dataMap =counseltService.getCounseltList(cri,counCode);
			dataMap = counseltService.getCounseltList(cri, pcCode);
			da = counseltService.getselectCounseltListstatus();
//         if(true) throw new SQLException();

		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);
		model.addAttribute("da", da);

		return url;
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam(value = "pcCode") int pcCode) throws Exception {
		String url = "mconsulting/remove_calender";

		counseltService.removecalender(pcCode);

		// DB삭제

		return url;
	}

	@RequestMapping("/detail")
	public String analysis(HttpServletRequest request,SearchCriteria cri, Integer pcCode, String from, Model model) throws Exception {
		String url = "mconsulting/detail";
		
		String names = request.getParameter("name");
		model.addAttribute("name",names);
		
		String pcCodes = request.getParameter("pcCode");
		model.addAttribute("pcCode",pcCode);
		Map<String, Object> dataMap = null;
		Map<String, Object> dat = null;
		Map<String, Object> data = null;
		Map<String, Object> dataMa = null;
		dataMap = counseltService.getCounseltList(cri, pcCode);
		dataMa = counseltService.getOverUniversityList(pcCode);
		data = counseltService.getPosibleUniversityList(pcCode);
		dat = counseltService.getlowUniversityList(pcCode);
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("dat", dat);
		model.addAttribute("data", data);
		model.addAttribute("dataMa", dataMa);
		PacounseltVO cou = counseltService.getPacounselt(pcCode);
		PacounseltVO abc = counseltService.selectPacounseltByPcCode2(pcCode);
		PacounseltVO cde = counseltService.selectPacounseltByPcCode3(pcCode);
		PacounseltVO efg = counseltService.selectPacounseltByPcCode4(pcCode);
		PacounseltVO ab = counseltService.selectPacounseltByPcCode5(pcCode);
		PacounseltVO cd = counseltService.selectPacounseltByPcCode6(pcCode);
		PacounseltVO a = counseltService.selectSchoolnaesin(pcCode);
		PacounseltVO b = counseltService.selectSchoolnaesin2(pcCode);
		PacounseltVO c = counseltService.selectSchoolnaesin3(pcCode);
		PacounseltVO e = counseltService.selectSchoolnaesin4(pcCode);
		PacounseltVO f = counseltService.selectSchoolnaesin5(pcCode);
		PacounseltVO g = counseltService.selectSchoolnaesin6(pcCode);
		PacounseltVO h = counseltService.selectStudentGrade(pcCode);
		PacounseltVO i = counseltService.selectFisrtHighSchool(pcCode);
		PacounseltVO j = counseltService.selectScoreHighSchool(pcCode);

		model.addAttribute("cou", cou);
		model.addAttribute("abc", abc);
		model.addAttribute("cde", cde);
		model.addAttribute("efg", efg);
		model.addAttribute("ab", ab);
		model.addAttribute("cd", cd);
		model.addAttribute("a", a);
		model.addAttribute("b", b);
		model.addAttribute("c", c);
		model.addAttribute("e", e);
		model.addAttribute("f", f);
		model.addAttribute("g", g);
		model.addAttribute("h", h);
		model.addAttribute("i", i);
		model.addAttribute("j", j);
		PacounseltVO k = counseltService.selectFisrtPosibleSchool(pcCode);
		model.addAttribute("k", k);
		PacounseltVO o = counseltService.selectFisrtPosibleScoreSchool(pcCode);
		model.addAttribute("o", o);
		PacounseltVO m = counseltService.selectFisrtDownSchool(pcCode);
		model.addAttribute("m", m);
		PacounseltVO n = counseltService.selectFisrtDownScoreSchool(pcCode);
		model.addAttribute("n", n);
		PacounseltVO sf = counseltService.selectSecondHighSchool(pcCode);
		model.addAttribute("sf", sf);

		PacounseltVO ss = counseltService.selectSecondScorePossibleSchool(pcCode);
		model.addAttribute("ss", ss);

		PacounseltVO si = counseltService.selectThirdPossibleSchool(pcCode);
		model.addAttribute("si", si);
		PacounseltVO tt = counseltService.selectSecondOverSchool(pcCode);
		model.addAttribute("tt", tt);

		PacounseltVO ta = counseltService.selectThirdOverSchool(pcCode);
		model.addAttribute("ta", ta);

		PacounseltVO ds = counseltService.selectSecondDownSchool(pcCode);
		model.addAttribute("ds", ds);
		PacounseltVO dt = counseltService.selectThirdDownSchool(pcCode);
		model.addAttribute("dt", dt);
		return url;
	}

	@RequestMapping("/pdfprpr")
	public String pdfprpr(SearchCriteria cri, Integer pcCode, String from, Model model) throws Exception {
		String url = "mconsulting/pdfprpr";

		Map<String, Object> dataMap = null;
		Map<String, Object> dat = null;
		Map<String, Object> data = null;
		Map<String, Object> dataMa = null;
		dataMap = counseltService.getCounseltList(cri, pcCode);
		dataMa = counseltService.getOverUniversityList(pcCode);
		data = counseltService.getPosibleUniversityList(pcCode);
		dat = counseltService.getlowUniversityList(pcCode);
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("dat", dat);
		model.addAttribute("data", data);
		model.addAttribute("dataMa", dataMa);
		PacounseltVO cou = counseltService.getPacounselt(pcCode);
		PacounseltVO abc = counseltService.selectPacounseltByPcCode2(pcCode);
		PacounseltVO cde = counseltService.selectPacounseltByPcCode3(pcCode);
		PacounseltVO efg = counseltService.selectPacounseltByPcCode4(pcCode);
		PacounseltVO ab = counseltService.selectPacounseltByPcCode5(pcCode);
		PacounseltVO cd = counseltService.selectPacounseltByPcCode6(pcCode);
		PacounseltVO a = counseltService.selectSchoolnaesin(pcCode);
		PacounseltVO b = counseltService.selectSchoolnaesin2(pcCode);
		PacounseltVO c = counseltService.selectSchoolnaesin3(pcCode);
		PacounseltVO e = counseltService.selectSchoolnaesin4(pcCode);
		PacounseltVO f = counseltService.selectSchoolnaesin5(pcCode);
		PacounseltVO g = counseltService.selectSchoolnaesin6(pcCode);
		PacounseltVO h = counseltService.selectStudentGrade(pcCode);
		PacounseltVO i = counseltService.selectFisrtHighSchool(pcCode);
		PacounseltVO j = counseltService.selectScoreHighSchool(pcCode);

		model.addAttribute("cou", cou);
		model.addAttribute("abc", abc);
		model.addAttribute("cde", cde);
		model.addAttribute("efg", efg);
		model.addAttribute("ab", ab);
		model.addAttribute("cd", cd);
		model.addAttribute("a", a);
		model.addAttribute("b", b);
		model.addAttribute("c", c);
		model.addAttribute("e", e);
		model.addAttribute("f", f);
		model.addAttribute("g", g);
		model.addAttribute("h", h);
		model.addAttribute("i", i);
		model.addAttribute("j", j);
		PacounseltVO k = counseltService.selectFisrtPosibleSchool(pcCode);
		model.addAttribute("k", k);
		PacounseltVO o = counseltService.selectFisrtPosibleScoreSchool(pcCode);
		model.addAttribute("o", o);
		PacounseltVO m = counseltService.selectFisrtDownSchool(pcCode);
		model.addAttribute("m", m);
		PacounseltVO n = counseltService.selectFisrtDownScoreSchool(pcCode);
		model.addAttribute("n", n);
		PacounseltVO sf = counseltService.selectSecondHighSchool(pcCode);
		model.addAttribute("sf", sf);

		PacounseltVO ss = counseltService.selectSecondScorePossibleSchool(pcCode);
		model.addAttribute("ss", ss);

		PacounseltVO si = counseltService.selectThirdPossibleSchool(pcCode);
		model.addAttribute("si", si);
		PacounseltVO tt = counseltService.selectSecondOverSchool(pcCode);
		model.addAttribute("tt", tt);

		PacounseltVO ta = counseltService.selectThirdOverSchool(pcCode);
		model.addAttribute("ta", ta);

		PacounseltVO ds = counseltService.selectSecondDownSchool(pcCode);
		model.addAttribute("ds", ds);
		PacounseltVO dt = counseltService.selectThirdDownSchool(pcCode);
		model.addAttribute("dt", dt);
		return url;
	}

}
