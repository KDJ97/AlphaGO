package kr.or.ddit.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.CalendarService;
import kr.or.ddit.service.TeacherMasService;

@RestController
@RequestMapping("/mattend")
public class MattendRestController {

	 @Autowired
	 private TeacherMasService teachermasService;
	
		
//		
//		@RequestMapping(value="/detail",method = RequestMethod.POST, produces = "application/json;charset=utf-8")
//		public ResponseEntity<List<TeachermasVO>> list(@RequestParam(value="id")String id){
//			ResponseEntity<List<TeachermasVO>> entity = null;
//			
//			List<TeachermasVO> list = null;
//			
//			try {
//				list =teachermasService.getTeacherAllAttendList(id);
//				entity = new ResponseEntity<List<TeachermasVO>>(list, HttpStatus.OK);
//			}catch (Exception e) {
//				entity = new ResponseEntity<List<TeachermasVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
//				e.printStackTrace();
//			}
//			
//			return entity;
//		}
	}

