package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.exception.InvalidPasswordException;
import kr.or.ddit.exception.NotFoundIdException;

public interface MemberService {

	//회원검색
	public List<MemberVO> getMemberList() throws Exception;
	public List<MemberVO> getMemberList(Criteria cri) throws Exception;

	public Map<String,Object> getMemberListForPage(Criteria cri)
													throws Exception;

	//회원상세
	public MemberVO getMember(String id) throws Exception;

	//회원등록
	public void regist(MemberVO member) throws Exception;

	//회원수정
	public void modify(MemberVO member)throws Exception;

	//회원탈퇴
	public void remove(String id)throws Exception;

	//회원상태변경
	void enabled(String id, int enabled)throws Exception;

	//로그인 체크
	public void login(String id, String pwd) throws NotFoundIdException, InvalidPasswordException, SQLException;


	// 역할별 회원 검색
	List<MemberVO> getMemberListByAuthority(String authority) throws Exception;


	// 오늘 수업 리스트 검색
	List<Map<String, String>> selectMemberTodayClass(String id) throws SQLException;

	//학생 시간표 데이터
	List<TimeTableCommand> getTimeTable(String id) throws SQLException;

	//강사 시간표 데이터
	List<TimeTableCommand> getTimeTableForTeacher(String id) throws SQLException;

	//학생 희망대학(1,2,3지망 정보)
	public Map<String, UniversityVO> getSHUniList(String id) throws SQLException;


}
