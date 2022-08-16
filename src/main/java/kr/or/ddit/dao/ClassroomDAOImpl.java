package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.UseFixtVO;
import kr.or.ddit.dto.UseRoomVO;

public class ClassroomDAOImpl implements ClassroomDAO {

	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	/**
	 * 강의실 테이블 목록 전체 불러오기
	 */
	@Override
	public List<ClassroomVO> getAllClassroom(SearchCriteria cri) throws SQLException {
		List<ClassroomVO> list = null;
		cri.setPerPageNum(5);
		int offset=cri.getStartRowNum();
		int limit=cri.getPerPageNum();		
		RowBounds rowBounds=new RowBounds(offset,limit);	
		list = session.selectList("Classroom-Mapper.getAllClassroom", cri, rowBounds);
		return list;
	}
	@Override
	public int selectClassroomListCount(SearchCriteria cri) throws SQLException {
		int count=session.selectOne("Classroom-Mapper.selectClassroomListCount",cri);
		return count;
	}
	

	@Override
	public int getClassroomSeq() throws SQLException {
		int roomCode = session.selectOne("Classroom-Mapper.getClassroomSeq");
		return roomCode;
	}

	@Override
	public void registClassroom(ClassroomVO roomVO) throws SQLException {
		session.update("Classroom-Mapper.insertClassroom", roomVO);
	}

	@Override
	public void removeClassroom(int roomCode) throws SQLException {
		session.update("Classroom-Mapper.removeClassroom", roomCode);
	}

	@Override
	public List<ClassroomVO> getClassroom() throws SQLException {
		return session.selectList("Classroom-Mapper.getClassroom");
	}

	@Override
	public ClassroomVO getOneClassroom(String roomCode) throws SQLException {
		return session.selectOne("Classroom-Mapper.getOneClassroom", roomCode);
	}

	@Override
	public List<ClassroomVO> getNoSearchClassroom() throws SQLException {
		return session.selectList("Classroom-Mapper.getNoSearchClassroom");
	}

	@Override
	public List<ClassroomVO> getAllUseRoom() throws SQLException {
		return session.selectList("Classroom-Mapper.getAllUseRoom");
	}

	@Override
	public List<ClassroomVO> getUsedRoom(ClassroomVO roomVO) throws SQLException {
		return session.selectList("Classroom-Mapper.getUsedRoom", roomVO);
	}

	@Override
	public ClassroomVO selectRoomByRno(String roomNo) throws SQLException {
		return session.selectOne("Classroom-Mapper.selectRoomByRno", roomNo);
	}

	@Override
	public List<ClassroomVO> selectClassByRCode(String roomCode) throws SQLException {
		return session.selectList("Classroom-Mapper.selectClassByRCode", roomCode);
	}

	@Override
	public List<ClassVO> selectClassListByRoomCode(String roomCode, SearchCriteria cri) throws SQLException {
		cri.setPerPageNum(5);
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomCode", roomCode);
		map.put("cri", cri);
		return session.selectList("Classroom-Mapper.selectClassListByRoomCode", map,rowBounds);
	}

	@Override
	public int selectClassListByRoomCodeCount(String roomCode, SearchCriteria cri) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomCode", roomCode);
		map.put("cri", cri);
		return session.selectOne("Classroom-Mapper.selectClassListByRoomCodeCount", map);
	}

	//해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
	@Override
	public List<ClassVO> selectClassListByRoomCodeClassDay(ClassVO classVO) throws SQLException {
		return session.selectList("Classroom-Mapper.selectClassListByRoomCodeClassDay", classVO);
	}

	@Override
	public List<ClassroomVO> selectClassTimeByRoom(ClassVO classVO) throws SQLException {
		return session.selectList("Classroom-Mapper.selectClassTimeByRoom", classVO);
	}

	@Override
	public List<UseFixtVO> getUsedFixtByRoomCode(String roomCode) throws SQLException {
		return session.selectList("Classroom-Mapper.getUsedFixtByRoomCode",roomCode);
	}

	@Override
	public void updateClassroom(ClassroomVO room) throws SQLException {
		session.update("Classroom-Mapper.updateClassroom", room);
	}

	@Override
	public int selectUseFixtCountByRoomCode(ClassroomVO room) throws SQLException {
		return session.selectOne("Classroom-Mapper.selectUseFixtCountByRoomCode", room);
	}

	@Override
	public void insertUseFixt(UseFixtVO fixt) throws SQLException {
		session.update("Classroom-Mapper.insertUseFixt", fixt);
	}

	@Override
	public int getUseFixtSeq() throws SQLException {
		return session.selectOne("Classroom-Mapper.getUseFixtSeq");
	}

	@Override
	public List<UseRoomVO> getUseRoomTimeByCpcheck(String roomCode) throws SQLException {
		return session.selectList("Classroom-Mapper.getUseRoomTimeByCpcheck", roomCode);
	}


	
}
