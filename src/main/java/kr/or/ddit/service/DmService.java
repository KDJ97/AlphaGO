package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.dto.DmVO;

public interface DmService {
	// 받은쪽지함 조회
	public List<DmVO> getSendList(String id) throws Exception;

	// 보낸쪽지함 조회
	public List<DmVO> getReciveList(String id) throws Exception;

	//쪽지 조회
	public DmVO getDm(String code, String div) throws Exception;

	// 안읽음 쪽지 목록
	public List<DmVO> getNotReadDm(String id) throws Exception;

	// 새로운 쪽지 갯수 조회
	public int selectNewDm(String id) throws Exception;

	// 쪽지 삭제
	public void deleteDm(String code, String div) throws Exception;

	//쪽지 보내기
	public void sendDm(List<String> to, String from, String title, String content);

}
