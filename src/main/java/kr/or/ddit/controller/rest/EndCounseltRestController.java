package kr.or.ddit.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.command.PacounseltRegistCommand;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.TeachermasVO;
import kr.or.ddit.service.PacounseltService;

@RestController
@RequestMapping("/mconsultingend")
public class EndCounseltRestController {

	@Autowired
	private PacounseltService pacounseltService;

	@RequestMapping(value = "/conenddetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<PacounseltVO> conenddetail(@RequestParam(value = "pcCode") int pcCode) throws Exception {

		ResponseEntity<PacounseltVO> entity = null;

		System.out.println(pcCode);

		PacounseltVO pacounVO = null;

		try {
			// pacounVO=pacounseltService.get teacherMasService.getTeacher(id);
			pacounVO = pacounseltService.getCounseltEnd(pcCode);

			entity = new ResponseEntity<PacounseltVO>(pacounVO, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<PacounseltVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;

	}

}
