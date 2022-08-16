package kr.or.ddit.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.CalenderListCommand;
import kr.or.ddit.dto.CalendarVO;

public class CalendarDAOImpl implements CalendarDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<CalenderListCommand> selectAllCalender(String id) throws SQLException {

		//calenderVO로 받는 작업 하셈

		List<CalendarVO> calenderList = session.selectList("Calender-Mapper.getAllCalender",id);
		List<CalenderListCommand> voList = new ArrayList<CalenderListCommand>();

//		System.out.println("daoimpl : "+calenderList);

		if(calenderList!=null && calenderList.size()>0) {
			for(int i = 0; i < calenderList.size(); i++) {
				CalenderListCommand vo = new CalenderListCommand();
				vo.setId(calenderList.get(i).getCounselor());
				vo.setTitle((String)calenderList.get(i).getTitle());
				vo.setName((String)calenderList.get(i).getName());
				System.out.println(vo.getName());
				boolean allDay = false;
				vo.setAllDay(allDay);
				//날짜..
//				Calendar calendar = Calendar.getInstance();
//				Date date = calendar.getTime();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.000'Z'");
				sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
				// "2018-01-19T20:34:46.177+09:00"

				String start = sdf.format(calenderList.get(i).getPcStart());
				String end = sdf.format(calenderList.get(i).getPcEnd());

				vo.setStart(start);
				vo.setEnd(end);
//				System.out.println(vo.getTitle());
//				System.out.println(vo.getId());
//				System.out.println(vo.getStart());
//				System.out.println(vo.getEnd());
				voList.add(vo);

			}

		}
		return voList;
	}

//	@Override
//	public void insertCalender(CalendarVO calendarVO) throws SQLException {
//		session.update("Calender-Mapper.insertCalender", calendarVO);
//	}

	@Override
	public void deleteCalender() throws SQLException {
		session.update("Calender-Mapper.deleteCalender");
	}

	@Override
	public int insertCalender(CalendarVO calendarVO) throws SQLException {
		int calender=session.update("Calender-Mapper.insertCalender",calendarVO);



		return calender;
	}

	@Override
	public List<CalenderListCommand> selectAllCalendarById(String id) throws SQLException {
		//원장 상담 일정리스트
		List<CalendarVO> masterList = session.selectList("Calender-Mapper.selectAllCalendarByIdToMaster",id);
		List<CalendarVO> teacherList = session.selectList("Calender-Mapper.selectAllCalendarByIdToTeacher",id);

		List<CalendarVO> calenderList = new ArrayList<>();
		calenderList.addAll(masterList);
		calenderList.addAll(teacherList);


		List<CalenderListCommand> voList = new ArrayList<CalenderListCommand>();

		if(calenderList!=null && calenderList.size()>0) {
			for(int i = 0; i < calenderList.size(); i++) {
				CalenderListCommand vo = new CalenderListCommand();
				vo.setId(calenderList.get(i).getCounselor());
				vo.setTitle((String)calenderList.get(i).getTitle());
				vo.setName((String)calenderList.get(i).getName());
				System.out.println(vo.getName());
				boolean allDay = false;
				vo.setAllDay(allDay);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.000'Z'");
				sdf.setTimeZone(TimeZone.getTimeZone("UTC"));

				String start = sdf.format(calenderList.get(i).getPcStart());
				String end = sdf.format(calenderList.get(i).getPcEnd());

				vo.setStart(start);
				vo.setEnd(end);

				voList.add(vo);
			}

		}
		return voList;
	}

	@Override
	public List<String> selectReservationListToM(String counselor, String date) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("counselor", counselor);
		keyMap.put("date", date);

		return session.selectList("Calender-Mapper.selectReservationListToM", keyMap);
	}

	@Override
	public List<String> selectReservationListToT(String counselor, String date) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("counselor", counselor);
		keyMap.put("date", date);
		return session.selectList("Calender-Mapper.selectReservationListToT", keyMap);
	}

}
