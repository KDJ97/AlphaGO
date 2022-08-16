package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.PopupVO;

public class PopupDAOImpl implements PopupDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	/**
	 * 팝업리스트를 불러온다
	 */
	@Override
	public List<PopupVO> selectSearchPopupList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("Popup-Mapper.selectPopupList", cri, rowBounds);
	}
	/**
	 * 팝업개수를 불러온다.
	 */
	@Override
	public int selectPopupCount() throws SQLException {
		return session.selectOne("Popup-Mapper.selectPopupCount");
	}

	/**
	 * 팝업 파일 개수
	 */
	@Override
	public int selectPopAttachCount(String popcode) throws SQLException {
		return session.selectOne("Popup-Mapper.selectPopAttachCount", popcode);
	}

	/**
	 * 팝업 기본키 시퀀스
	 */
	@Override
	public int selectPopupSeq() throws SQLException {
		return session.selectOne("Popup-Mapper.selectPopupSeq");
	}
	/**
	 * 팝업 첨부파일 기본키 시퀀스
	 */
	@Override
	public int selectPopAttachSeq() throws SQLException {
		return session.selectOne("Popup-Mapper.selectPopAttachSeq");
	}

	/**
	 * 팝업 인서트
	 */
	@Override
	public void insertPopup(PopupVO popupVO) throws SQLException {
		session.update("Popup-Mapper.insertPopup", popupVO);
	}
	/**
	 * 팝업 첨부파일 인서트
	 */
	@Override
	public void insertPopupAttach(PopAttachVO popAttachVO) throws SQLException {
		session.update("Popup-Mapper.insertPopAttach", popAttachVO);
	}

	/**
	 * 팝업 상세 불러오기
	 */
	@Override
	public PopupVO selectPopupDetail(String popcode) throws SQLException {
		return session.selectOne("Popup-Mapper.selectPopupDetail", popcode);
	}

	/**
	 * 팝업 첨부파일 불러오기
	 */
	@Override
	public List<PopAttachVO> selectPopAttaches(String popcode) throws SQLException {
		return session.selectList("Popup-Mapper.selectPopAttaches", popcode);
	}

	@Override
	public PopAttachVO selectAttachByAttachno(String attachno) throws SQLException {
		return session.selectOne("Popup-Mapper.selectAttachByAno", attachno);
	}

	@Override
	public void deleteAttach(String attachno) throws SQLException {
		session.update("Popup-Mapper.removePopAttach", attachno);
	}

	/**
	 * 팝업 수정
	 */
	@Override
	public void modifyPopup(PopupVO popup) throws SQLException {
		session.update("Popup-Mapper.modifyPopup", popup);
	}

	/**
	 * 팝업 삭제
	 */
	@Override
	public void deletePopup(String popcode) throws SQLException {
		session.update("Popup-Mapper.deletePopup", popcode);
	}

	/**
	 * 팝업코드로 첨부파일 목록 가져오기
	 */
	@Override
	public List<PopAttachVO> selectAttachByPopcode(String popcode) throws SQLException {
		return session.selectList("Popup-Mapper.selectAttachByPopcode", popcode);
	}

	/**
	 * 팝코드로 첨부파일 삭제하기
	 */
	@Override
	public void deleteAttachByPopcode(String popcode) throws SQLException {
		session.update("Popup-Mapper.deletePopAttachByPopcode",popcode);
	}
	/**
	 * 현재 시간에 사용중인 팝업을 가져온다
	 */
	@Override
	public PopupVO selectUsePopup() throws SQLException {
		return session.selectOne("Popup-Mapper.selectUsePopup");
	}

	@Override
	public int selectUsePopupCount() throws SQLException {
		return session.selectOne("Popup-Mapper.selectUsePopupCount");
	}

}
