package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.FixtureVO;
import kr.or.ddit.dto.UseFixtVO;
import kr.or.ddit.dto.UseRoomVO;

public interface ClassroomDAO {

	/**
	 * 페이징이 가능한 강의실 리스트
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> getAllClassroom(SearchCriteria cri) throws SQLException;
	/**
	 * 강의실 개수
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public int selectClassroomListCount(SearchCriteria cri) throws SQLException;
	
	/**
	 * 강의실 호수에 맞는 방을 가져옴 (중복확인)
	 * @param roomNo
	 * @return
	 * @throws SQLException
	 */
	public ClassroomVO selectRoomByRno(String roomNo) throws SQLException;
	
	/**
	 * 강의실 코드 시퀀스를 가져온다(등록에서 사용)
	 * @return
	 * @throws SQLException
	 */
	public int getClassroomSeq() throws SQLException;
	
	/**
	 * 강의실 등록
	 * @param roomVO
	 * @throws SQLException
	 */
	public void registClassroom(ClassroomVO roomVO) throws SQLException;

	/**
	 * 강의실 삭제
	 * @param roomCode
	 * @throws SQLException
	 */
	public void removeClassroom(int roomCode) throws SQLException;
	
	public List<ClassroomVO> getClassroom() throws SQLException;
	
	/**
	 * 하나의 강의실 정보
	 * @param roomCode 강의실코드
	 * @return 강의실 하나 정보
	 * @throws SQLException
	 */
	public ClassroomVO getOneClassroom(String roomCode) throws SQLException;
	
	/**
	 * 모든 강의실 정보
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> getNoSearchClassroom() throws SQLException;
	/**
	 * 사용중인 강의실 정보 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> getAllUseRoom() throws SQLException;
	/**
	 * 사용중인 하나의 강의실의 시간정보
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> getUsedRoom(ClassroomVO roomVO) throws SQLException;
	
	/**
	 * 해당 강의실을 사용중인 중복되지 않은 수업코드 모음
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> selectClassByRCode(String roomCode) throws SQLException;
	
	/**
	 * 해당 강의실을 사용중인 중복되지 않은 수업 상세 리스트
	 * @param roomCode
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassListByRoomCode(String roomCode, SearchCriteria cri) throws SQLException;
	
	/**
	 * 해당 강의실을 사용중인 중복되지 않은 수업 상세 리스트의 개수
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public int selectClassListByRoomCodeCount(String roomCode, SearchCriteria cri) throws SQLException;
	
	/**
	 * 해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
	 * @param classVO
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassListByRoomCodeClassDay(ClassVO classVO) throws SQLException;
	/**
	 * 해당강의실의 오늘 수업이 있는 시간 정보를 가져온다
	 * @param classVO
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> selectClassTimeByRoom(ClassVO classVO) throws SQLException;
	
	/**
	 * 해당 강의실에서 사용하는 비품 목록
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<UseFixtVO> getUsedFixtByRoomCode(String roomCode) throws SQLException;
	
	/**
	 * 강의실 수정
	 * @param room
	 * @throws SQLException
	 */
	public void updateClassroom(ClassroomVO room) throws SQLException;
	
	/**
	 * 강의실 사용 비품 체크
	 * @param room
	 * @return
	 * @throws SQLException
	 */
	public int selectUseFixtCountByRoomCode(ClassroomVO room) throws SQLException;
	
	/**
	 * 사용 비품 인서트
	 * @param fixt
	 * @throws SQLException
	 */
	public void insertUseFixt(UseFixtVO fixt) throws SQLException;
	
	public int getUseFixtSeq() throws SQLException;
	
	/**
	 * 해당 강의실의 진행중인 수업 시간표
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<UseRoomVO> getUseRoomTimeByCpcheck(String roomCode) throws SQLException;
}















