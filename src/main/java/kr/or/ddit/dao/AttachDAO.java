package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.AttachVO;

public interface AttachDAO {

	// 첨부파일 목록 가져오기
	List<AttachVO> selectAttachesByLCode(int lCode) throws SQLException;

	// 첨부파일 insert
	void insertAttach(AttachVO attach) throws SQLException;

	// ano 첨부파일 가져오기
	AttachVO selectAttachByAno(int ano) throws SQLException;

	void deleteAttach(int ano) throws SQLException;

}
