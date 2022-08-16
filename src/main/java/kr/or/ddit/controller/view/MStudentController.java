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
import kr.or.ddit.command.StudentRegistCommand;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mstudent")
public class MStudentController {

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

	@RequestMapping("/schoolgrade")
	public String schoolgrade() throws Exception {
		String url = "mstudent/schoolgrade";
		return url;
	}

	@RequestMapping("/academygrade")
	public String academygrade() throws Exception {
		String url = "mstudent/academygrade";
		return url;
	}

	@RequestMapping("/list")
	public String studentlist(String id, SearchCriteria cri, HttpSession session, Model model) throws SQLException {
		String url = "mstudent/list";

		Map<String, Object> dataMap = null;
		Map<String, Object> dat = null;

		try {

			dataMap = studentService.getStudentList(cri, id);
			dat = studentService.selectHopeSchool(id);
//         if(true) throw new SQLException();

		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}
		// StudentVO stst=studentService.selectFirstHopeSchool(id);
		// model.addAttribute("stst",stst);
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("dat", dat);

		return url;
	}

	@RequestMapping(value = "/registStudent", method = RequestMethod.GET)
	public String registForm() {
		String url = "mstudent/registStudent";
		return url;
	}
	@RequestMapping(value = "/webcapture", method = RequestMethod.GET)
	public String webcapture() {
		String url = "mstudent/webcapture";
		return url;
	}


	@RequestMapping(value = "/registStudent", method = RequestMethod.POST)
	public String regist(StudentRegistCommand studentReq) throws Exception {
		String url = "mstudent/registstudent_success";
		StudentVO student = studentReq.toStudentVO();
		String path = picturePath;
		studentService.regist(student,path);

		return url;
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam(value = "id") String id) throws Exception {
		String url = "mstudent/removestudent_success";

		System.out.println(id);

		studentService.remove(id);

		// DB삭제

		return url;
	}
}
