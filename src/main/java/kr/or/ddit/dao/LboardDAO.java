package kr.or.ddit.dao;

import java.sql.SQLException;

import kr.or.ddit.dto.LboardVO;

public interface LboardDAO {
	
	//lboard_seq.nextval 가져오기
	int selectLboardSeqNext() throws SQLException;
	
	//등록
	void insertLboard(LboardVO lboard) throws SQLException;
	
}
