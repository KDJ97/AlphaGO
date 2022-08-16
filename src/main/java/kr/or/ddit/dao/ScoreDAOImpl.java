package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SubAreaVO;

public class ScoreDAOImpl implements ScoreDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<SchoolScoreVO> selectSchoolScoreListByTestName(SchoolScoreVO score) throws SQLException {
		return session.selectList("Score-Mapper.selectSchoolScoreListByTestName", score);
	}

	@Override
	public void deleteScoreData(int sscode) throws SQLException {
		session.update("Score-Mapper.deleteScoreData", sscode);
	}

	@Override
	public void insertScore(SchoolScoreVO score) throws SQLException {
		session.update("Score-Mapper.insertScore", score);
	}

	@Override
	public int selectNextSeq() throws SQLException {
		return session.selectOne("Score-Mapper.selectNextSeq");
	}

	@Override
	public void modifyScore(SchoolScoreVO score) throws SQLException {
		session.update("Score-Mapper.modifyScore", score);
	}

	@Override
	public List<SchoolScoreVO> selectAllScoreList(String id) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("id", id);
		
		
		return session.selectList("Score-Mapper.selectAllScoreList", keyMap);
	}
	@Override
	public List<SchoolScoreVO> selectAllScoreList(String id, int subjectCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("subjectCode", subjectCode);

		return session.selectList("Score-Mapper.selectAllScoreList", keyMap);
	}


	@Override
	public List<AcademyScoreVO> selectAcademyScoreListByClassCode(String id, int classCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("classCode", classCode);

		return session.selectList("Score-Mapper.selectAcademyScoreListByClassCode", keyMap);
	}

	@Override
	public String selectExamName(int code) throws SQLException {
		return session.selectOne("Score-Mapper.selectExamNameByCode",code);
	}

	@Override
	public double selectAvgByCode(int examCode) throws SQLException {
		return session.selectOne("Score-Mapper.selectAvgByCode", examCode);
	}

	@Override
	public List<Map<String, String>> selectExamScoreBySubjectCode(String id, int subjectCode) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("id", id);
		keyMap.put("subjectCode", String.valueOf(subjectCode));

		return session.selectList("Score-Mapper.selectExamScoreBySubjectCode", keyMap);
	}

	@Override
	public List<Map<String, String>> selectAllExamScoreBySubjectCode(int subjectCode) throws SQLException {
		return session.selectList("Score-Mapper.selectAllExamScoreBySubjectCode", subjectCode);
	}


	@Override
	public List<Map<String, String>> selectSubAreaListBySubjectProblem(String id, int subjectCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("subjectCode", subjectCode);

		return session.selectList("Score-Mapper.selectSubAreaListBySubjectProblem", keyMap);
	}

	@Override
	public List<Map<String, String>> selectSubAreaListBySubjectWorngProblem(String id, int subjectCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("subjectCode", subjectCode);

		return session.selectList("Score-Mapper.selectSubAreaListBySubjectWorngProblem", keyMap);
	}

	@Override
	public List<SubAreaVO> selectSubAreaListBySubject(int code) throws SQLException {
		return session.selectList("Score-Mapper.selectSubAreaListBySubject", code);
	}

	@Override
	public List<AcademyScoreVO> selectAcademyScoreListBySubjectCodeAndId(String id, int subjectCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("subjectCode", subjectCode);

		return session.selectList("Score-Mapper.selectAcademyScoreListBySubjectCodeAndId", keyMap);
	}

	@Override
	public List<PacounseltVO> selectPosibleUniversity(String id) throws SQLException {
		return session.selectList("Score-Mapper.selectPosibleUniversity",id);
	}

	@Override
	public List<PacounseltVO> selectOverUniversity(String id) throws SQLException {
		return session.selectList("Score-Mapper.selectOverUniversity",id);
	}

	@Override
	public List<PacounseltVO> selectLowUniversity(String id) throws SQLException {
		return session.selectList("Score-Mapper.selectLowUniversity",id);
	}




}
