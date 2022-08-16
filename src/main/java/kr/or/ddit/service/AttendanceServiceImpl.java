package kr.or.ddit.service;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.dao.AttendanceDAO;
import kr.or.ddit.dto.AttendanceVO;

public class AttendanceServiceImpl implements AttendanceService{

	private AttendanceDAO attendanceDAO;
	public void setAttendanceDAO(AttendanceDAO attendanceDAO) {
		this.attendanceDAO = attendanceDAO;
	}


	@Override
	public void attendQR(AttendanceVO attend) throws SQLException, Exception {
		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd ");
		SimpleDateFormat dateParser = new SimpleDateFormat("yyyyMMdd HH:mm");

		AttendanceVO selectAtt = attendanceDAO.selectAttendById(attend);
	
		if(selectAtt == null || selectAtt.getInTime() == null) {
			
			//수업이 없는 경우
			if(attendanceDAO.selectStartTime(attend.getId()) == null) {
				return;
			}
			
			String startTime = simpleDateFormat.format(nowDate) + attendanceDAO.selectStartTime(attend.getId());
			Date startDate = dateParser.parse(startTime);

			attend.setAttendanceStatus(0);	// 출석 중

			// 출석 기준 시간이 출석 시간보다 과거 경우 -> 지각
			if(startDate.compareTo(nowDate) < 0) {
				attend.setAttendanceStatus(3);
			}

			//출석 정보가 없는 경우 - 새로운 출석 정보  insert
			if(selectAtt == null) {
				int code = attendanceDAO.selectAttNextSeq();
				attend.setAttendanceCode(code);
				attendanceDAO.insertNewAttend(attend);
			}else {
				//기존 attned의 inTime 입력 및 status 변경
				attend.setAttendanceCode(selectAtt.getAttendanceCode());
				attend.setInTime(nowDate);

				attendanceDAO.updateStatus(attend);
				attendanceDAO.updateInTime(attend);
			}
		}else {
			// 출석 정보가 있는 경우 - outTime을 update
			attendanceDAO.updateOutTimeIsNow(selectAtt);

			// status가 0이거나 조퇴(5)가 아닌 경우에는 status 를 변경하지 않음
			if(selectAtt.getAttendanceStatus() != 0 || selectAtt.getAttendanceStatus() != 5) return;

			// 상태 값 계산
			selectAtt = attendanceDAO.selectAttendById(attend);

			// 해당 날짜의 퇴실시간
			String endTime = simpleDateFormat.format(nowDate) + attendanceDAO.selectEndTime(attend.getId());

			Date endDate = dateParser.parse(endTime);

 			if(endDate.compareTo(selectAtt.getOutTime()) <= 0) {
 				// 퇴근 기준 시간이 퇴실 시간보다 과거이거나 같은 경우 -> 출석
 				selectAtt.setAttendanceStatus(1);
			}else {
				// 퇴근 기준시간이 퇴실시간보다 미래인경우 -> 조퇴
				selectAtt.setAttendanceStatus(5);
			}
 			// 업데이트
 			attendanceDAO.updateStatus(selectAtt);
		}
	}

	
	
	@Override
	public AttendanceVO getAttendance(String id) throws SQLException, Exception {
		// id 가 가진 당일 attence
		AttendanceVO attend = new AttendanceVO();
		attend.setId(id);
		attend.setRegDate(new Date());
		return attendanceDAO.selectAttendById(attend);


	}


	@Override
	public void insertEmptyAttend(String id, Date date) throws SQLException {
		AttendanceVO attend = new AttendanceVO();
		attend.setAttendanceCode(attendanceDAO.selectAttNextSeq());
		attend.setId(id);
		attend.setRegDate(date);

		attendanceDAO.insertEmptyAttend(attend);

	}


	@Override
	public List<AttendanceVO> getAttendanceList(String id, String month) throws SQLException {
		return attendanceDAO.selectAllAttendById(id, month);
	}

	@Override
	public  Map<String,Object> getAttendanceListForPage(String id, String month, Criteria cri) throws SQLException{
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(attendanceDAO.selectAllAttendByIdCount(id, month));

		List<AttendanceVO> attendList = attendanceDAO.selectAllAttendByIdForPage(id, month, cri);

		dataMap.put("attendList", attendList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}


	@Override
	public void attendQRForTeacher(AttendanceVO attend) throws SQLException, Exception {
		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd ");
		SimpleDateFormat dateParser = new SimpleDateFormat("yyyyMMdd HH:mm");

		System.out.println("attendServiceImpl에서 attend : " + attend); 
		
		AttendanceVO selectAtt = attendanceDAO.selectAttendById(attend);
	
		if(selectAtt == null || selectAtt.getInTime() == null) {
			//수업이 없는 경우
			if(attendanceDAO.selectStartTimeForTeacher(attend.getId()) == null) {
				return;
			}
			
			String startTime = simpleDateFormat.format(nowDate) + attendanceDAO.selectStartTimeForTeacher(attend.getId());
			Date startDate = dateParser.parse(startTime);

			attend.setAttendanceStatus(0);	// 출석 중

			// 출석 기준 시간이 출석 시간보다 과거 경우 -> 지각
			if(startDate.compareTo(nowDate) < 0) {
				attend.setAttendanceStatus(3);
			}

			//출석 정보가 없는 경우 - 새로운 출석 정보  insert
			if(selectAtt == null) {
				int code = attendanceDAO.selectAttNextSeq();
				attend.setAttendanceCode(code);
				attendanceDAO.insertNewAttend(attend);
			}else {
				//기존 attned의 inTime 입력 및 status 변경
				attend.setAttendanceCode(selectAtt.getAttendanceCode());
				attend.setInTime(nowDate);

				attendanceDAO.updateStatus(attend);
				attendanceDAO.updateInTime(attend);
			}
		}else {
			// 출석 정보가 있는 경우 - outTime을 update
			attendanceDAO.updateOutTimeIsNow(selectAtt);

			// status가 0이거나 조퇴(5)가 아닌 경우에는 status 를 변경하지 않음
			if(selectAtt.getAttendanceStatus() != 0 || selectAtt.getAttendanceStatus() != 5) return;

			// 상태 값 계산
			selectAtt = attendanceDAO.selectAttendById(attend);

			// 해당 날짜의 퇴실시간
			String endTime = simpleDateFormat.format(nowDate) + attendanceDAO.selectEndTimeForTeacher(attend.getId());

			Date endDate = dateParser.parse(endTime);

 			if(endDate.compareTo(selectAtt.getOutTime()) <= 0) {
 				// 퇴근 기준 시간이 퇴실 시간보다 과거이거나 같은 경우 -> 출석
 				selectAtt.setAttendanceStatus(1);
			}else {
				// 퇴근 기준시간이 퇴실시간보다 미래인경우 -> 조퇴
				selectAtt.setAttendanceStatus(5);
			}
 			// 업데이트
 			attendanceDAO.updateStatus(selectAtt);
		}
		
	}


}
