package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.AttachDAO;
import kr.or.ddit.dao.LboardDAO;
import kr.or.ddit.dao.PdsDAO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.FavoritesVO;
import kr.or.ddit.dto.LboardVO;
import kr.or.ddit.dto.PdsVO;

public class PdsServiceImpl implements PdsService {

	private PdsDAO pdsDAO;
	public void setPdsDAO(PdsDAO pdsDAO) {
		this.pdsDAO = pdsDAO;
	}

	private AttachDAO attachDAO;
	public void setAttachDAO(AttachDAO attachDAO) {
		this.attachDAO = attachDAO;
	}

	private LboardDAO lBoardDAO;
	public void setLBoardDAO(LboardDAO lBoardDAO) {
		this.lBoardDAO = lBoardDAO;
	}


	@Override
	public List<PdsVO> getPdsList() throws Exception {
		List<PdsVO> pdsList = pdsDAO.selectAllPdsList();

		if(pdsList != null)
			for(PdsVO pds : pdsList)
				addAttachList(pds);

		return pdsList;
	}

	@Override
	public PdsVO read(int lCode) throws SQLException{

		PdsVO pds = pdsDAO.selectPdsByLCode(lCode);
		pdsDAO.increaseViewCnt(lCode);

		addAttachList(pds);

		return pds;
	}

	@Override
	public PdsVO getPds(int lCode) throws SQLException{
		PdsVO pds = pdsDAO.selectPdsByLCode(lCode);

		addAttachList(pds);

		return pds;
	}

	private void addAttachList(PdsVO pds) throws SQLException{
		if(pds == null) return;

		int lCode = pds.getlCode();
		List<AttachVO> attachList = attachDAO.selectAttachesByLCode(lCode);

		pds.setAttachList(attachList);
	}


	@Override
	public void remove(int lcode) {
		pdsDAO.deletePds(lcode);
	}


	@Override
	public void regist(PdsVO pds) throws SQLException {
		//int lCode = pdsDAO.getSeqNextValue();
		int lCode = lBoardDAO.selectLboardSeqNext();

		LboardVO lBoard = new LboardVO();
		lBoard.setLcode(lCode);
		lBoard.setBcode("PDS");

		lBoardDAO.insertLboard(lBoard);

		pds.setlCode(lCode);
		pdsDAO.insertPds(pds);

		if (pds.getAttachList() != null) for (AttachVO attach : pds.getAttachList()) {
			attach.setlCode(lCode);
			attach.setAttacher(pds.getWriter());
			attachDAO.insertAttach(attach);
		}
	}


	@Override
	public AttachVO getAttachByAno(int ano) throws SQLException {
		AttachVO attach = attachDAO.selectAttachByAno(ano);
		return attach;
	}


	@Override
	public void removeAttachByAno(int ano) throws SQLException{
		attachDAO.deleteAttach(ano);
	}


	@Override
	public void modify(PdsVO pds) throws SQLException {
		pdsDAO.updatePds(pds);

		// attachDAOBean.deleteAllAttach(pds.getPno());

		if (pds.getAttachList() != null)
			for (AttachVO attach : pds.getAttachList()) {
				attach.setlCode(pds.getlCode());
				attach.setAttacher(pds.getWriter());
				attachDAO.insertAttach(attach);

			}

	}


	@Override
	public Map<String,Object> getPdsList(Criteria cri) throws SQLException{

		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(pdsDAO.selectPdsListCount(searchCri));

		List<PdsVO> pdsList = pdsDAO.selectSearchPdsList(searchCri);

		//첨부파일 목록 추가
		if(pdsList != null) for(PdsVO pds : pdsList) {
			addAttachList(pds);
		}


		dataMap.put("pdsList", pdsList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}


	@Override
	public List<Map<String, Object>> getLikePdsList(List<FavoritesVO> likeList) throws SQLException {

		// List<Map<String, Object>>
		// key : fav -> value : FavoritesVO
		// key : pds -> value : PdsVO

		List<Map<String, Object>> likeData = new ArrayList<Map<String,Object>>();

		if(likeList != null && likeList.size() != 0) {
			for(FavoritesVO fav : likeList) {
				Map<String, Object> likeMap = new HashMap<String, Object>();
				PdsVO pds = pdsDAO.selectPdsByLCode(fav.getlCode());
				likeMap.put("fav", fav);
				likeMap.put("pds", pds);
				likeData.add(likeMap);
			}
		}



//		List<PdsVO> pdsList = new ArrayList<PdsVO>();
//
//		if(likeList != null) for(FavoritesVO fav : likeList) {
//			pdsList.add(pdsDAO.selectPdsByLCode(fav.getlCode()));
//		}

		return likeData;
	}




}
