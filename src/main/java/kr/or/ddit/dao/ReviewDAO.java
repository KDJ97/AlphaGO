package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;



import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.SubjectVO;

public interface ReviewDAO {
	/**
	 * 수업리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> classList(String id) throws SQLException;

	/**
	 * 모든 수업 후기
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> selectReviewAll() throws SQLException;

//	/**
//	 * 수업 후기 갯수
//	 * @param cri
//	 * @return
//	 * @throws SQLException
//	 */
//	public int selectReviewAllCount() throws SQLException;

	/**
	 * 평균 평점
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public double reviewAvg(String classCode) throws SQLException;

	/**
	 * 수업별 후기
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> reviewClass(String classCode) throws SQLException;
	
	/**
	 * 시퀀스
	 * @return
	 * @throws SQLException
	 */
	public String selectSeq() throws SQLException;
	
	/**
	 * 후기 넣기
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int insertReview(ClassReviewVO vo) throws SQLException;
	
	/**
	 * 수업 등록 폼
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public ClassVO infoClass(String classCode) throws SQLException;
}
