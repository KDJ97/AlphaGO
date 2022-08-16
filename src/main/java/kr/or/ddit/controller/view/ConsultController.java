package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.bytecode.LineNumberAttribute.Pc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.CounseltVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.service.CalendarService;
import kr.or.ddit.service.CounseltService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.PacounseltService;

@Controller
@RequestMapping("/consulting")
public class ConsultController {

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private PacounseltService pacounseltService;

	@Autowired
	private CounseltService counseltService;

	@RequestMapping("/insert")
	public String insert() throws Exception {
		String url = "consulting/insert";
		return url;
	}

	@RequestMapping("/registCounselt")
	public String registCounselt(CounseltVO con) throws Exception {
		String url = "redirect:list.go";

		counseltService.registCounselt(con);

		return url;
	}

	@RequestMapping("/registPacounselt")
	public String registPacounselt(PacounseltVO pvo) throws Exception {
		String url = "redirect:list.go";

		Map<String, UniversityVO> uniMap =memberService.getSHUniList(pvo.getClient());
		pvo.setFuCode(uniMap.get("fuUni").getUnivCode());
		pvo.setSuCode(uniMap.get("suUni").getUnivCode());
		pvo.setTuCode(uniMap.get("tuUni").getUnivCode());

		pacounseltService.registPacounselt(pvo);

		return url;
	}

	@RequestMapping("/detail")
	public String detail() throws Exception {
		String url = "consulting/detail";
		return url;
	}

	@RequestMapping("/insertdetail")
	public String insertdetail() throws Exception {
		String url = "consulting/insertdetail";
		return url;
	}
	@RequestMapping("/list")
	public String list(HttpSession session, Model model) throws Exception {
		String url = "consulting/list";

		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		//신청중인 상담내역 리스트
		List<CounseltVO> counList = counseltService.selectApplyingCounselt(member.getId());
		List<PacounseltVO> pacounList = counseltService.selectApplyingPacounselt(member.getId());
		List<Map<String, Object>> applyList = makeApplyList(counList, pacounList);

		//신청중이 아닌 상담내역 리스트
		counList = counseltService.selectAppliedCounselt(member.getId());
		pacounList = counseltService.selectAppliedPacounselt(member.getId());
		List<Map<String, Object>> appliedList = makeApplyList(counList, pacounList);

		model.addAttribute("applyList", applyList);
		model.addAttribute("appliedList", appliedList);

		return url;
	}


	private List<Map<String, Object>> makeApplyList(List<CounseltVO> counList , List<PacounseltVO> pacounList) throws Exception{
		SimpleDateFormat formatterStart = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		SimpleDateFormat formatterEnd = new SimpleDateFormat("HH:mm");

		SimpleDateFormat formatterDate = new SimpleDateFormat("yyyy-MM-dd");

		List<Map<String, Object>> applyList = new ArrayList<Map<String,Object>>();

		for(CounseltVO coun : counList) {
			Map<String, Object> apply = new HashMap<String, Object>();
			String format = formatterStart.format(coun.getConStart()) + " ~ " + formatterEnd.format(coun.getConEnd());
			String name = memberService.getMember(coun.getCounselor()).getName();

			apply.put("time", format);
			apply.put("meetday",formatterDate.format(coun.getConStart()));
			apply.put("name", name +" 강사");
			apply.put("purpose", coun.getPurpose());
			apply.put("code", coun.getCounCode());
			apply.put("type", "counselt");
			apply.put("status", coun.getStatus());

			apply.put("start", formatterEnd.format(coun.getConStart()));
			apply.put("end", formatterEnd.format(coun.getConEnd()));

			applyList.add(apply);
		}

		for(PacounseltVO pacoun : pacounList) {
			Map<String, Object> apply = new HashMap<String, Object>();
			String format = formatterStart.format(pacoun.getPcStart()) + " ~ " + formatterEnd.format(pacoun.getPcEnd());
			String name = memberService.getMember(pacoun.getCounSelor()).getName();

			apply.put("time", format);
			apply.put("name", name +" 원장");
			apply.put("purpose", pacoun.getPurpose());
			apply.put("code", pacoun.getPcCode());
			apply.put("type", "pacounselt");
			apply.put("status", pacoun.getStatus());
			apply.put("meetday",formatterDate.format(pacoun.getMeetDate()));

			apply.put("start", formatterEnd.format(pacoun.getPcStart()));
			apply.put("end", formatterEnd.format(pacoun.getPcEnd()));

			applyList.add(apply);
		}

		// time(String) 오름차순
		Collections.sort(applyList, new Comparator<Map<String, Object>>() {
			@Override
			public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				String time1 = (String) o1.get("time");
				String time2 = (String) o2.get("time");
				return time1.compareTo(time2);
			}
		});

		return applyList;
	}

	@ResponseBody
	@RequestMapping(value = "/calenderData", method = RequestMethod.GET)
	public ResponseEntity<List<CalenderListCommand>> calendar(HttpSession session) throws Exception{

		ResponseEntity<List<CalenderListCommand>> entity = null;
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id=member.getId();
		List<CalenderListCommand> list = null;

		try {
			list = calendarService.getCalendarDataForSubmit(id);

			entity = new ResponseEntity<List<CalenderListCommand>>(list, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<List<CalenderListCommand>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/getCounselorList", method = RequestMethod.GET)
	public List<MemberVO> getCounselorList(String authority) throws Exception{
		return memberService.getMemberListByAuthority(authority);
	}

	@ResponseBody
	@RequestMapping(value = "/getReservationList", method = RequestMethod.GET)
	public List<String> getReservationList(String date, String type, String counselor) throws Exception{
		List<String> list = calendarService.getReservationList(date, type, counselor);
		return list;

	}

	@ResponseBody
	@RequestMapping(value = "/cancelCounselor", method = RequestMethod.POST)
	public void cancelCounselor(int code, String type) throws Exception{
		switch (type) {
		case "counselt":
			counseltService.deleteCounselt(code);
			break;
		case "pacounselt":
			counseltService.deletePacounselt(code);
			break;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/getCounselorData", method = RequestMethod.GET)
	public Object getCounselorData(int code, String type) throws Exception{
		SimpleDateFormat formatterDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatterTime = new SimpleDateFormat("HH:mm");
		Map<String, Object> data = new HashMap<String, Object>();
		String name = null;

		switch (type) {
		case "counselt":
			CounseltVO coun = counseltService.selectCounselt(code);
			name = memberService.getMember(coun.getCounselor()).getName();

			data.put("code",  coun.getCounCode());
			data.put("date", formatterDate.format(coun.getMeetdate()));
			data.put("start", formatterTime.format(coun.getConStart()));
			data.put("end", formatterTime.format(coun.getConEnd()));
			data.put("name", name +" 강사");
			data.put("purpose", coun.getPurpose());
			data.put("status", coun.getStatus());
			data.put("content", coun.getContent());
			data.put("result", coun.getResult());

			break;
		case "pacounselt":
		    PacounseltVO pacoun = counseltService.selectPacounselt(code);
			name = memberService.getMember(pacoun.getCounSelor()).getName();

			data.put("code", pacoun.getPcCode());
			data.put("date", formatterDate.format(pacoun.getMeetDate()));
			data.put("start", formatterTime.format(pacoun.getPcStart()));
			data.put("end", formatterTime.format(pacoun.getPcEnd()));
			data.put("name", name +" 원장");
			data.put("purpose", pacoun.getPurpose());
			data.put("status", pacoun.getStatus());
			data.put("content", pacoun.getContent());
			data.put("result", pacoun.getResult());
			break;

		}

		return data;
	}

	@ResponseBody
	@RequestMapping(value = "/getCounseltListByDate", method = RequestMethod.GET)
	public List<Map<String, Object>> getCounseltListByDate(HttpSession session, String date) throws Exception{
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		List<Map<String, Object>> data = new ArrayList<Map<String,Object>>();

		//신청중인 상담내역 리스트
		List<CounseltVO> counList = counseltService.selectApplyingCounselt(member.getId());
		List<PacounseltVO> pacounList = counseltService.selectApplyingPacounselt(member.getId());
		List<Map<String, Object>> applyList = makeApplyList(counList, pacounList);

		for(Map<String, Object> map : applyList) {
			if(map.get("meetday").equals(date)) {
				data.add(map);
			}
		}

		return data;
	}

}
