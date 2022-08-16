package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassingVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubDetailVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.UseRoomVO;

public interface ClassService {

	/**
	 * 수업목록을 불러오는 메서드
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> getSearchClassList(SearchCriteria cri) throws SQLException;

	/**
	 * 
	 * @param subcode 
	 * @return
	 * @throws SQLException
	 */
	public List<SubjectVO> getSubDetail(int subcode) throws SQLException;
	/**
	 * 수업 상세 정보 받기(수업관리)
	 * @param class_code
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> getClassDetail(int class_code) throws SQLException;
	/**
 	 * 수업 상세 정보 받기(수업목록)
	 * @param class_code
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> getClassDeepDetail(int class_code) throws SQLException;

	public void registClass(ClassVO classVO) throws SQLException;

	public void removeClass(ClassVO classVO) throws SQLException;

	public List<MemberVO> getTeacherList(String subjectName) throws SQLException;

	public Map<String, Object> getTeacherDetail(String id) throws SQLException;

	/**
	 * 수업 개설페이지에 필요한 모든 요소들
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> getClassRegElementList(SearchCriteria cri) throws SQLException;

	public Map<String, Object> getClassing(String id) throws SQLException;

	/**
	 * 사용중인 강의실 리스트의 사용시간 정보들을 불러온다
	 * @param roomCode 룸코드를 넣어 그에 맞는 사용시간을 알아낸다
	 * @return
	 * @throws SQLException
	 */
	public List<UseRoomVO> getUseRoomList(String roomCode) throws SQLException;

	/**
	 * 수업을 개설하는 service
	 * @param classVO classCode, startDate, endDate, id, totalTime
	 * @throws SQLException
	 */
	public int updateClassOpen(Map<String, Object> map) throws SQLException;

	/**
	 * 수업목록에서 사용할 수업리스트
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> selectSearchClassListInClassList(SearchCriteria cri) throws SQLException;
	/**
	 * 수업 상세페이지에 관한 정보를 작업하는 서비스
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> classDetail(String classCode) throws SQLException;

	/**
	 * 오늘보다 종료일이 큰 수업 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassByEndDate() throws SQLException;

	/**
	 * 오늘보다 시작일이 큰 수업 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassByStartDate() throws SQLException;

	/**
	 * 해당 수업의 수업 시간들을 가지고오는 서비스
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<TimeDetailVO> selectTimeDetailByClassCode(String classCode) throws SQLException;

	/**
	 * 수강신청 목록 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> getApplicationClassList(String id, Criteria cri) throws SQLException;

	public SubjectVO selectSubjectBySubdetail(int code) throws SQLException;

	public String selectOverStuCnt(int code) throws SQLException;

	public void registClassing(ClassingVO vo) throws SQLException;

	public ClassVO getRecomendClass(double avg, String grade, int subjectCode) throws SQLException;

	public ClassingVO getClassingByclassingVO(ClassingVO vo) throws SQLException;
}








