package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.ApplyDAO;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.StudentVO;

public class ApplyServiceImpl implements ApplyService {

	
	private ApplyDAO applyDAO;
	public void setApplyDAO(ApplyDAO applyDAO) {
		this.applyDAO = applyDAO;
	}
	@Override
	public Map<String, Object> getApplyList(Criteria cri) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(applyDAO.selectApplyListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<ApplyVO> applyList = applyDAO.selectSearchApplyList(searchCri);

		dataMap.put("applyList",applyList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}
	
	//지원서 등록
	@Override
	public int regist(ApplyVO apply) throws Exception {
		int applyCode=applyDAO.selectApplySequenceNextValue();
		apply.setApplyCode(applyCode);
		
		int abc=applyDAO.insertApply(apply);
		
		return abc;
	}
	@Override
	public int update(String applyfilename) throws Exception {
		int update=applyDAO.updateresume(applyfilename);
		
		return update;
	}
	@Override
	public ApplyVO selectApplyByApplyCode(int applyCode) throws SQLException {
		ApplyVO apply=applyDAO.selectApplyByApplyCode(applyCode);
		
		return apply;
	}

}
