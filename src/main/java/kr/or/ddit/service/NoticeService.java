package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Category;
import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.NoticeVO;

public interface NoticeService {
	Map<String, Object> getNoticeList(Criteria cri) throws SQLException;
	
	public List<NoticeVO> getNoticeList() throws Exception;

	public NoticeVO selectNoticeByLcode(int lcode) throws SQLException;

	public void deleteNotice(int lcode) throws SQLException;

	public void insertNotice(NoticeVO pds) throws SQLException;

	public void updateNotice(NoticeVO pds) throws SQLException;

	public NoticeVO getNotice(int lcode) throws SQLException;

	public AttachVO getAttachByAno(int ano) throws SQLException;

	public void removeAttachByAno(int ano) throws SQLException;
	
	public List<NoticeVO> selectFixedList() throws SQLException;
	
	//public List<NoticeVO> selectCateNoticeList(String name, SearchCriteria cri) throws SQLException;
}
