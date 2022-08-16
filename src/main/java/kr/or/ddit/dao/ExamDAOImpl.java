package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.WrongVO;

public class ExamDAOImpl implements ExamDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	/**
	 * 강의 선택전 전체 미응시 시험 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<ExamVO> getExam(String id) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Exam-Mapper.getExam", id);
	}

	/**
	 * 강의 선택후 시험 리스트
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<ExamVO> selectExamList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Exam-Mapper.selectExamList", map);
	}

	/**
	 * 시험지 문제 리스트
	 */
	@Override
	public List<ProblemVO> getExamProblem(int examCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Exam-Mapper.getExamProblem", examCode);
	}

	/**
	 * 지문 유무
	 */
	@Override
	public ProblemVO getJimoon(int problemCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Exam-Mapper.getJimoon", problemCode);
	}

	/**
	 * 시험 점수 등록
	 */
	@Override
	public void insertScore(AcademyScoreVO acaVO) throws SQLException {
		session.update("Exam-Mapper.insertScore", acaVO);

	}

	/**
	 * 시퀀스 조회
	 */
	@Override
	public int selectSeq() throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Exam-Mapper.selectSeq");
	}

	/**
	 * 문제 코드 조회
	 */
	@Override
	public int selectCode(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Exam-Mapper.selectCode", map);
	}

	/**
	 * 틀린 문제 오답노트 등록
	 */
	@Override
	public void insertWrong(WrongVO wrongVO) throws SQLException {
		session.update("Exam-Mapper.insertWrong", wrongVO);

	}

	@Override
	public int selectWrongSeq() throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Exam-Mapper.selectWrongSeq");
	}

	@Override
	public AcademyScoreVO selectScore(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Exam-Mapper.selectScore", map);
	}

	@Override
	public List<WrongVO> selectWrong(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Exam-Mapper.selectWrong", map);
	}

	@Override
	public List<ExamVO> selectExamCodeListByClassCode(String id, int classCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("id", id);
		keyMap.put("classCode", classCode);

		return session.selectList("Exam-Mapper.selectExamCodeListById", keyMap);
	}

}
