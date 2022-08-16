package kr.or.ddit.dao;

import java.util.List;

import kr.or.ddit.dto.DmVO;

public interface DmDAO {

	// 보낸 쪽지 리스트 조회
	List<DmVO> selectSendList(String id) throws Exception;

	// 받은 쪽지 리스트 조회
	List<DmVO> selectReciveList(String id) throws Exception;

	// 쪽지 조회
	DmVO selectDm(String code, String div);

	// 안읽음 쪽지 리스트
	List<DmVO> selectNotReadDmById(String id);

	// 받은 쪽지 중 안읽음 쪽지 갯수 -> 새로운 쪽지 갯수
	int selectNewDm(String id) throws Exception;

	// 쪽지 상태를 읽음으로 변경
	void updateDmByRead(String code);

	// 쪽지 삭제
	void deleteDm(String code, String div);

	// 쪽지 insert
	void insertDm(DmVO dm);

	// 시퀀스
	int selectMaxDm();

}
