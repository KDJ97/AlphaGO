package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;

public interface PopupDAO {

	/**
	 * 검색 가능한 팝업 리스트
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<PopupVO> selectSearchPopupList(SearchCriteria cri) throws SQLException;
	
	/**
	 * 팝업 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectPopupCount() throws SQLException;
	
	/**
	 * 팝업 파일 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectPopAttachCount(String popcode) throws SQLException;
	
	/**
	 * 팝업 테이블 기본키 시퀀스
	 * @return
	 * @throws SQLException
	 */
	public int selectPopupSeq() throws SQLException;
	/**
	 * 팝업 첨부파일 기본키 시퀀스
	 * @return
	 * @throws SQLException
	 */
	public int selectPopAttachSeq() throws SQLException;
	
	/**
	 * 팝업 등록
	 * @param popupVO
	 * @throws SQLException
	 */
	public void insertPopup(PopupVO popupVO) throws SQLException;
	
	/**
	 * 팝업 첨부파일 등록
	 * @param popAttachVO
	 * @throws SQLException
	 */
	public void insertPopupAttach(PopAttachVO popAttachVO) throws SQLException;
	
	/**
	 * 팝업 상세 불러오기
	 * @param popcode 팝업코드
	 * @return
	 * @throws SQLException
	 */
	public PopupVO selectPopupDetail(String popcode) throws SQLException;
	
	/**
	 * 팝업 첨부파일 리스트 불러오기
	 * @param popcode 팝업코드
	 * @return
	 * @throws SQLException
	 */
	public List<PopAttachVO> selectPopAttaches(String popcode) throws SQLException;
	
	/**
	 * 팝업 수정하기
	 * @param popup
	 * @throws SQLException
	 */
	public void modifyPopup(PopupVO popup) throws SQLException;
	
	// attachno로 첨부파일 가져오기
	PopAttachVO selectAttachByAttachno(String attachno) throws SQLException;

	// popcode로 첨부파일 가져오기
	List<PopAttachVO> selectAttachByPopcode(String popcode) throws SQLException;

	// attach 삭제
	public void deleteAttach(String attachno) throws SQLException;
	
	/**
	 * 팝업 삭제
	 * @param popcode
	 * @throws SQLException
	 */
	public void deletePopup(String popcode) throws SQLException;
	/**
	 * 팝업코드로 팝업 첨부파일 db삭제
	 * @param popcode
	 * @throws SQLException
	 */
	public void deleteAttachByPopcode(String popcode) throws SQLException;
	
	/**
	 * 현재 시간에 사용중인 팝업을 가져온다
	 * @return
	 * @throws SQLException
	 */
	public PopupVO selectUsePopup() throws SQLException;
	/**
	 * 현재 시간에 사용중인 팝업의 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectUsePopupCount() throws SQLException;
}


















