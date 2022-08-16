package kr.or.ddit.controller.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.CalendarService;

@RestController
@RequestMapping("/calendar")
public class CalendarController {
	
	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public ResponseEntity<List<CalenderListCommand>> list(HttpSession session){
		ResponseEntity<List<CalenderListCommand>> entity = null;
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id=member.getId();
		List<CalenderListCommand> list = null;
		
		try {
			list = calendarService.getAllCalendar(id);
			entity = new ResponseEntity<List<CalenderListCommand>>(list, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<CalenderListCommand>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		
		return entity;
	}
}
