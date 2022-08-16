package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.ClassroomCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.UseFixtVO;
import kr.or.ddit.dto.UseRoomVO;

public interface ClassroomService {
	public Map<String, Object> getAllClassroom(SearchCriteria cri) throws SQLException;
	
	public void registClassroom(ClassroomCommand roomCommand) throws SQLException;
	
	public int getClassroomSeq() throws SQLException;
	
	public void removeClassroom(int roomCode) throws SQLException;
	
	public ClassroomVO getOneClassroom(String roomCode) throws SQLException;
	
	public List<UseFixtVO> getUsedFixtByRoomCode(String roomCode) throws SQLException;
	
	/**
	 * 강의실 번호에 맞는 강의실 VO를 가져온다(중복확인용)
	 * @param roomNo
	 * @return
	 * @throws SQLException
	 */
	public ClassroomVO selectRoomByRno(String roomNo) throws SQLException;
	
	/**
	 * 강의실 코드에 맞는 수업의 정보를 반환하는 메서드
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> selectClassByClassRoom(String roomCode) throws SQLException;
	
	/**
	 * 해당 강의실에서 진행되는 수업들의 상세 리스트이다.
	 * @param roomCode
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> selectClassListByRoomCode(String roomCode, SearchCriteria cri) throws SQLException;
	
	
	/**
	 * 해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassListByRoomCodeClassDay(String roomCode) throws SQLException;
	
	/**
	 * 해당강의실의 오늘 수업이 있는 시간 정보를 가져온다
	 * @param classVO
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> selectClassTimeByRoom(ClassVO classVO) throws SQLException;
	
	/**
	 * 강의실 수정
	 * @param room
	 * @throws SQLException
	 */
	public void updateClassroom(ClassroomVO room) throws SQLException;
	
	/**
	 * 강의실에서 사용하는 비품 체크
	 * @param room
	 * @return
	 * @throws SQLException
	 */
	public int selectUseFixtCountByRoomCode(ClassroomVO room) throws SQLException;
	
	public void insertUseFixt(UseFixtVO fixt) throws SQLException;
	
	public int getUseFixtSeq() throws SQLException;
	
	/**
	 * 강의실에서 진행중인 수업 시간표
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<UseRoomVO> getUseRoomTimeByCpcheck(String roomCode) throws SQLException; 
	
	/**
	 * 오늘 사용중인 수업실 리스트 반환 작업
	 * @return
	 * @throws SQLException
	 */
	public List<ClassroomVO> selectUnUsedRoomList() throws SQLException;
	
	/**
	 * 강의실 개수, 수용인원, 사용가능수, 사용중 수, 층수
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> wholeRoomData() throws SQLException;
}


















