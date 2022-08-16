package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.MemberDAO;
import kr.or.ddit.dao.SuggestAnswerDAO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SuggestAnswerVO;

public class SuggestAnswerServiceImpl implements SuggestAnswerService{
	
	private SuggestAnswerDAO suggestAnswerDAO;
	public void setSuggestAnswerDAO(SuggestAnswerDAO suggestAnswerDAO) {
		this.suggestAnswerDAO = suggestAnswerDAO;
	}
	private MemberDAO memberDAO;
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}

	@Override
	public Map<String, Object> getSuggestAnswerList(int lcode, SearchCriteria cri) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<SuggestAnswerVO> suggestAnswerList = suggestAnswerDAO.selectSuggestAnswerListPage(lcode, cri);
		
		if(suggestAnswerList != null) for(SuggestAnswerVO suggestAnswer : suggestAnswerList) {
			MemberVO member = memberDAO.selectMemberById(suggestAnswer.getAnswerer());
			String answererName = member.getName();
			dataMap.put("answererName", answererName);
		}
		
		int count = suggestAnswerDAO.countSuggestAnswer(lcode);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(count);
		
		dataMap.put("suggestAnswerList", suggestAnswerList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public int getSuggestAnswerCount(int lcode) throws SQLException {
		int count = suggestAnswerDAO.countSuggestAnswer(lcode);
		return count;
	}

	@Override
	public void registSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException {
		int col = suggestAnswerDAO.selectSuggestAnswerSeqNextValue();
		suggestAnswer.setCol(col);
		
		suggestAnswerDAO.insertSuggestAnswer(suggestAnswer);
	}

	@Override
	public void modifySuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeSuggestAnswer(int col) throws SQLException {
		
		suggestAnswerDAO.deleteSuggestAnswer(col);
		 
	}

}
