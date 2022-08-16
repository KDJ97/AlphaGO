package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;

public interface TeacherMasService {

	Map<String, Object> getTeacherList(Criteria cri) throws SQLException;

	public void regist(TeachermasVO teamas, String uploadPath) throws Exception;

	public TeachermasVO getTeacher(String id) throws Exception;

	public void remove(String id) throws Exception;

	public TeachermasVO selectScoreBySubjectName(String subjectName) throws SQLException;

	Map<String, Object> getTeacherAttendList(Criteria cri) throws SQLException;

	Map<String, Object> getTeacherAllAttendList(String id) throws Exception;

	List<TeachermasVO> selectAllAttendTeacherByChartId(String id) throws SQLException;

	public TeachermasVO selectFinalTestBykor(String subject) throws SQLException;

	public TeachermasVO selectFinalTestByFisrtFinal(String subject) throws SQLException;

	public TeachermasVO selectFinalTestBySecondMiddle(String subject) throws SQLException;

	public TeachermasVO selectFinalTestBySecondFinal(String subject) throws SQLException;

	List<TeachermasVO> selectclassName(String id) throws Exception;

	List<TeachermasVO> selectReviewListByClassCode(int classCode) throws Exception;

	List<TeachermasVO> selectAllReviewListById(String id) throws Exception;

	//강사경력
	List<TeachermasVO> selectTeacherCareer(String id) throws Exception;
	
	
	public TeachermasVO selectAllStarById(String id) throws SQLException;
	
	//수업에 따른 전체 별점
	public TeachermasVO selectAvgByclassCode(int classCode) throws SQLException;
	
	//해당강사의 전체 수업리스트 시작일과 마감일 사이에서
	Map<String, Object> selectClassTeacheringById(String id) throws	Exception;
	
	//강사출석 상세
		public TeachermasVO selectTeacherAttendDetail(String id) throws SQLException;
	
	
}
