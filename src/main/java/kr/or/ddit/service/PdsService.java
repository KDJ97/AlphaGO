// 작성자 : 예현의
// 작성일 : 2022-07-22
// 자료실 서비스 interface

package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.FavoritesVO;
import kr.or.ddit.dto.PdsVO;

public interface PdsService {

	//모든 자료실 리스트 조회
	public List<PdsVO> getPdsList() throws Exception;

	// page용 list
	public Map<String, Object> getPdsList(Criteria cri) throws SQLException;

	// 읽기
	public PdsVO read(int lCode) throws SQLException;

	// 가져오기
	public PdsVO getPds(int lCode) throws SQLException;

	// 삭제
	public void remove(int lcode) throws SQLException;

	//자료실 등록
	public void regist(PdsVO pds) throws SQLException;

	// 자료 가져오기
	public AttachVO getAttachByAno(int ano) throws SQLException;

	// 자료 삭제
	public void removeAttachByAno(int ano) throws SQLException;

	// pds 수정
	public void modify(PdsVO pds) throws SQLException;

	// 즐겨찾기 목록 가져오기
	// List<Map<String, Object>>
	// key : fav -> value : FavoritesVO
	// key : pds -> value : PdsVO
	public List<Map<String, Object>> getLikePdsList(List<FavoritesVO> likeList) throws SQLException;


}
