package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.WrongVO;

public interface ExamService {
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
	 * 오답리스트
	 * @param request
	 * @param examCode
	 * @param session
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> checkWrong(int examCode, HttpSession session) throws SQLException;
	
	/**
	 * 점수계산
	 * @param request
	 * @param examCode
	 * @param session
	 * @param problem
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> checkExam( HttpServletRequest request, int examCode, HttpSession session, int problem)throws SQLException;
	
	/**
	 * 시험결과 출력
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> resultExam(int examCode, HttpSession session) throws SQLException;
	
	/**
	 * 문제 페이지네이션
	 * @param examCode
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> problemPrint(int examCode) throws SQLException;
	
}
