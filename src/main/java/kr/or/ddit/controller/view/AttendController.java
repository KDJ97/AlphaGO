package kr.or.ddit.controller.view;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.AttendanceService;

@Controller
@RequestMapping("/attend")
public class AttendController {

   @Autowired
   private AttendanceService attendService;

   private static final Logger logger = LoggerFactory.getLogger(AttendController.class);

   @RequestMapping(value = "/list", method = RequestMethod.GET)
	public String assignList(Criteria cri, @RequestParam(defaultValue = "all")String month,HttpSession session, Model model) throws Exception {

	   logger.info("month : " + month);

	   String url = "attend/list";

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
}






















