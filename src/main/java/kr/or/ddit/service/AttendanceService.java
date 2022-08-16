package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.dto.AttendanceVO;

public interface AttendanceService {

	void attendQR(AttendanceVO attend) throws SQLException, Exception;
	
	void attendQRForTeacher(AttendanceVO attend) throws SQLException, Exception;

	AttendanceVO getAttendance(String id) throws SQLException, Exception;

	void insertEmptyAttend(String id, Date date) throws SQLException;

	List<AttendanceVO> getAttendanceList(String id, String month) throws SQLException;

	Map<String, Object> getAttendanceListForPage(String id, String month, Criteria cri) throws SQLException;
	
	
}
