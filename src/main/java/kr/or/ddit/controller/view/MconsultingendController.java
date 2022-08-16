package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mconsultingend")
public class MconsultingendController {

	@Autowired

	private StudentService studentService;

	@Autowired
	private TeacherMasService teacherMasService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private PacounseltService counseltService;

	@RequestMapping("/list")
	public String consultend(SearchCriteria cri, HttpSession session, Model model, Integer pcCode) throws Exception {
		String url = "mconsultingend/list";
		Map<String, Object> dataMap = null;

		try {
			// dataMap =counseltService.getCounseltList(cri,counCode);
			dataMap = counseltService.getCounseltEndList(cri, pcCode);
//         if(true) throw new SQLException();

		} catch (SQLException e) {

			e.printStackTrace();
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);

		return url;
	}

	@ResponseBody
	@RequestMapping(value = "/registconend", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<Integer> registconend(@RequestBody PacounseltVO paco) throws Exception {

		ResponseEntity<Integer> entity = null;
		System.out.println(paco);

		try {

			int result = counseltService.updateCounseltDetailList(paco);
			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

}
