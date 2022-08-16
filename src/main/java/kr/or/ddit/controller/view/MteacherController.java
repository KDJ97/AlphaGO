package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.TeacherRegistCommand;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mteacher")
public class MteacherController {

	@Autowired

	private StudentService studentService;

	@Autowired
	private TeacherMasService teacherMasService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private PacounseltService counseltService;
	
	@Autowired
	String picturePath;

	@RequestMapping("/list")
	public String teacherlist(SearchCriteria cri, String subject, HttpSession session, Model model, String subjectName)
			throws Exception {
		String url = "mteacher/list";

		TeachermasVO tm = teacherMasService.selectScoreBySubjectName(subjectName);
		Map<String, Object> dataMap = null;
		try {
			dataMap = teacherMasService.getTeacherList(cri);
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}
		TeachermasVO sgh = teacherMasService.selectFinalTestBykor(subject);
		model.addAttribute("sgh", sgh);

		model.addAttribute("tm", tm);
		model.addAttribute("dataMap", dataMap);

		return url;
	}

	@RequestMapping(value = "/webcapture", method = RequestMethod.GET)
	public String webcapture() {
		String url = "mstudent/webcapture";
		return url;
	}

	@RequestMapping(value = "/registTeacher", method = RequestMethod.GET)
	public String registteacher() throws Exception {
		String url = "mteacher/registTeacher";
		return url;
	}

	@RequestMapping(value = "/registTeacher", method = RequestMethod.POST)
	public String registteacher(TeacherRegistCommand teacherReq) throws Exception {
		String url = "mteacher/registteacher_success";
		TeachermasVO teamas = teacherReq.toTeachermasVO();
		String path = picturePath;
		teacherMasService.regist(teamas,path);

		return url;
	}

	@RequestMapping(value = "/removeteacher", method = RequestMethod.POST)
	public String removeteacher(@RequestParam(value = "id") String id) throws Exception {
		String url = "mteacher/removeteacher_success";

		System.out.println(id);

		teacherMasService.remove(id);

		// DB삭제

		return url;
	}
}
