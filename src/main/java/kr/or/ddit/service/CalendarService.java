package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.CalendarVO;

public interface CalendarService {

	public List<CalenderListCommand> getAllCalendar(String id) throws SQLException;

	public void registCalendar(CalendarVO calendarVO) throws SQLException;

	public void resetCalendar() throws SQLException;

	 int insertCalender(CalendarVO calendarVO) throws SQLException;

	public List<CalenderListCommand> getCalendarDataForSubmit(String id) throws SQLException;

	public List<String> getReservationList(String date, String type, String counselor) throws SQLException;
}
