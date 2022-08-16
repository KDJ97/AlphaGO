package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dao.CalendarDAO;
import kr.or.ddit.dto.CalendarVO;

public class CalendarServiceImpl implements CalendarService {

	public CalendarDAO calendarDAO;
	public void setCalenderDAO(CalendarDAO calendarDAO) {
		this.calendarDAO = calendarDAO;
	}

	@Override
	public List<CalenderListCommand> getAllCalendar(String id) throws SQLException {
		List<CalenderListCommand> calenders = null;
			calenders = calendarDAO.selectAllCalender(id);
		return calenders;
	}

	@Override
	public void registCalendar(CalendarVO calendarVO) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void resetCalendar() throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public int insertCalender(CalendarVO calendarVO) throws SQLException {
		int abc = calendarDAO.insertCalender(calendarVO);
		return abc;
	}

	@Override
	public List<CalenderListCommand> getCalendarDataForSubmit(String id) throws SQLException{
		return calendarDAO.selectAllCalendarById(id);
	}

	@Override
	public List<String> getReservationList(String date, String type, String counselor) throws SQLException {
		switch (type) {
		case "t":	//성적 상담 - 선생님
			return calendarDAO.selectReservationListToT(counselor, date);

		case "m":	//진로 상담 - 원장님
			return calendarDAO.selectReservationListToM(counselor, date);

		}
		return null;
	}


}
