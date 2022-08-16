package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.CalendarVO;
import kr.or.ddit.dto.PacounseltVO;

public interface CalendarDAO {
	/**
	 *
	 *
	 * @return 캘린더에 뿌릴 일정 리스트
	 * @throws SQLException
	 */
	public List<CalenderListCommand> selectAllCalender(String id) throws SQLException;

	//public void insertCalender(CalendarVO calendarVO) throws SQLException;

	public void deleteCalender() throws SQLException;

	 int insertCalender(CalendarVO calendarVO) throws SQLException;

	 public List<CalenderListCommand> selectAllCalendarById(String id) throws SQLException;

	 public List<String> selectReservationListToM(String counselor, String date) throws SQLException;

	 public List<String> selectReservationListToT(String counselor, String date) throws SQLException;
}
