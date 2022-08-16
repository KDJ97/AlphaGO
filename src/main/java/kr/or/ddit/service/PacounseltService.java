package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;

public interface PacounseltService {

	Map<String, Object> getCounseltList(Criteria cri, Integer pcCode) throws SQLException;
	// Map<String, Object> getCounseltList(Criteria cri,int counCode) throws
	// SQLException;

	Map<String, Object> getselectCounseltListstatus() throws SQLException;

	// 상담 완료 리스트

	Map<String, Object> getCounseltEndList(Criteria cri, Integer pcCode) throws SQLException;

	// 상세
	public PacounseltVO getCounseltEnd(int pcCode) throws SQLException;

	// 결과,후속처리 업데이트
	// public void updateCounseltDetailList(int paco) throws SQLException;

	// 결과,후속처리 업데이트
	int updateCounseltDetailList(PacounseltVO paco) throws SQLException;

	// 희망 대학
	// public PacounseltVO getFuUniv(int pcCode)throws SQLException;

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

	public PacounseltVO getPacounselt(int pcCode) throws SQLException;

	// 원생성적
	public PacounseltVO selectStudentGrade(int pcCode) throws SQLException;

	// 합격하향예측
	Map<String, Object> getlowUniversityList(Integer pcCode) throws SQLException;

	// 적정하향예측
	Map<String, Object> getPosibleUniversityList(Integer pcCode) throws SQLException;

	// 상향하향예측
	Map<String, Object> getOverUniversityList(Integer pcCode) throws SQLException;

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

	// 캘린더 추가
	int insertCalender(PacounseltVO paco) throws SQLException;

	public PacounseltVO getpacounseltStatus(int pcCode) throws Exception;

	// 캘린더삭제
	public void removecalender(int pcCode) throws Exception;

	// 캘린더수정
	int modifyCalender(PacounseltVO paco) throws SQLException;

	/**
	 * 연기 상담 상태 업데이트
	 * @param pcCode
	 * @throws SQLException
	 */
	public void updatePacounselt(String pcCode) throws SQLException;

	void registPacounselt(PacounseltVO pvo) throws SQLException;
}










