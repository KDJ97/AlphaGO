package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.AttendanceVO;

public interface AttendanceDAO {

	public AttendanceVO selectAttendById(AttendanceVO attend) throws SQLException;

	public int selectAttNextSeq() throws SQLException;

	public void insertNewAttend(AttendanceVO attend) throws SQLException;

	public void updateOutTimeIsNow(AttendanceVO attend) throws SQLException;

	public String selectEndTime(String id) throws SQLException;

	public String selectStartTime(String id) throws SQLException;

	public void updateStatus(AttendanceVO attend) throws SQLException;

	public void updateInTime(AttendanceVO attend)throws SQLException;

	public List<AttendanceVO> selectAllAttendById(String id, String month) throws SQLException;

	public void insertEmptyAttend(AttendanceVO attend) throws SQLException;

	public List<AttendanceVO> selectAllAttendByIdForPage(String id, String month, Criteria cri) throws SQLException;

	public int selectAllAttendByIdCount(String id, String month) throws SQLException;
	
	public String selectEndTimeForTeacher(String id) throws SQLException;

	public String selectStartTimeForTeacher(String id) throws SQLException;
}
