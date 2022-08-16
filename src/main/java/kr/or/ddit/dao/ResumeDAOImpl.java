package kr.or.ddit.dao;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.ResumeVO;

public class ResumeDAOImpl implements ResumeDAO{

	 private SqlSession session;
	    
     public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public int insertResume(ResumeVO resume) throws SQLException {
		int resumes=session.update("Resume-Mapper.insertResume",resume);
		
		return resumes;
	}

	@Override
	public int selectResumeSequenceNextValue() throws SQLException {
		int resumeCode=session.selectOne("Resume-Mapper.selectResumeSequenceNextValue");
		return resumeCode;
	}

	@Override
	public ResumeVO selectResumeByResumeCode() throws SQLException {
		return session.selectOne("Resume-Mapper.selectResumeByResumeCode");
		
	}

	@Override
	public int updateStatus(ResumeVO resume) throws SQLException {
		int update=session.update("Resume-Mapper.updateStatus",resume);
		return update;
	}

	@Override
	public ResumeVO selectResumeBystatusY() throws SQLException {
		return session.selectOne("Resume-Mapper.selectResumeBystatusY");
		
	}	
	
}
