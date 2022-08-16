package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolScoreVO;

public interface ScoreService {
	public List<SchoolScoreVO> getScoreList(SchoolScoreVO score) throws SQLException;

	public void deleteScoreDate(int sscode) throws SQLException;

	public void insertScore(SchoolScoreVO score) throws SQLException;

	public void modifyScore(SchoolScoreVO score) throws SQLException;

	public Map<String, Object> getScoreListBySubjectMap(String id) throws SQLException;

	public List<AcademyScoreVO> getAcademyScoreList(String id, int classCode) throws SQLException;

	public List<ClassVO> getClassNameListById(String id) throws SQLException;

	/**
	 * 시험명과 해당 시험의 평균데이터를 반환
	 * @param examCode 시험코드
	 * @return name : 시험명, avg : 평균
	 */
	public Map<String, String> getExamData(int examCode) throws SQLException;

	public Map<String, List<Map<String, String>>> getSubjectScoreData(String id) throws SQLException;

	public Map<String, Double> getAllSubjectScoreDataAvg() throws SQLException;

	public Map<String, Object> getSubjectAreaData(String id) throws SQLException;

	/**
	 * 성적(학교,학원 성적의 과목별 이전성적 최근성적) 데이터 - 그래프 출력용
	 * @param id
	 * @return 학교 school / 학원 academy -> korAfter, korNow / engAfter...
	 * @throws SQLException
	 */
	public Map<String, Map<String, Integer>> getScoreDataForGraph(String id) throws SQLException;

	public Map<String, List<PacounseltVO>> getPredictionPassUni(String id) throws SQLException;
}
