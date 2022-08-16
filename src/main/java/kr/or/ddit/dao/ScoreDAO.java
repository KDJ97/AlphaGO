package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SHUnivVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SubAreaVO;

public interface ScoreDAO {
	public List<SchoolScoreVO> selectSchoolScoreListByTestName(SchoolScoreVO score) throws SQLException;

	public void deleteScoreData(int sscode) throws SQLException;

	public void insertScore(SchoolScoreVO score) throws SQLException;

	public int selectNextSeq() throws SQLException;

	public void modifyScore(SchoolScoreVO score) throws SQLException;

	public List<SchoolScoreVO> selectAllScoreList(String id) throws SQLException;
	public List<SchoolScoreVO> selectAllScoreList(String id, int subjectCode) throws SQLException;


	public List<AcademyScoreVO> selectAcademyScoreListByClassCode(String id, int classCode) throws SQLException;

	public String selectExamName(int code) throws SQLException;

	public double selectAvgByCode(int examCode) throws SQLException;

	public List<Map<String, String>> selectExamScoreBySubjectCode(String id, int subjectCode) throws SQLException;

	public List<Map<String, String>> selectAllExamScoreBySubjectCode(int subjectCode) throws SQLException;


	/**
	 * 학생이 본 시험 과목별 과목영역 문제 리스트
	 * @param id 학생 id
	 * @param subjectCode 과목코드
	 * @return
	 * 		PROBLEM_CODE : 문제번호
	 * 		SANO : 과목영역번호
	 *  	SANAME : 과목 영역이름
	 *  	SUBJECT_NAME : 과목이름
	 * @throws SQLException
	 */
	public List<Map<String, String>> selectSubAreaListBySubjectProblem(String id, int subjectCode) throws SQLException;


	/**
	 * 학생이 본 시험의 과목별 과목영역, 틀린문제 리스트
	 * @param id 학생 id
	 * @param subjectCode 과목코드
	 * @return
	 * 		PROBLEM_CODE : 문제번호
	 * 		SANO : 과목영역번호
	 *  	SANAME : 과목 영역이름
	 *  	SUBJECT_NAME : 과목이름
	 * @throws SQLException
	 */
	public List<Map<String, String>> selectSubAreaListBySubjectWorngProblem(String id, int subjectCode) throws SQLException;

	/**
	 * 과목별 세부과목 영역리스트
	 * @param code
	 * @return 과목영역리스트
	 * @throws SQLException
	 */
	public List<SubAreaVO> selectSubAreaListBySubject(int code) throws SQLException;

	public List<AcademyScoreVO> selectAcademyScoreListBySubjectCodeAndId(String id, int subjectCode) throws SQLException;

	/**
	 * 적정대학 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<PacounseltVO> selectPosibleUniversity(String id) throws SQLException;

	/**
	 * 상향대학 이름 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<PacounseltVO> selectOverUniversity(String id) throws SQLException;

	/**
	 * 하향대학 이름 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<PacounseltVO> selectLowUniversity(String id) throws SQLException;
}
