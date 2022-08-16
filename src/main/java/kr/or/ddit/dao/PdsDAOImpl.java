package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PdsVO;

public class PdsDAOImpl implements PdsDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	@Override
	public List<PdsVO> selectAllPdsList() throws Exception {
		List<PdsVO> list =  session.selectList("Pds-Mapper.selectAllPdsList");


		return list;
	}

	@Override
	public PdsVO selectPdsByLCode(int lCode) throws SQLException {
		return session.selectOne("Pds-Mapper.selectPdsByLCode", lCode);
	}
	@Override
	public void increaseViewCnt(int lCode) throws SQLException {
		session.update("Pds-Mapper.increaseViewCnt",lCode);
	}
	@Override
	public void deletePds(int lcode) {
		session.update("Pds-Mapper.deletePds", lcode);
	}


	@Override
	public void insertPds(PdsVO pds) {
		session.update("Pds-Mapper.insertPds", pds);
	}

	@Override
	public void updatePds(PdsVO pds) {
		session.update("Pds-Mapper.updatePds",pds);

	}

	@Override
	public int selectPdsListCount(SearchCriteria cri) {
		return session.selectOne("Pds-Mapper.selectSearchPdsListCount",cri);
	}

	@Override
	public List<PdsVO> selectSearchPdsList(SearchCriteria cri) {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<PdsVO> pdsList = session.selectList("Pds-Mapper.selectSearchPdsList", cri, rowBounds);

		return pdsList;
	}


}
