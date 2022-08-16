package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.WrongVO;

public interface ExamDAO {

	/**
	 * 강의 선택전 전체 미응시 시험 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<ExamVO> getExam(String id) throws SQLException;

	/**
	 * 강의 선택후 시험 리스트
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	public List<ExamVO> selectExamList(Map<String, Object> map) throws SQLException;

	/**
	 * 시험응시(시험지)
	 * @param examCode
	 * @return
	 * @throws SQLException
	 */
	public List<ProblemVO> getExamProblem(int examCode) throws SQLException;

	/**
	 * 지문 유무
	 * @param problemCode
	 * @return
	 * @throws SQLException
	 */
	public ProblemVO getJimoon(int problemCode) throws SQLException;

	/**
	 * 시험성적 등록
	 * @param acaVO
	 * @throws SQLException
	 */
	public void insertScore(AcademyScoreVO acaVO) throws SQLException;

	/**
	 * 시퀀스 조회
	 * @return
	 * @throws SQLException
	 */
	public int selectSeq() throws SQLException;

	/**
	 * 문제 코드 조회
	 * @return
	 * @throws SQLException
	 */
	public int selectCode(Map<String, Object> map) throws SQLException;

	/**
	 * 틀린문제 오답노트 등록
	 * @param wrongVO
	 * @throws SQLException
	 */
	public void insertWrong(WrongVO wrongVO) throws SQLException;

	/**
	 * 오답노트 시퀀스 조회
	 * @return
	 * @throws SQLException
	 */
	public int selectWrongSeq() throws SQLException;

	/**
	 * 시험결과 조회
	 * @return
	 * @throws SQLException
	 */
	public AcademyScoreVO selectScore(Map<String, Object> map) throws SQLException;

	/**
	 * 오답 조회
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	public List<WrongVO> selectWrong(Map<String, Object> map) throws SQLException;

	/**
	 * 해당 id가 응시한 시험 코드 / 시험이름 조회
	 * @param id 아이디
	 * @param classCode 수업코드
	 * @return
	 * @throws SQLException
	 */

	public List<ExamVO> selectExamCodeListByClassCode(String id, int classCode) throws SQLException;

}