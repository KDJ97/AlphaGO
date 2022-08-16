package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.SubjectVO;

public interface ReviewService {
	/**
	 * 수업 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> classList(String id) throws SQLException;

	/**
	 * 리뷰 전체
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> selectReviewAll() throws SQLException;

	/**
	 * 리뷰 평점 평균
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public double reviewAvg(String classCode) throws SQLException;
	
	/**
	 * 수업별 리뷰
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> reviewClass(String classCode) throws SQLException;
	
	/**
	 * 리뷰 등록
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int insertReview(ClassReviewVO vo) throws SQLException;
	
	/**
	 * 리뷰 등록 폼
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public ClassVO infoClass(String classCode) throws SQLException;
}
