package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dao.MemberDAO;
import kr.or.ddit.dao.UniversityDAO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SHUnivVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.exception.InvalidPasswordException;
import kr.or.ddit.exception.NotFoundIdException;

public class MemberServiceImpl implements MemberService {

	private MemberDAO memberDAO;
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}

	private UniversityDAO universityDAO;
	public void setUniversityDAO(UniversityDAO universityDAO) {
		this.universityDAO = universityDAO;
	}

	@Override
	public void enabled(String id, int state) throws Exception {
		memberDAO.enabledMember(id, state);
	}

	@Override
	public MemberVO getMember(String id) throws Exception {
		MemberVO member = memberDAO.selectMemberById(id);
		return member;
	}

	@Override
	public List<MemberVO> getMemberList() throws Exception {
		return memberDAO.selectMemberList();
	}

	@Override
	public List<MemberVO> getMemberListByAuthority(String authority) throws Exception {
		List<MemberVO> memberList = new ArrayList<MemberVO>();

		switch (authority) {
		case "all":
			memberList = memberDAO.selectMemberList();
			break;
		default:
			memberList = memberDAO.selectMemberListByAuthority(authority);
			break;

		}
		return memberList;
	}

	@Override
	public List<MemberVO> getMemberList(Criteria cri) throws Exception {
		return null;
	}

	@Override
	public Map<String, Object> getMemberListForPage(Criteria cri) throws Exception {

		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(memberDAO.selectSearchMemberListCount(searchCri));

		List<MemberVO> memberList = memberDAO.selectMemberList(searchCri);

		dataMap.put("memberList", memberList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public void modify(MemberVO member) throws Exception {
		memberDAO.updateMember(member);

		//희망대학 정보 수정
		String fu_code = memberDAO.selectUniCodeByUniName(member.getFuUni());
		String su_code = memberDAO.selectUniCodeByUniName(member.getSuUni());
		String tu_code = memberDAO.selectUniCodeByUniName(member.getTuUni());


		SHUnivVO sh_univ = memberDAO.selectSHUniv(member.getId());

		if(sh_univ == null) {

			int code = memberDAO.selectSHUnivNextSeq();

			sh_univ = new SHUnivVO();
			sh_univ.setShCode("un" + code);
			sh_univ.setId(member.getId());

			memberDAO.insertSHUniv(sh_univ);
		}

		sh_univ.setUnivCode1(String.valueOf(fu_code));
		sh_univ.setUnivCode2(String.valueOf(su_code));
		sh_univ.setUnivCode3(String.valueOf(tu_code));

		memberDAO.updateSHUniv(sh_univ);


	}

	@Override
	public Map<String, UniversityVO> getSHUniList(String id) throws SQLException {
		Map<String, UniversityVO> dataMap = new HashMap<String, UniversityVO>();
		SHUnivVO sh_univ = memberDAO.selectSHUniv(id);
		if(sh_univ != null) {
			String fuCode = sh_univ.getUnivCode1();
			String suCode = sh_univ.getUnivCode2();
			String tuCode = sh_univ.getUnivCode3();

			UniversityVO fuUni = universityDAO.selectUniByCode(fuCode);
			UniversityVO suUni = universityDAO.selectUniByCode(suCode);
			UniversityVO tuUni = universityDAO.selectUniByCode(tuCode);

			dataMap.put("fuUni", fuUni);
			dataMap.put("suUni", suUni);
			dataMap.put("tuUni", tuUni);
		}
		return dataMap;
	}

	@Override
	public void regist(MemberVO member) throws Exception {
		memberDAO.insertMember(member);
	}

	@Override
	public void remove(String id) throws Exception {
		memberDAO.deleteMember(id);

	}

	@Override
	public void login(String id, String pwd) throws NotFoundIdException, InvalidPasswordException, SQLException {
		MemberVO member = memberDAO.selectMemberById(id);
		if (member == null)
			throw new NotFoundIdException();
		if (!pwd.equals(member.getPwd()))
			throw new InvalidPasswordException();

	}

	@Override
	public List<Map<String, String>> selectMemberTodayClass(String id) throws SQLException {
		List<Map<String, String>> list = memberDAO.selectMemberTodayClass(id);

		// 정렬

		Collections.sort(list, new Comparator<Map<String, String>>() {
			@Override
			public int compare(Map<String, String> o1, Map<String, String> o2) {
				String time1 = (String) o1.get("STARTTIME");
				String time2 = (String) o2.get("STARTTIME");
				return time1.compareTo(time2);
			}
		});

		return list;
	}

	@Override
	public List<TimeTableCommand> getTimeTable(String id) throws SQLException {
		return memberDAO.selectTimeTable(id);
	}

	@Override
	public List<TimeTableCommand> getTimeTableForTeacher(String id) throws SQLException {
		return memberDAO.selectTimeTableForTeacher(id);
	}





}
