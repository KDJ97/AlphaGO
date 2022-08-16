package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Category;
import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PdsVO;

public interface NoticeDAO {
	List<NoticeVO> selectSearchNoticeList(SearchCriteria cri) throws SQLException;
	
	public List<NoticeVO> selectFixedList() throws SQLException;

	int selectSearchNoticeListCount(SearchCriteria cri) throws SQLException;
	
	public NoticeVO selectNoticeByLcode(int lcode) throws SQLException;
	
	public void increaseViewCnt(int lcode) throws SQLException;
	
	public void deleteNotice(int lcode);

	public void insertNotice(NoticeVO pds);

	public void updateNotice(NoticeVO pds);
	
	public List<NoticeVO> selectAllNoticeList() throws Exception;
	
	//public List<NoticeVO> selectCateNoticeList(Map<String, Object> map) throws SQLException;

}
