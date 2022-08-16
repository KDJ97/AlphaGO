package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import kr.or.ddit.dto.AttachVO;

//@Service("attachDAO")
public class AttachDAOImpl implements AttachDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<AttachVO> selectAttachesByLCode(int lCode) throws SQLException {
		List<AttachVO> attachList = session.selectList("Attach-Mapper.selectAttachesByLCode", lCode);
		return attachList;
	}

	@Override
	public void insertAttach(AttachVO attach) throws SQLException{
		session.update("Attach-Mapper.insertAttach",attach);
	}

	@Override
	public AttachVO selectAttachByAno(int ano) throws SQLException {
		AttachVO attach=session.selectOne("Attach-Mapper.selectAttachByAno",ano);
		return attach;
	}

	@Override
	public void deleteAttach(int ano) throws SQLException {
		session.update("Attach-Mapper.deleteAttach",ano);
	}

}
