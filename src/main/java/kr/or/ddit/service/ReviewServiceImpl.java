package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.ReviewDAO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;

public class ReviewServiceImpl implements ReviewService {

	private ReviewDAO reviewDAO;
	public void setReviewDAO(ReviewDAO reviewDAO) {
		this.reviewDAO = reviewDAO;
	}

	@Override
	public List<ClassVO> classList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return reviewDAO.classList(id);
	}

	@Override
	public List<ClassReviewVO> selectReviewAll() throws SQLException {

		return reviewDAO.selectReviewAll();
	}

	@Override
	public double reviewAvg(String classCode) throws SQLException {
		// TODO Auto-generated method stub
		return reviewDAO.reviewAvg(classCode);
	}

	@Override
	public List<ClassReviewVO> reviewClass(String classCode) throws SQLException {
		// TODO Auto-generated method stub
		return reviewDAO.reviewClass(classCode);
	}

	@Override
	public int insertReview(ClassReviewVO vo) throws SQLException {
		String seq = reviewDAO.selectSeq();
		vo.setReviewCode(seq);
		
		return reviewDAO.insertReview(vo);
	}

	@Override
	public ClassVO infoClass(String classCode) throws SQLException {
		// TODO Auto-generated method stub
		return reviewDAO.infoClass(classCode);
	}

}
