package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.ApplyVO;

public interface ApplyService {

	
	Map<String, Object> getApplyList(Criteria cri) throws SQLException;
	
	//지원서 등록
	int regist(ApplyVO apply)throws Exception;
	
	//지원서 양식 변경
	int update(String applyfilename)throws Exception;
	
	//지원서 다운
	public ApplyVO selectApplyByApplyCode(int applyCode)throws SQLException;
}
