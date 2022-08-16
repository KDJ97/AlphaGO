package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.PdsVO;
import kr.or.ddit.dto.StudentVO;

public interface PacounseltDAO {

	// 상담 신청 리스트

	List<PacounseltVO> selectCounseltList() throws Exception;

	List<PacounseltVO> selectCounseltList(Criteria cri) throws Exception;

	int selectCounseltListCount(SearchCriteria cri) throws Exception;

	// 검색 결과의 전체 리스트 개수
	int selectSearchCounseltListCount(SearchCriteria cri) throws Exception;

	List<PacounseltVO> selectSearchCounseltList(SearchCriteria cri) throws SQLException;

	// 이름조회 이름 가져오기
	String selectName(Integer pcCode) throws Exception;

	// 아이디 가져오기
	String selectId(Integer pcCode) throws Exception;
	// String selectName()throws Exception;

	// 상담 완료 리스트

	List<PacounseltVO> selectCounseltEndList() throws Exception;

	List<PacounseltVO> selectCounseltEndList(Criteria cri) throws Exception;

	int selectCounseltEndListCount(SearchCriteria cri) throws Exception;

	// 검색 결과의 전체 리스트 개수
	int selectSearchCounseltEndListCount(SearchCriteria cri) throws Exception;

	List<PacounseltVO> selectSearchCounseltEndList(SearchCriteria cri) throws SQLException;

	PacounseltVO selectCounseltByPcCode(int pcCode) throws SQLException;

	// 결과,후속처리 등록
	int updateCounseltDetailList(PacounseltVO paco) throws SQLException;

	String selectFuUniv(Integer pcCode) throws Exception;

	// 원생 희망대학
	// PacounseltVO selectFuUniv(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode2(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode3(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode4(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode5(int pcCode) throws SQLException;

	public PacounseltVO selectPacounseltByPcCode6(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin2(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin3(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin4(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin5(int pcCode) throws SQLException;

	public PacounseltVO selectSchoolnaesin6(int pcCode) throws SQLException;

	// 원생 성적평균조회
	public PacounseltVO selectStudentGrade(int pcCode) throws SQLException;

	String selectSuUniv(Integer pcCode) throws Exception;

	String selectStudentPhone(Integer pcCode) throws SQLException;

	// 하향대학
	List<PacounseltVO> selectLowUniversity(int pcCode) throws Exception;
	// 적정대학

	List<PacounseltVO> selectPosibleUniversity(int pcCode) throws Exception;

	// 상향대학

	List<PacounseltVO> selectOverUniversity(int pcCode) throws Exception;

	public PacounseltVO selectFisrtHighSchool(int pcCode) throws SQLException;

	public PacounseltVO selectScoreHighSchool(int pcCode) throws SQLException;

	public PacounseltVO selectFisrtPosibleSchool(int pcCode) throws SQLException;

	public PacounseltVO selectFisrtPosibleScoreSchool(int pcCode) throws SQLException;

	public PacounseltVO selectFisrtDownSchool(int pcCode) throws SQLException;

	public PacounseltVO selectFisrtDownScoreSchool(int pcCode) throws SQLException;

	public PacounseltVO selectSecondHighSchool(int pcCode) throws SQLException;

	public PacounseltVO selectSecondScorePossibleSchool(int pcCode) throws SQLException;

	public PacounseltVO selectThirdPossibleSchool(int pcCode) throws SQLException;

	public PacounseltVO selectSecondOverSchool(int pcCode) throws SQLException;

	public PacounseltVO selectThirdOverSchool(int pcCode) throws SQLException;

	public PacounseltVO selectSecondDownSchool(int pcCode) throws SQLException;

	public PacounseltVO selectThirdDownSchool(int pcCode) throws SQLException;

	int insertCalender(PacounseltVO paco) throws SQLException;

	PacounseltVO selectPacounseltBypcCodeStatus(int pcCode) throws SQLException;

	List<PacounseltVO> selectCounseltListstatus() throws Exception;

	// 캘린더 삭제
	public void deletePacounselt(int pcCode) throws SQLException;

	int modifyCalender(PacounseltVO paco) throws SQLException;

	//상담 연기
	public void updatePacounselt(String pcCode) throws SQLException;

	//시퀀스
	public int selectNextSeq() throws SQLException;

	void intsertPacounselt(PacounseltVO pvo) throws SQLException;

}













