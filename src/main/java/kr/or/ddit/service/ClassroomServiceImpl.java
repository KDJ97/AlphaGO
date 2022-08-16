package kr.or.ddit.service;

import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import kr.or.ddit.command.ClassroomCommand;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.ClassDAO;
import kr.or.ddit.dao.ClassroomDAO;
import kr.or.ddit.dao.UseFixtureDAO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.UseFixtVO;
import kr.or.ddit.dto.UseRoomVO;

public class ClassroomServiceImpl implements ClassroomService {
	private ClassroomDAO classroomDAO;
	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}
	
	private UseFixtureDAO useFixtureDAO;
	public void setUseFixtureDAO(UseFixtureDAO useFixtureDAO) {
		this.useFixtureDAO = useFixtureDAO;
	}

	private ClassDAO classDAO;
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}
	
	/**
	 * 강의실 테이블 목록 전체 불러오기
	 */
	@Override
	public Map<String, Object> getAllClassroom(SearchCriteria cri) throws SQLException{
		//강의실 정보 리스트
		List<ClassroomVO> classroomList = null;
		//강의실에서 사용하는 비품 리스트
		List<UseFixtVO> useFixList = null;
		//jsp에 forward할 데이터맵
		Map<String, Object> dataMap = new HashMap<String, Object>();
		//층수 계산을 위한 강의실 리스트
		List<ClassroomVO> roomList = null;
		//사용중인 강의실 정보 리스트
//		List<ClassroomVO> useAllList = null;

		//전체 강의실 리스트
		classroomList = classroomDAO.getAllClassroom(cri);
		//전체 사용 비품 리스트
		useFixList = useFixtureDAO.getUseFixture();

		// 전체 board 개수
		int totalCount = classroomDAO.selectClassroomListCount(cri);
		
		//-------------층 개수 구하기-----------------
		//층을 담을 리스트
		List<String> roomFloor = new ArrayList<String>();
		//일반 전체 강의실 리스트(No criteria)
		roomList = classroomDAO.getNoSearchClassroom();
		for(ClassroomVO room : roomList) {
			String roomno = room.getRoomNo();
			String tempno = roomno.substring(0, 1);
			roomFloor.add(tempno);
		}
		//중복제거
		Set<String> set1 = new HashSet<String>(roomFloor);
		List<String> newFloor =new ArrayList<String>(set1);
		int floorCnt = newFloor.size();//층 개수
		//-------------------------------------------
		
		//---------------사용중인 강의실 구하기---------------
		//사용중인 강의실 목록(중복있음)
//		useAllList = classroomDAO.getAllUseRoom();
		
//		int dayOfWeekValue = now.getDayOfWeek().getValue();
//		DayOfWeek 객체의 getValue() 메소드를 사용하여 요일을 숫자로 변환할 수 있습니다.
//		월요일(1) ~ 일요일(7)을 리턴합니다.
		LocalDate now = LocalDate.now();
		System.out.println(now.getDayOfWeek().getValue());
		int todayYoil = now.getDayOfWeek().getValue();
		//데이터베이스에 저장된 일요일은 0, 자바 LocalDate의 일요일은 7이기때문에 비교를 위해 값을 바꿔줌
		if(todayYoil==7) todayYoil=0;
		String tclassDay = String.valueOf(todayYoil);//요일비교를 위해 스트링으로 바꿈
		
		//사용/비사용을 체크하기위한 리스트
		List<ClassroomVO> useCheckList;
		//사용중이지 않은(사용가능) 강의실을 넣을 리스트
		List<String> unusedList = new ArrayList<String>();
		List<String> useList = new ArrayList<String>();
		
		//사용가능한 강의실 리스트
		List<ClassroomVO> canUseRoomList = new ArrayList<ClassroomVO>();
		
		for(ClassroomVO room : classroomList) {
			String roomCode = room.getRoomCode();
			ClassroomVO roomVO = new ClassroomVO();
			roomVO.setClassday(tclassDay);
			roomVO.setRoomCode(roomCode);

			useCheckList = classroomDAO.getUsedRoom(roomVO);
			if(useCheckList.isEmpty()) { //사용중이지 않으면
				unusedList.add(room.getRoomCode());
				canUseRoomList.add(room);
			}else if(!useCheckList.isEmpty()){//사용중이면
				useList.add(room.getRoomCode());
			}
		}
		
		//중복제거
		Set<String> set2 = new HashSet<String>(useList);
		List<String> newUseList =new ArrayList<String>(set2);
		Set<String> set3 = new HashSet<String>(unusedList);
		List<String> newUnUsedList =new ArrayList<String>(set3);
		
		System.out.println("사용중인 강의실 : " + newUseList);
		System.out.println("사용가능한 강의실 : " + newUnUsedList);
		
		int usedRoomCnt = newUseList.size();//사용중인 강의실 개수
		int unusedRoomCnt = newUnUsedList.size();//사용중이지 않은 강의실 개수
		//----------------------------------------------

		// PageMaker 생성.
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("classroomList", classroomList);
		dataMap.put("useFixList", useFixList);
		dataMap.put("newUseList", newUseList);
		dataMap.put("newUnUsedList", newUnUsedList);
		dataMap.put("canUseRoomList", canUseRoomList);
		
		dataMap.put("floorCnt", floorCnt);
		dataMap.put("usedRoomCnt", usedRoomCnt);
		dataMap.put("unusedRoomCnt", unusedRoomCnt);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}
	
	/**
	 * 사용중인 강의실 리스트를 반환
	 */
	@Override
	public List<ClassroomVO> selectUnUsedRoomList() throws SQLException {
//		int dayOfWeekValue = now.getDayOfWeek().getValue();
//		DayOfWeek 객체의 getValue() 메소드를 사용하여 요일을 숫자로 변환할 수 있습니다.
//		월요일(1) ~ 일요일(7)을 리턴합니다.
		LocalDate now = LocalDate.now();
		System.out.println(now.getDayOfWeek().getValue());
		int todayYoil = now.getDayOfWeek().getValue();
		//데이터베이스에 저장된 일요일은 0, 자바 LocalDate의 일요일은 7이기때문에 비교를 위해 값을 바꿔줌
		if(todayYoil==7) todayYoil=0;
		String tclassDay = String.valueOf(todayYoil);//요일비교를 위해 스트링으로 바꿈

		//전체 수업실 리스트
		List<ClassroomVO> allClassroomList = classroomDAO.getClassroom();
		//사용중인 수업실 넣을 리스트
		List<ClassroomVO> useRoomList = new ArrayList<ClassroomVO>();
		if(allClassroomList!=null&&allClassroomList.size()>0)
		for(ClassroomVO room : allClassroomList) {
			String roomCode = room.getRoomCode();
			ClassroomVO roomVO = new ClassroomVO();
			roomVO.setClassday(tclassDay);
			roomVO.setRoomCode(roomCode);

			List<ClassroomVO> useCheckList = classroomDAO.getUsedRoom(roomVO);
			if(!useCheckList.isEmpty()){//사용중이면
				useRoomList.add(room);
			}
		}
		
		return useRoomList;
	}
	
	/**
	 * 강의실 전체 정보 가져오기(강의실 개수, 수용인원, 사용가능수, 사용중 수, 층수)
	 */
	@Override
	public Map<String, Object> wholeRoomData() throws SQLException {
		//jsp에 forward할 데이터맵
		Map<String, Object> dataMap = new HashMap<String, Object>();
		//층수 계산을 위한 강의실 리스트
		List<ClassroomVO> roomList = null;
		//사용중인 강의실 정보 리스트
//		List<ClassroomVO> useAllList = null;

		//-------------층 개수 구하기-----------------
		//층을 담을 리스트
		List<String> roomFloor = new ArrayList<String>();
		//일반 전체 강의실 리스트(No criteria)
		roomList = classroomDAO.getNoSearchClassroom();
		for(ClassroomVO room : roomList) {
			String roomno = room.getRoomNo();
			String tempno = roomno.substring(0, 1);
			roomFloor.add(tempno);
		}
		//중복제거
		Set<String> set1 = new HashSet<String>(roomFloor);
		List<String> newFloor =new ArrayList<String>(set1);
		int floorCnt = newFloor.size();//층 개수
		//-------------------------------------------
		
//		int dayOfWeekValue = now.getDayOfWeek().getValue();
//		DayOfWeek 객체의 getValue() 메소드를 사용하여 요일을 숫자로 변환할 수 있습니다.
//		월요일(1) ~ 일요일(7)을 리턴합니다.
		LocalDate now = LocalDate.now();
		System.out.println(now.getDayOfWeek().getValue());
		int todayYoil = now.getDayOfWeek().getValue();
		//데이터베이스에 저장된 일요일은 0, 자바 LocalDate의 일요일은 7이기때문에 비교를 위해 값을 바꿔줌
		if(todayYoil==7) todayYoil=0;
		String tclassDay = String.valueOf(todayYoil);//요일비교를 위해 스트링으로 바꿈
		
		//사용/비사용을 체크하기위한 리스트
		List<ClassroomVO> useCheckList;
		//사용중이지 않은(사용가능) 강의실을 넣을 리스트
		List<String> unusedList = new ArrayList<String>();
		List<String> useList = new ArrayList<String>();
		
		int allCapacity = 0;
		for(ClassroomVO room : roomList) {
			String roomCode = room.getRoomCode();
			ClassroomVO roomVO = new ClassroomVO();
			roomVO.setClassday(tclassDay);
			roomVO.setRoomCode(roomCode);

			allCapacity += Integer.parseInt(room.getCapacity());
			
			useCheckList = classroomDAO.getUsedRoom(roomVO);
			if(useCheckList.isEmpty()) { //사용중이지 않으면
				unusedList.add(room.getRoomCode());
			}else if(!useCheckList.isEmpty()){//사용중이면
				useList.add(room.getRoomCode());
			}
		}
		
		//중복제거
		Set<String> set2 = new HashSet<String>(useList);
		List<String> newUseList =new ArrayList<String>(set2);
		Set<String> set3 = new HashSet<String>(unusedList);
		List<String> newUnUsedList =new ArrayList<String>(set3);
		
		int usedRoomCnt = newUseList.size();//사용중인 강의실 개수
		int unusedRoomCnt = newUnUsedList.size();//사용중이지 않은 강의실 개수
		
		int allRoomCnt = roomList.size();//전체 강의실 개수
		//----------------------------------------------

		dataMap.put("allRoomCnt", allRoomCnt);//전체 강의실 개수
		dataMap.put("allCapacity", allCapacity);//전체 강의실 개수
		dataMap.put("floorCnt", floorCnt);//층 개수
		dataMap.put("usedRoomCnt", usedRoomCnt);//사용중인 강의실 개수
		dataMap.put("unusedRoomCnt", unusedRoomCnt);//사용중이지 않은 강의실 개수
		
		return dataMap;
		
	}
	

	@Override
	public int getClassroomSeq() throws SQLException {
		int roomCode = classroomDAO.getClassroomSeq();
		return roomCode;
	}

	@Override
	public void registClassroom(ClassroomCommand roomCommand) throws SQLException {
		
		int introomCode = classroomDAO.getClassroomSeq();
		//ClassroomCode 기본키(시퀀스)
		String roomCode = String.valueOf(introomCode);
		
		String roomFloor = roomCommand.getRoomNo().substring(0, 2);
		System.out.println(roomFloor+"층");
		
		ClassroomVO roomVO = new ClassroomVO();
		roomVO.setRoomCode(roomCode);
		roomVO.setRoomFloor(roomFloor);
		roomVO.setRoomNo(roomCommand.getRoomNo());
		roomVO.setCapacity(roomCommand.getCapacity());
		roomVO.setUsePurpose(roomCommand.getUsePurpose());
		roomVO.setPicture(roomCommand.getPicture());
		//강의실 등록
		classroomDAO.registClassroom(roomVO);
		
		//사용 비품 등록
		//roomCommand의 fx들은 'Y' or 'N'의 문자열을 가짐.
		String fx1 = roomCommand.getFx1();
		String fx2 = roomCommand.getFx2();
		String fx3 = roomCommand.getFx3();
		String fx4 = roomCommand.getFx4();
		String fx5 = roomCommand.getFx5();
		String fx6 = roomCommand.getFx6();
		
		if(fx1!=null&&fx1.equals("Y")) {
//			System.out.println("fx1 from if문 : " + fx1);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx1, "FXT_01", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
		if(fx2!=null&&fx2.equals("Y")) {
//			System.out.println("fx2 from if문 : " + fx2);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx2, "FXT_02", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
		if(fx3!=null&&fx3.equals("Y")) {
//			System.out.println("fx3 from if문 : " + fx3);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx3, "FXT_03", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
		if(fx4!=null&&fx4.equals("Y")) {
//			System.out.println("fx4 from if문 : " + fx4);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx4, "FXT_04", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
		if(fx5!=null&&fx5.equals("Y")) {
//			System.out.println("fx5 from if문 : " + fx5);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx5, "FXT_05", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
		if(fx6!=null&&fx6.equals("Y")) {
//			System.out.println("fx6 from if문 : " + fx6);
			//사용비품 테이블 기본키
			int useFixtSeq = useFixtureDAO.getUseFixtSeq();
			UseFixtVO useFixtVO=fixtData(fx6, "FXT_06", roomCode, useFixtSeq);
			//등록
			useFixtureDAO.registUseFixt(useFixtVO);
		}
	}

	private UseFixtVO fixtData(String fx, String fxtCode, String roomCode, int useFixtSeq) {
		UseFixtVO fixVO = new UseFixtVO();
		if(fx.equals("Y")) {
			fixVO.setFxtcode(fxtCode);
			fixVO.setRoomCode(roomCode);
			String useFixCode = String.valueOf(useFixtSeq);
			fixVO.setFixuseno(useFixCode);
		}else {
			System.out.println("fx in fixtData method: " + fx);
		}
		return fixVO;
	}

	@Override
	public void removeClassroom(int roomCode) throws SQLException {
		useFixtureDAO.removeUseFixt(roomCode);
		classroomDAO.removeClassroom(roomCode);
	}

	@Override
	public ClassroomVO getOneClassroom(String roomCode) throws SQLException {
		ClassroomVO room = classroomDAO.getOneClassroom(roomCode);
		return room;
	}

	@Override
	public ClassroomVO selectRoomByRno(String roomNo) throws SQLException {
		return classroomDAO.selectRoomByRno(roomNo);
	}

	/**
	 * 강의실 코드에 맞는 수업의 정보를 반환하는 메서드(detail)
	 */
	@Override
	public List<ClassroomVO> selectClassByClassRoom(String roomCode) throws SQLException {
		//해당 강의실에서 진행중인 수업들의 중복되지 않는 기본키를 가져온다.
		List<ClassroomVO> classCodeList = classroomDAO.selectClassByRCode(roomCode);
		return classCodeList;
	}

	/**
	 * 해당 강의실에서 진행되는 수업의 상세 리스트(상세보기)
	 */
	@Override
	public Map<String, Object> selectClassListByRoomCode(String roomCode, SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		int totalCount = classroomDAO.selectClassListByRoomCodeCount(roomCode,cri);
		List<ClassVO> classList = classroomDAO.selectClassListByRoomCode(roomCode, cri);
		
		for(ClassVO classVO : classList) {
			String start_date = classVO.getStartDate();
			String end_date = classVO.getEndDate();
			
			String startDate = start_date.substring(0, 11);
			String endDate = end_date.substring(0, 11);
			
			classVO.setStartDate(startDate);
			classVO.setEndDate(endDate);
		}
		
		// PageMaker 생성.
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("pageMaker", pageMaker);
		dataMap.put("classList", classList);
		
		return dataMap;
	}

	//해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
	//서비스에서 오늘의 요일코드를 보내주어야한다.
	@Override
	public List<ClassVO> selectClassListByRoomCodeClassDay(String roomCode) throws SQLException {
		//오늘 요일을 구하는 작업
		LocalDate date = LocalDate.now();
		DayOfWeek dayOfWeek = date.getDayOfWeek();
		int javaDay = dayOfWeek.getValue();
		
		//db에 저장되어 있는 요일코드가 스크립트용이기 때문에 일요일이 0이고
		//JAVA LocalDate에서 지원하는 요일은 일요일이 7이기 때문에 db에 보내기 위해선 변환이 필요하다.
		int classday = getScriptClassDay(javaDay);
		
		ClassVO classVO = new ClassVO();
		classVO.setRoomCode(roomCode);
		classVO.setClassday(classday);
		
		List<ClassVO> classList = classroomDAO.selectClassListByRoomCodeClassDay(classVO);
		
		return classList;
	}
	//스크립트용 요일코드로 바꿔주는 메서드
	private int getScriptClassDay(int javaDay) {
		int classday = 0;
		if(javaDay==7) {
			classday = 0;
			return classday;
		}else {
			return javaDay;
		}
	}

	@Override
	public List<ClassroomVO> selectClassTimeByRoom(ClassVO classVO) throws SQLException {
		//오늘 요일을 구하는 작업
		LocalDate date = LocalDate.now();
		DayOfWeek dayOfWeek = date.getDayOfWeek();
		int javaDay = dayOfWeek.getValue();
		
		//db에 저장되어 있는 요일코드가 스크립트용이기 때문에 일요일이 0이고
		//JAVA LocalDate에서 지원하는 요일은 일요일이 7이기 때문에 db에 보내기 위해선 변환이 필요하다.
		int classday = getScriptClassDay(javaDay);
		classVO.setClassday(classday);
		
		List<ClassroomVO> list = classroomDAO.selectClassTimeByRoom(classVO);
		
		return list;
	}

	@Override
	public List<UseFixtVO> getUsedFixtByRoomCode(String roomCode) throws SQLException {
		return classroomDAO.getUsedFixtByRoomCode(roomCode);
	}

	@Override
	public void updateClassroom(ClassroomVO room) throws SQLException {
		classroomDAO.updateClassroom(room);
	}

	@Override
	public int selectUseFixtCountByRoomCode(ClassroomVO room) throws SQLException {
		return classroomDAO.selectUseFixtCountByRoomCode(room);
	}

	@Override
	public void insertUseFixt(UseFixtVO fixt) throws SQLException {
		classroomDAO.insertUseFixt(fixt);
	}

	@Override
	public int getUseFixtSeq() throws SQLException {
		return classroomDAO.getUseFixtSeq();
	}

	@Override
	public List<UseRoomVO> getUseRoomTimeByCpcheck(String roomCode) throws SQLException {
		return classroomDAO.getUseRoomTimeByCpcheck(roomCode);
	}



}

















