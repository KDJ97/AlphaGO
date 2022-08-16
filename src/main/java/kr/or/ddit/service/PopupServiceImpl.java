package kr.or.ddit.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.PopupRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.PopupDAO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.PdsVO;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;

public class PopupServiceImpl implements PopupService {

	private PopupDAO popupDAO;
	public void setPopupDAO(PopupDAO popupDAO) {
		this.popupDAO = popupDAO;
	}
	
	@Override
	public Map<String, Object> selectSearchPopupList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<PopupVO> popupList = popupDAO.selectSearchPopupList(cri);
		
		for(PopupVO popupVO : popupList) {
			String popcode = popupVO.getPopcode();
			int cnt = popupDAO.selectPopAttachCount(popcode);
			popupVO.setPopcount(cnt);
		}
		
		PageMaker pageMaker = new PageMaker();
		int totalCount = popupDAO.selectPopupCount();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("popupList", popupList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void registPopup(PopupVO popupVO) throws SQLException {
		int intPopCode = popupDAO.selectPopupSeq();//팝업 기본키
		String popcode = String.valueOf(intPopCode);
		popupVO.setPopcode(popcode);
		
		//팝업등록
		popupDAO.insertPopup(popupVO);
		
		
		if (popupVO.getPopAttachList() != null) {
			for (PopAttachVO attach : popupVO.getPopAttachList()) {
				//팝업 첨부파일 기본키
				int intPopAttachCode = popupDAO.selectPopAttachSeq();
				String popAttachCode = String.valueOf(intPopAttachCode);
				attach.setAttachno(popAttachCode);
				attach.setPopcode(popcode);
				//팝업 첨부파일 등록
				popupDAO.insertPopupAttach(attach);
			}
		}
		
	}

	/**
	 * 팝업 상세 + 팝업 첨부파일 불러오기
	 */
	@Override
	public PopupRegistCommand getPopup(String popcode) throws SQLException {
		PopupRegistCommand command = new PopupRegistCommand();
		PopupVO popupVO = popupDAO.selectPopupDetail(popcode);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String start_date = dateFormat.format(popupVO.getStartDate());
		String end_date = dateFormat.format(popupVO.getEndDate());
		
		command.setPopcode(popupVO.getPopcode());
		command.setContent(popupVO.getContent());
		command.setTitle(popupVO.getTitle());
		command.setStartDate(start_date);
		command.setEndDate(end_date);
		command.setFilename(popupVO.getFilename());
		command.setFiletype(popupVO.getFiletype());
		command.setInuse(popupVO.getInuse());
		
		//팝업 첨부파일 리스트 set
		addAttachList(popupVO);
		command.setAttachList(popupVO.getPopAttachList());
		
		return command;
	}

	
	private void addAttachList(PopupVO pop) throws SQLException{
		if(pop == null) return;

		String popcode = pop.getPopcode();
		List<PopAttachVO> attachList = popupDAO.selectPopAttaches(popcode);
		
		pop.setPopAttachList(attachList);
	}

	/**
	 * 팝업 수정
	 */
	@Override
	public void modifyPopup(PopupVO popupVO) throws SQLException {
		//팝업 테이블에 팝업 업데이트
		popupDAO.modifyPopup(popupVO);
		
		//팝업 첨부파일 테이블 기본키
		int intPopAttachCode = popupDAO.selectPopAttachSeq();
		String popAttachCode = String.valueOf(intPopAttachCode);
//		System.out.println(popupVO.getPopcode());
		
		//팝업VO에 첨부파일 리스트가 있을 시 팝업 첨부파일 테이블에 하나씩 저장
		if (popupVO.getPopAttachList() != null) {
			for (PopAttachVO attach : popupVO.getPopAttachList()) {
				attach.setAttachno(popAttachCode);
				attach.setPopcode(popupVO.getPopcode());
				//팝업 첨부파일 등록
				popupDAO.insertPopupAttach(attach);
			}
		}
	}
	
	/**
	 * 팝업 첨부파일 하나씩 가져오는 용도(삭제용)
	 */
	@Override
	public PopAttachVO getAttachByAttachno(String attachno) throws SQLException {
		PopAttachVO attach = popupDAO.selectAttachByAttachno(attachno);
		return attach;
	}
	
	/**
	 * 팝업 첨부파일 하나씩 삭제하는 용도
	 */
	@Override
	public void removeAttachByAttachno(String attachno) throws SQLException {
		popupDAO.deleteAttach(attachno);
	}

	/**
	 * 팝코드로 첨부파일 리스트를 가져온다
	 */
	@Override
	public List<PopAttachVO> getAttachByPopcode(String popcode) throws SQLException {
		return popupDAO.selectAttachByPopcode(popcode);
	}
	/**
	 * 팝업을 연쇄 삭제하는 서비스(1. 팝업 첨부파일, 2. 팝업)
	 */
	@Override
	public void removePopup(PopupVO popupVO) throws SQLException {
		String popcode = popupVO.getPopcode();
		popupDAO.deletePopup(popcode);
	}

	@Override
	public void removeAttachByPopcode(String popcode) throws SQLException {
		popupDAO.deleteAttachByPopcode(popcode);
	}

	@Override
	public PopupVO selectUsePopup() throws SQLException {
		return popupDAO.selectUsePopup();
	}

	@Override
	public int selectUsePopupCount() throws SQLException {
		return popupDAO.selectUsePopupCount();
	}


}

















