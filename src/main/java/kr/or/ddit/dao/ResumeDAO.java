package kr.or.ddit.dao;

import java.sql.SQLException;

import kr.or.ddit.dto.ResumeVO;

public interface ResumeDAO {
	
	//양식 등록
	int insertResume(ResumeVO resume)throws SQLException;
	
	//resumesequenct 세기
	int selectResumeSequenceNextValue()throws SQLException;
	
	//이력서 양식 다운
	ResumeVO selectResumeByResumeCode()throws SQLException;
	
	//양식 수정
	int updateStatus(ResumeVO resume)throws SQLException;
	
	//y인 데이터 가져오기
	ResumeVO selectResumeBystatusY()throws SQLException;

}
