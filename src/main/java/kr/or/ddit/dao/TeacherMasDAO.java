package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AttendanceVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;

public interface TeacherMasDAO {

	List<TeachermasVO> selectTeacherList() throws Exception;

	List<TeachermasVO> selectTeacherList(Criteria cri) throws Exception;

	int selectTeacherListCount(SearchCriteria cri) throws Exception;

	// 검색 결과의 전체 리스트 개수
	int selectSearchTeacherListCount(SearchCriteria cri) throws Exception;

	List<TeachermasVO> selectSearchTeacherList(SearchCriteria cri) throws SQLException;

	public void insertTeacher(TeachermasVO teamas) throws SQLException;

//	
	TeachermasVO selectTeacherById(String id) throws SQLException;

	TeachermasVO selectTeacherByPicture(String picture) throws SQLException;

//	
//	TeachermasVO selectTeacherByPicture(String picture) throws SQLException;
//	
	public void deleteTeacher(String id) throws SQLException;

	String selectTeacherSequenceNextValue() throws SQLException;

	public TeachermasVO selectScoreBySubjectName(String subjectName) throws SQLException;

	// 선생출석조회
	List<TeachermasVO> selectTeacherAttendList() throws Exception;

	List<TeachermasVO> selectTeacherAttendList(Criteria cri) throws Exception;

	int selectTeacherAttendListCount(SearchCriteria cri) throws Exception;

	// 검색 결과의 전체 리스트 개수
	int selectSearchTeacherAttendListCount(SearchCriteria cri) throws Exception;

	List<TeachermasVO> selectSearchTeacherAttendList(SearchCriteria cri) throws SQLException;

	// 출결상세
	public List<TeachermasVO> selectAllAttendTeacherById(String id) throws SQLException;

	// 도넛차트활용 테이블
	public List<TeachermasVO> selectAllAttendTeacherByChartId(String id) throws SQLException;

	int selectSearchAllAttendTeacherByIdListCount(String id) throws Exception;

	// 1학기중간
	public TeachermasVO selectFinalTestBykor(String subject) throws SQLException;

	// 1학기기말
	public TeachermasVO selectFinalTestByFisrtFinal(String subject) throws SQLException;

	// 2학기중간
	public TeachermasVO selectFinalTestBySecondMiddle(String subject) throws SQLException;

	// 2학기기말
	public TeachermasVO selectFinalTestBySecondFinal(String subject) throws SQLException;

	// 수업내용
	List<TeachermasVO> selectclassName(String id) throws Exception;

	// 수업후기리스트
	List<TeachermasVO> selectReviewListByClassCode(int classCode) throws Exception;

	// 전체후기리스트
	List<TeachermasVO> selectAllReviewListById(String id) throws Exception;

	// 강사경력리스트
	List<TeachermasVO> selectTeacherCareer(String id) throws Exception;
	
	
	//전체 별점 평균
	
	public TeachermasVO selectAllStarById(String id) throws SQLException;
	
	//수업마다 별점 평균 
	public TeachermasVO selectAvgByclassCode(int classCode) throws SQLException;
	
	//해당강사의 전체 수업 리스트 
	List<TeachermasVO> selectClassTeacheringById(String id) throws Exception;
	
	
	//강사의 해당수업의 시작시간과 끝나는시간 
	public TeachermasVO selectClassTimeByClassDay(ClassVO classvo)throws SQLException;
	

	//강사의 수업상세 
	public TeachermasVO selectTeacherAttendDetail(String id)throws SQLException;
	
	/**
	 * 사용자 사진 시퀀스
	 * @return
	 * @throws SQLException
	 */
	public int getMemberPictureSeq() throws SQLException;
}
