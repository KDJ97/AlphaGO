package kr.or.ddit.controller.rest;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.PacounseltService;
import kr.or.ddit.service.StudentService;
import kr.or.ddit.service.TeacherMasService;

@RestController
@RequestMapping("/mconsulting")
public class ConsuletRestController {

	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private String pcStart;
	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	private String pcEnd;

	@Autowired
	private PacounseltService counseltService;

	@ResponseBody
	@RequestMapping(value = "/registcalender", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<Integer> registcalender(@RequestBody PacounseltVO paco) throws Exception {

		ResponseEntity<Integer> entity = null;
		System.out.println(paco);
		try {
			int result = counseltService.insertCalender(paco);
			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e)

		{
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	@RequestMapping(value = "/condetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<PacounseltVO> condetail(@RequestParam(value = "pcCode") int pcCode) throws Exception {

		ResponseEntity<PacounseltVO> entity = null;

		PacounseltVO pacounseltVO = null;

		try {
			pacounseltVO = counseltService.getpacounseltStatus(pcCode);

			entity = new ResponseEntity<PacounseltVO>(pacounseltVO, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<PacounseltVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

}
