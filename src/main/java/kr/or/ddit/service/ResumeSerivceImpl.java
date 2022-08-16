package kr.or.ddit.service;

import java.sql.SQLException;

import kr.or.ddit.dao.ResumeDAO;
import kr.or.ddit.dto.ResumeVO;

public class ResumeSerivceImpl implements ResumeService{
	
	private ResumeDAO resumeDAO;
	public void setResumeDAO(ResumeDAO resumeDAO) {
		this.resumeDAO = resumeDAO;
	}
	@Override
	public int regist(ResumeVO resume) throws Exception {
		int resumeCode=resumeDAO.selectResumeSequenceNextValue();
		
		resume.setResumeCode(resumeCode);
		
		int abc=resumeDAO.insertResume(resume);
		
		return abc;
	}
	@Override
	public ResumeVO selectResumeByResumeCode() throws SQLException {
		ResumeVO resume=resumeDAO.selectResumeByResumeCode();
		
		return resume;
	}
	@Override
	public int update(ResumeVO resume) throws Exception {
		int update=resumeDAO.updateStatus(resume);
		
		return update;
	}
	@Override
	public ResumeVO selectResumeBystatusY() throws SQLException {
		ResumeVO resume=resumeDAO.selectResumeBystatusY();
		
		return resume;
	}

}
