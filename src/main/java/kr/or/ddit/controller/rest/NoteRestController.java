package kr.or.ddit.controller.rest;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.dto.DmVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.MemberService;

@RestController
@RequestMapping("/note")
public class NoteRestController {

	private static final Logger logger = LoggerFactory.getLogger(NoteRestController.class);

	@Autowired
	private MemberService memberService;

//	@Autowired
//	private DmService dmService;

	@RequestMapping(value="/getMemberList")
	public ResponseEntity<List<MemberVO>> getMemberList() throws Exception{
		ResponseEntity<List<MemberVO>> entity = null;

		List<MemberVO> memberList = null;
		try {
			memberList = memberService.getMemberList();
			entity = new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

	@RequestMapping(value="/getMemberListById")
	public ResponseEntity<List<MemberVO>> getMemberListById(@RequestParam(value="id_data[]", defaultValue = "") List<String> idList) throws Exception{
		ResponseEntity<List<MemberVO>> entity = null;

		List<MemberVO> memberList = new ArrayList<MemberVO>();
		try {
			for(String id : idList) {
				MemberVO member = memberService.getMember(id);
				if(member != null) {
					memberList.add(member);
				}
			}
			entity = new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

	@RequestMapping(value="/getMemberListByAuth")
	public ResponseEntity<List<MemberVO>> getMemberListByAuth(@RequestParam(value="authority", defaultValue = "all")String authority) throws Exception{
		ResponseEntity<List<MemberVO>> entity = null;

		List<MemberVO> memberList = new ArrayList<MemberVO>();
		try {
			memberList = memberService.getMemberListByAuthority(authority);
			entity = new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

	@RequestMapping("/searchMemberList")
	public ResponseEntity<List<MemberVO>> searchMemberList(@RequestParam(value="authority", defaultValue = "all")String authority, String value) throws Exception{
		ResponseEntity<List<MemberVO>> entity = null;
		List<MemberVO> returnList = new ArrayList<MemberVO>();

		logger.info("authority : " + authority);
		logger.info("value : " + value);

		try {
			List<MemberVO> memberList = memberService.getMemberListByAuthority(authority);
			for(MemberVO member : memberList) {
				if(value.equals(member.getId())) {
					returnList.add(member);
				}
			}



			entity = new ResponseEntity<List<MemberVO>>(returnList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

//	//상단바 알림 용
//	@RequestMapping("/notReadList")
//	public ResponseEntity<List<DmVO>> getNotReadDm(HttpSession session) {
//		ResponseEntity<List<DmVO>> entity = null;
//
//		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
//		try {
//			List<DmVO> dmList = dmService.getNotReadDm(loginUser.getId());
//			entity = new ResponseEntity<List<DmVO>>(dmList, HttpStatus.OK);
//		} catch (Exception e) {
//			entity = new ResponseEntity<List<DmVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
//			e.printStackTrace();
//		}
//
//		return entity;
//	}


}
