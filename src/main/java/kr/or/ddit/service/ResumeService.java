package kr.or.ddit.service;

import java.sql.SQLException;

import kr.or.ddit.dao.ResumeDAO;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.ResumeVO;

public interface ResumeService {

	//지원서 등록
	int regist(ResumeVO resume)throws Exception;
	
	//양식 다운
	public ResumeVO selectResumeByResumeCode()throws SQLException;
	
	//상태 업데이트
	int update(ResumeVO resume)throws Exception;
	
	//상태 y가져오기
	public ResumeVO selectResumeBystatusY()throws SQLException;
}
