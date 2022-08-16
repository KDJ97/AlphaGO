package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@Controller
@RequestMapping("/mattend")
public class MattendController {

	private static final String List = null;

	@Autowired

	private StudentService studentService;

	@Autowired
	private TeacherMasService teacherMasService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private PacounseltService counseltService;

	@RequestMapping("/list")
	public String attend(SearchCriteria cri, HttpSession session, Model model) throws Exception {
		String url = "mattend/list";
		Map<String, Object> dataMap = null;

		try {
			// dataMap =counseltService.getCounseltList(cri,counCode);
			dataMap = teacherMasService.getTeacherAttendList(cri);

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

	@RequestMapping("/detail")
	public String detail(Criteria cri, String id,HttpSession session,
			Model model) throws Exception {

		String url = "mattend/detail";

		Map<String, Object> dataMap = null;
		Map<String, Object> data = null;

		// dataMap =counseltService.getCounseltList(cri,counCode);
		dataMap = teacherMasService.getTeacherAllAttendList(id);
		data=teacherMasService.selectClassTeacheringById(id);

		List<TeachermasVO> totalList = teacherMasService.selectAllAttendTeacherByChartId(id);

		int day1 = 0;
		int day2 = 0;
		int day3 = 0;
		int day4 = 0;
		int day5 = 0;

		for (TeachermasVO teamas : totalList) {
			if (teamas.getAttendanceStatus() == 1)
				day1++;
			if (teamas.getAttendanceStatus() == 2)
				day2++;
			if (teamas.getAttendanceStatus() == 3)
				day3++;
			if (teamas.getAttendanceStatus() == 4)
				day4++;
			if (teamas.getAttendanceStatus() == 5)
				day5++;

		}
		Map<String, Integer> dayMap = new HashMap<String, Integer>();
		dayMap.put("day1", day1);
		dayMap.put("day2", day2);
		dayMap.put("day3", day3);
		dayMap.put("day4", day4);
		dayMap.put("day5", day5);
		
		TeachermasVO abc=teacherMasService.selectTeacherAttendDetail(id);
		
		//선생출석상세
		model.addAttribute("abc",abc);
		
		//시작일과 마감일사이에 리스트
		model.addAttribute("data",data);
		
		//출석율 나타내기
		model.addAttribute("dayMap", dayMap);
		
		//전체 출석 리스트
		model.addAttribute("dataMap", dataMap);

		return url;

	}

}
