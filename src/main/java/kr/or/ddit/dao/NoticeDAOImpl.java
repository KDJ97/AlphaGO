package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Category;
import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PdsVO;

public class NoticeDAOImpl implements NoticeDAO{
    private SqlSession session;
    
     public void setSession(SqlSession session) {
		this.session = session;
	}	

	@Override
	public List<NoticeVO> selectSearchNoticeList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<NoticeVO> noticeList = session.selectList("Notice-Mapper.selectSearchNoticeList", cri, rowBounds);

		return noticeList;
	}

	@Override
	public int selectSearchNoticeListCount( SearchCriteria cri) throws SQLException {
		int count = session.selectOne("Notice-Mapper.selectSearchNoticeListCount", cri);
		return count;
	}


	@Override
	public NoticeVO selectNoticeByLcode(int lcode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Notice-Mapper.selectNoticeBylcode", lcode);
	}

	@Override
	public void increaseViewCnt(int lcode) throws SQLException {
		session.update("Notice-Mapper.increaseViewCount", lcode);
	}

	@Override
	public void deleteNotice(int lcode) {
		session.update("Notice-Mapper.deleteNotice", lcode);
		
	}

	@Override
	public void insertNotice(NoticeVO notice) {
		session.update("Notice-Mapper.insertNotice", notice);
		
	}

	@Override
	public void updateNotice(NoticeVO notice) {
		session.update("Notice-Mapper.updateNotice", notice);
		
	}

	@Override
	public List<NoticeVO> selectAllNoticeList() throws Exception {
		List<NoticeVO> list =  session.selectList("Notice-Mapper.selectAllNoticeList");

		return list;
	}

	@Override
	public List<NoticeVO> selectFixedList() throws SQLException {
		List<NoticeVO> fixList = session.selectList("Notice-Mapper.selectFixedList");
		
		return fixList;
	}

//	@Override
//	public List<NoticeVO> selectCateNoticeList(Map<String, Object> map) throws SQLException {
//		// TODO Auto-generated method stub
//		PageMaker pageMaker = (PageMaker) map.get("pageMaker");
//		SearchCriteria cri = (SearchCriteria) pageMaker.getCri();
//		
//		
//		int offset = cri.getStartRowNum();
//		int limit = cri.getPerPageNum();
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		
//		map.put("rowBounds", rowBounds);
//		return session.selectList("Notice-Mapper.selectCateNoticeList", map);
//	}

}
