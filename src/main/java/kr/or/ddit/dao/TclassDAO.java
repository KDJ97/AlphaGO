package kr.or.ddit.dao;

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

public interface TclassDAO {
	
	/**
	 * 수업계획서가 등록되어 진행중인 수업목록
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectSearchClassList(SearchCriteria cri) throws SQLException;
	
	/**
	 * 수업계획서가 등록되어 있지 않은 수업목록
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectSearchUnregisteredClassList(Map<String,Object> map) throws SQLException;
	
	/**
	 * 해당수업의  상세정보 조회
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public ClassVO selectClassForModal(int classCode) throws SQLException;
	
	/**
	 * 수업계획서에 수업 시간표 출력
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassTimeVO> selectClassTime(int classCode) throws SQLException;
	
	/**
	 * 수업계획서 seq값 가져오기
	 * @return
	 * @throws SQLException
	 */
	int selectClassPlanSeqNextValue() throws SQLException;
	
	/**
	 * weekplan seq값 가져오기
	 * @return
	 * @throws SQLException
	 */
	int selectWeekPlanSeqNextValue() throws SQLException;
	
	/**
	 * homeworkplan seq값 가져오기
	 * @return
	 * @throws SQLException
	 */
	int selectHomeworkPlanSeqNextValue() throws SQLException;
	
	/**
	 * 수업계획서 insert
	 * @param classPlan
	 * @throws SQLException
	 */
	void insertClassPlan(ClassPlanVO classPlan) throws SQLException;
	
	/**
	 * 주차별 계획 insert
	 * @param weekPlan
	 * @throws SQLException
	 */
	void insertWeekPlan(WeekPlanVO weekPlan) throws SQLException;
	
	/**
	 * 과제계획 insert
	 * @param homeworkPlan
	 * @throws SQLException
	 */
	void insertHomeworkPlan(HomeworkPlanVO homeworkPlan) throws SQLException;
	
	/**
	 * 해당 수업의 수업개요 및 교재 출력
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	ClassPlanVO selectCPNOandTextbook(int classCode) throws SQLException;
	
	/**
	 * 해당 수업의 수업계획리스트 출력
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	List<WeekPlanVO> selectWeekPlan(int classCode) throws SQLException;
	
	/**
	 * 해당 수업의 과제계획리스트 출력
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	List<HomeworkPlanVO> selectHomeworkPlan(int classCode) throws SQLException;
	
	/**
	 * 수업계획서를 등록하고 수업테이블에 업데이트 
	 * @param classVO
	 * @throws SQLException
	 */
	void updateClassToRegisterClassPlan(ClassVO classVO) throws SQLException;
	
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
	void deleteHomeworkPlan(int homeworkplan) throws SQLException;
	
	/**
	 * 기존에 작성했던 주차별 계획들 수정
	 * @param weekPlanVO
	 * @throws SQLException
	 */
	void updateWeekPlan(WeekPlanVO weekPlanVO) throws SQLException;
	
	/**
	 * 기존에 작성했던 과제 계획들 수정
	 * @param homeworkPlanVO
	 * @throws SQLException
	 */
	void updateHomeworkPlan(HomeworkPlanVO homeworkPlanVO) throws SQLException;
	
	/**
	 * 기존에 작성했던 교재,수업개요 수정
	 * @param classPlanVO
	 * @throws SQLException
	 */
	void updateClassPlan(ClassPlanVO classPlanVO) throws SQLException;
	
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
	List<WeekPlanVO> selectProgressForHome(String cpno) throws SQLException;
	
	/**
	 * 총 몇주차인지 count
	 * @param cpno
	 * @return
	 * @throws SQLException
	 */
	int weekPlanCount(String cpno) throws SQLException;
	
	/**
	 * 해당 강사의 종료일이 지난 수업 목록 
	 * @return
	 * @throws SQLException
	 */
	List<ClassVO> selectClassForReview(String id) throws SQLException;
	
	/**
	 * 해당 과목의 리뷰목록 
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	List<ClassReviewVO> selectReview(String classCode) throws SQLException;
	
	/**
	 * 해당 리뷰의 상제정보 조회
	 * @param reviewCode
	 * @return
	 * @throws SQLException
	 */
	ClassReviewVO selectReviewDetail(String reviewCode) throws SQLException;
	/**
	 * 해당 강사의 총 리뷰목록 
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<ClassReviewVO> selectAllReview(String id) throws SQLException;
	
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



















