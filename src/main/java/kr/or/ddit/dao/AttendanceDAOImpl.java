package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.AttendanceVO;

public class AttendanceDAOImpl implements AttendanceDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}


	@Override
	public AttendanceVO selectAttendById(AttendanceVO attend) throws SQLException {
		return session.selectOne("Attendance-Mapper.selectAttendById", attend);
	}


	@Override
	public int selectAttNextSeq() throws SQLException {
		return session.selectOne("Attendance-Mapper.selectAttNextSeq");
	}


	@Override
	public void insertNewAttend(AttendanceVO attend) throws SQLException {
		session.update("Attendance-Mapper.insertNewAttend", attend);
	}


	@Override
	public void updateOutTimeIsNow(AttendanceVO attend) throws SQLException {
		session.update("Attendance-Mapper.updateOutTimeIsNow",attend);
	}


	@Override
	public String selectEndTime(String id) throws SQLException {
		return session.selectOne("Attendance-Mapper.selectEndTime", id);
	}


	@Override
	public String selectStartTime(String id) throws SQLException {
		return session.selectOne("Attendance-Mapper.selectStartTime", id);
	}


	@Override
	public void updateStatus(AttendanceVO attend) throws SQLException {
		session.update("Attendance-Mapper.updateStatus", attend);
	}


	@Override
	public void updateInTime(AttendanceVO attend) throws SQLException {
		session.update("Attendance-Mapper.updateInTime", attend);
	}


	@Override
	public List<AttendanceVO> selectAllAttendById(String id, String month) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		if(!month.equals("all")) map.put("month", month);

		return session.selectList("Attendance-Mapper.selectAllAttendById", map);

	}


	@Override
	public void insertEmptyAttend(AttendanceVO attend) throws SQLException {
		session.update("Attendance-Mapper.insertEmptyAttend", attend);
	}

	@Override
	public List<AttendanceVO> selectAllAttendByIdForPage(String id, String month, Criteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		if(!month.equals("all"))map.put("month", month);


		List<AttendanceVO> attendList = session.selectList("Attendance-Mapper.selectAllAttendById", map, rowBounds);

		return attendList;
	}

	@Override
	public int selectAllAttendByIdCount(String id, String month) throws SQLException{
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		if(!month.equals("all"))map.put("month", month);

		return session.selectOne("Attendance-Mapper.selectAllAttendByIdCount",map);
	}


	@Override
	public String selectEndTimeForTeacher(String id) throws SQLException {
		return session.selectOne("Attendance-Mapper.selectEndTimeForTeacher", id);
	}


	@Override
	public String selectStartTimeForTeacher(String id) throws SQLException {
		return session.selectOne("Attendance-Mapper.selectStartTimeForTeacher", id);
	}

}
