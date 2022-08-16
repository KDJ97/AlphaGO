// 작성자 : 예현의
// 작성일 : 2022-07-22
// 자료실 dao interface

package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PdsVO;

public interface PdsDAO {
	public List<PdsVO> selectAllPdsList() throws Exception;

	// lCode로 Pds가져오기
	public PdsVO selectPdsByLCode(int lCode) throws SQLException;

	// viewCnt 증가시키기
	public void increaseViewCnt(int lCode) throws SQLException;

	// pds 삭제
	public void deletePds(int lcode);

	// pds 등록
	public void insertPds(PdsVO pds);

	// pds 수정
	public void updatePds(PdsVO pds);

	// pagenation용 int
	public int selectPdsListCount(SearchCriteria cri);

	// pagenation용 list
	List<PdsVO> selectSearchPdsList(SearchCriteria cri);

}
