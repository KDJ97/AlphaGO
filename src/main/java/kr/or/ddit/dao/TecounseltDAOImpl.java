package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.TecounseltVO;

public class TecounseltDAOImpl implements TecounseltDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	@Override
	public List<TecounseltVO> selectCounseltList() throws Exception {
		List<TecounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("TeaConsult-Mapper.selectCounseltList");
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}
	@Override
	public List<TecounseltVO> selectCounseltList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TecounseltVO> counseltList = session.selectList("TeaConsult-Mapper.selectCounseltList", null, rowBounds);

		return counseltList;
	}
	@Override
	public int selectCounseltListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("TeaConsult-Mapper.selectSearchCounseltListCount", cri);
	}
	@Override
	public int selectSearchCounseltListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("TeaConsult-Mapper.selectSearchCounseltListCount", cri);
		return totalCount;
	}
	@Override
	public List<TecounseltVO> selectSearchCounseltList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TecounseltVO> counseltList = session.selectList("TeaConsult-Mapper.selectSearchCounseltList", cri,
				rowBounds);

		return counseltList;
	}
	@Override
	public String selectName(Integer counCode) throws Exception {
		return session.selectOne("TeaConsult-Mapper.selectName", counCode);
	}
}
