package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;



import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.PopAttachVO;
import kr.or.ddit.dto.StudentVO;

public interface ApplyDAO {

	
	List<ApplyVO> selectApplyList() throws SQLException; 
	List<ApplyVO> selectApplyList(Criteria cri)throws Exception;
	
	int selectApplyListCount(SearchCriteria cri) throws Exception;
	// 검색 결과의 전체 리스트 개수
	int selectSearchApplyListCount(SearchCriteria cri) throws Exception;
	
	List<ApplyVO> selectSearchApplyList(SearchCriteria cri ) 
			throws SQLException;
	
	public ApplyVO selectAttachByApplyCode(int applyCode)throws SQLException;
	
	//지원서 등록
	int insertApply(ApplyVO apply)throws SQLException;
	
	//applysequence 세기
	int selectApplySequenceNextValue()throws SQLException;
	
	//양식 변경
	int updateresume(String applyfilename)throws SQLException;
	
	
	//첨부파일 다운
	ApplyVO selectApplyByApplyCode(int applyCode) throws SQLException;
}
