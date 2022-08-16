package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.YJSearchCriteria;
import kr.or.ddit.dao.WrongDAO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.WrongVO;

public class WrongServiceImpl implements WrongService {

	private WrongDAO wrongDAO;
	public void setWrongDAO(WrongDAO wrongDAO) {
		this.wrongDAO = wrongDAO;
	}
	
	/**
	 * selectbox examlist
	 */
	@Override
	public List<ExamVO> selectExam(Map<String, Object> map) throws SQLException {
		return wrongDAO.selectExam(map);
	}

	/**
	 * 오답리스트
	 */
	@Override
	public Map<String, Object> selectWrong(String id, YJSearchCriteria cri) throws SQLException {	
		YJSearchCriteria searchCri = (YJSearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(searchCri);
		pageMaker.setTotalCount(wrongDAO.selectWrongCount(id, searchCri));
		
		List<WrongVO> wrongList = wrongDAO.selectWrong(id, searchCri);
		
		dataMap.put("wrongList", wrongList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public WrongVO selectDetailWrong(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return wrongDAO.selectDetailWrong(map);
	}

	@Override
	public WrongVO selectDetailMain(String id) throws SQLException {
		// TODO Auto-generated method stub
		return wrongDAO.selectDetailMain(id);
	}

	@Override
	public List<WrongVO> selectTname(int examCode) throws SQLException {
		// TODO Auto-generated method stub
		return wrongDAO.selectTname(examCode);
	}

	@Override
	public void updateQuestion(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		wrongDAO.updateQuestion(map);
	}

	@Override
	public WrongVO selectSname(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return wrongDAO.selectSname(map);
	}

	@Override
	public void insertSolution(Map<String, Object> map) throws SQLException {
		wrongDAO.insertSolution(map);
		
	}

	@Override
	public String selectJimoon(int problemCode) throws SQLException {
		// TODO Auto-generated method stub
		return wrongDAO.selectJimoon(problemCode);
	}

}
