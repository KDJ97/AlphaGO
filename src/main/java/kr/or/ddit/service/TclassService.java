package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ClassPlanVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassTimeVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.HomeworkPlanVO;
import kr.or.ddit.dto.TecounseltVO;
import kr.or.ddit.dto.WeekPlanVO;

public interface TclassService {
	
	/**
	 * 수업계획서가 등록되어 진행중인 수업목록
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> classList(SearchCriteria cri) throws SQLException;
	
	/**
	 * 수업계획서가 등록되어 있지 않은 수업목록
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> unregisteredClassList(Map<String,Object> map) throws SQLException;
	
	/**
	 * 수업계획서 미등록된 Class 정보 조회
	 * 수업계획서에 수업 시간표 출력
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	Map<String, Object> selectUnregisteredClassForModal(int classCode) throws SQLException;
	
	/**
	 * 수업계획서 등록된 Class 정보 조회
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	Map<String, Object> selectRegisteredClassForModal(int classCode) throws SQLException;
	
	/**
	 * 수업계획서 등록
	 * @param classPlan
	 * @throws SQLException
	 */
	void registClassPlan(Map<String,Object> map) throws SQLException; 
	/**
	 * 수업계획서 임시저장
	 * @param classPlan
	 * @throws SQLException
	 */
	void saveClassPlan(Map<String,Object> map) throws SQLException; 
	
	/**
	 * 해당 주차의 weekplan 삭제
	 * @param wpno
	 * @throws SQLException
	 */
	void deleteClassPlan(int wpno) throws SQLException;
	
	/**
	 * 해당 번호의 homeworkplan 삭제
	 * @param homework
	 * @throws SQLException
	 */
	void deleteHomeworkPlan(int homework) throws SQLException;
	
	/**
	 * 주자 계획 등록
	 * @param map
	 * @throws SQLException
	 */
	void registWeekPlan(Map<String,Object> map) throws SQLException;
	
	/**
	 * 과제계획 등록
	 * @param map
	 * @throws SQLException
	 */
	void registHomeworkPlan(Map<String,Object> map) throws SQLException;
	
	void registTextbookAndCphead(Map<String,Object> map) throws SQLException;
	
	/**
	 * 기존에 작성했던 주차별 계획들 수정
	 * @param weekPlanVO
	 * @throws SQLException
	 */
	void updateWeekPlan(Map<String,Object> map) throws SQLException;
	
	/**
	 * 기존에 작성했던 과제 계획들 수정
	 * @param homeworkPlanVO
	 * @throws SQLException
	 */
	void updateHomeworkPlan(Map<String,Object> map) throws SQLException;

	/**
	 * 기존에 작성했던 교재,수업개요 수정
	 * @param classPlanVO
	 * @throws SQLException
	 */
	void updateClassPlan(Map<String,Object> map) throws SQLException;
	/**
	 * 기존에 작성했던 수업계획서 제출
	 * @param classPlanVO
	 * @throws SQLException
	 */
	void updateClassPlanForSubmit(Map<String,Object> map) throws SQLException;
	/**
	 * 기존에 작성했던 수업계획서 임시저장
	 * @param classPlanVO
	 * @throws SQLException
	 */
	void updateClassPlanForTempSave(Map<String,Object> map) throws SQLException;
	
	/**
	 * 강사HOME 진도현황에 출력할 해당 강사가 진행중인 수업목록
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<ClassVO> selectClassesForHome(String id) throws SQLException;
	
	/**
	 * 강사HOME 진도현황에 출력할 상세 진도내용
	 * @param cpno
	 * @return
	 * @throws SQLException
	 */
	Map<String,Object> selectProgressForHome(String cpno) throws SQLException;
	
	/**
	 * 해당 강사의 종료일이 지난 수업 목록 
	 * @return
	 * @throws SQLException
	 */
	Map<String,Object> selectClassForReview(String id) throws SQLException;
	
	/**
	 * 해당 과목의 리뷰목록 
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	Map<String,Object> selectReview(String classCode) throws SQLException;
	/**
	 * 해당 리뷰의 상제정보 조회
	 * @param reviewCode
	 * @return
	 * @throws SQLException
	 */
	ClassReviewVO selectReviewDetail(String reviewCode) throws SQLException;
	
	/**
	 * 오늘의 상담 리스트 select
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<TecounseltVO> selectTodayConsult(String id) throws SQLException;
	
	/**
	 * 오늘의 과제리스트 select
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<AssignVO> selectTodayHomework(String id) throws SQLException;
	
	/**
	 * 오늘의 시험리스트 select
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<ExamVO> selectTodayTest(String id) throws SQLException;
	
}
