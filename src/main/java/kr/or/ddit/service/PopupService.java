package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PopupRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;

public interface PopupService {

	/**
	 * 검색 가능한 팝업리스트
	 * @param cri
	 * @return
	 */
	public Map<String, Object> selectSearchPopupList(SearchCriteria cri) throws SQLException;
	
	/**
	 * 팝업 등록
	 * @param popupVO
	 * @throws SQLException
	 */
	public void registPopup(PopupVO popupVO) throws SQLException;
	
	/**
	 * 팝업 상세와 팝업 첨부파일 가져오기
	 * @param popcode
	 * @return 팝업 상세 + 팝업 첨부파일 
	 * @throws SQLException
	 */
	public PopupRegistCommand getPopup(String popcode) throws SQLException;
	
	/**
	 * 팝업 수정
	 * @param popupVO
	 * @throws SQLException
	 */
	public void modifyPopup(PopupVO popupVO) throws SQLException;
	
	// 자료 가져오기
	public PopAttachVO getAttachByAttachno(String attachno) throws SQLException;

	// 자료 삭제
	public void removeAttachByAttachno(String attachno) throws SQLException;
	
	/**
	 * 팝업 삭제
	 * @param popupVO
	 * @throws SQLException
	 */
	public void removePopup(PopupVO popupVO) throws SQLException;
	/**
	 * 팝코드로 삭제할 첨부파일 리스트를 가져온다
	 * @param popcode
	 * @return
	 * @throws SQLException
	 */
	public List<PopAttachVO> getAttachByPopcode(String popcode) throws SQLException;
	
	/**
	 * 팝코드로 첨부파일 삭제
	 * @param popcode
	 * @throws SQLException
	 */
	public void removeAttachByPopcode(String popcode) throws SQLException;
	
	/**
	 * 현재 시간에 사용중인 팝업을 불러온다.
	 * @return
	 * @throws SQLException
	 */
	public PopupVO selectUsePopup() throws SQLException;
	
	/**
	 * 현재시간에 사용중인 팝업의 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectUsePopupCount() throws SQLException;
}











