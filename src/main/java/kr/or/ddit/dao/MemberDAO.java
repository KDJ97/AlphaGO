package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.math3.linear.SymmLQ;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SHUnivVO;
import kr.or.ddit.dto.TimeDetailVO;

public interface MemberDAO {

	//회원리스트 조회
	List<MemberVO> selectMemberList()throws Exception;
	List<MemberVO> selectMemberList(Criteria cri)throws Exception;

	// 일반 리스트 전체 개수
	int selectMemberListCount() throws Exception;
	// 검색 결과의 전체 리스트 개수
	int selectSearchMemberListCount(SearchCriteria cri) throws Exception;

	// 회원정보 조회
	MemberVO selectMemberById(String id) throws SQLException;

	MemberVO selectMemberByPicture(String picture) throws SQLException;

	// 회원 추가
	public void insertMember(MemberVO member) throws SQLException;

	// 회원 수정
	public void updateMember(MemberVO member) throws SQLException;

	// 회원정보 삭제
	void deleteMember(String id) throws SQLException;


	// 회원 활성화
	void enabledMember(String id, int enabled) throws SQLException;

	//역할 별 회원 리스트 목록
	List<MemberVO> selectMemberListByAuthority(String authority);

	//회원의 오늘 수업 리스트(학생기준)
	List<Map<String, String>> selectMemberTodayClass(String id) throws SQLException;

	//학생 시간표
	List<TimeTableCommand> selectTimeTable(String id) throws SQLException;

	//대학 코드
	String selectUniCodeByUniName(String name) throws SQLException;

	//희망대학 데이터
	SHUnivVO selectSHUniv(String id) throws SQLException;

	//희망대학 시퀀스
	int selectSHUnivNextSeq() throws SQLException;

	void insertSHUniv(SHUnivVO uni) throws SQLException;

	void updateSHUniv(SHUnivVO uni) throws SQLException;

	//강사 시간표
	List<TimeTableCommand> selectTimeTableForTeacher(String id) throws SQLException;
}
