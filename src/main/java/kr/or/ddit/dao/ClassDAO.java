package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.CertificateVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassingVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubDetailVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.UseRoomVO;

public interface ClassDAO {

	/**
	 * 전체 수업 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> getAllClass(Map<String, Object> dataParam) throws SQLException;

	/**
	 * 수업 리스트 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectSearchClassListCount(SearchCriteria cri) throws SQLException;

	/**
	 * 필터를 거친 리스트
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectSearchClassList(SearchCriteria cri) throws SQLException;

	/**
	 * 수업 상세 정보
	 * @param class_code
	 * @return
	 * @throws SQLException
	 */
	public ClassVO getClassDetail(int class_code) throws SQLException;

	/**
	 * 과목 상세 리스트
	 * @param subcode
	 * @return
	 * @throws SQLException
	 */
	public List<SubjectVO> getSubDetail(int subcode) throws SQLException;
	/**
	 * 수업 기본키 시퀀스 가져오기
	 * @return
	 * @throws SQLException
	 */
	public int getClassCode() throws SQLException;
	/**
	 * 수업개설
	 * @return
	 * @throws SQLException
	 */
	public int registClass(ClassVO classVO) throws SQLException;

	/**
	 * 수업 삭제
	 * @param classVO
	 * @throws SQLException
	 */
	public void removeClass(ClassVO classVO) throws SQLException;
	/**
	 * 과목명에 맞는 강사 리스트를 불러온다
	 * @param subjectName 과목명에 맞는 강사 리스트를 불러오기 위해 과목명을 넣어줌
	 * @throws SQLException
	 */
	public List<MemberVO> getTeacherList(String subjectName) throws SQLException;

	/**
	 * 아이디에 맞는 강사 리스트를 불러온다
	 * @param id id에 맞는 강사 리스트를 불러오기 위해 id 넣어줌
	 * @throws SQLException
	 */
	public MemberVO getTeacherById(String id) throws SQLException;

	/**
	 * 수업코드에 맞는 강사 상세를 불러온다
	 * @param classCode 해당 수업 담당 강사 정보이기 때문에 수업코드 넣어줌
	 * @return
	 * @throws SQLException
	 */
	public MemberVO getTeacherByClassCode(String classCode) throws SQLException;

	/**
	 * 강사 아이디에 맞는 자격증 리스트를 불러온다
	 * @param id 파라미터로 넣어줄 강사id
	 * @return 자격증 리스트
	 * @throws SQLException
	 */
	public List<CertificateVO> getCertificateList(String id) throws SQLException;

	/**
	 * 원생이 수강중인 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<ClassingVO> getClassing(String id) throws SQLException;

	/**
	 * 사용중인 강의실 리스트를 불러온다
	 * @param roomCode 강의실 코드를 넣어준다
	 * @return 사용중인 강의실의 사용시간, 사용기간을 보내줌
	 * @throws SQLException
	 */
	public List<UseRoomVO> getUseRoomList(String roomCode) throws SQLException;

	/**
	 * 수업 개설
	 * @param classVO classCode, startDate, endDate, id, totalTime
	 * @throws SQLException
	 */
	public int updateClassOpen(ClassVO classVO) throws SQLException;

	/**
	 * 시간상세 테이블 기본키 시퀀스 가져오기
	 * @return
	 * @throws SQLException
	 */
	public int getTimedetailSeq() throws SQLException;
	/**
	 * 시간 상세 테이블 insert
	 * @param timeDetailVO
	 * @return
	 * @throws SQLException
	 */
	public int registTimeDetail(TimeDetailVO timeDetailVO) throws SQLException;

	/**
	 * 수업목록에서 사용할 수업리스트
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectSearchClassListInClassList(SearchCriteria cri) throws SQLException;

	/**
	 * 수업을 듣는 학생 리스트(개수계산용임)
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassingVO> selectClassIngMemberList(String classCode) throws SQLException;

	/**
	 * 하나의 수업 일정에 대한 정보를 가져오는 메서드(교시, 요일)
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<TimeDetailVO> selectClassTimeDetail(String classCode) throws SQLException;

	/**
	 * 해당 아이디에 대한 학교 이름, 코드, 학년을 받아온다
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public MemberVO selectSchoolDetail(String id) throws SQLException;

	/**
	 * 해당 강사의 리뷰 목롞을 불러온다
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> selectClassReviewById(String id) throws SQLException;

	/**
	 * 강사 경력 가져오기
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<CareerVO> getCareer(String id) throws SQLException;

	/**
	 * 해당 수업의 리뷰를 불러온다
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassReviewVO> selectClassReview(String classCode) throws SQLException;

	/**
	 * 해당 수업을 수강하는 수강생 id, 수업신청일 목록
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<ClassingVO> selectClassingByClassCode(String classCode) throws SQLException;

	/**
	 * 해당 수업 과제의 시작일보다 수업 신청일이 더 큰 과제들
	 * @param classing 수업코드, 수업신청일
	 * @return
	 * @throws SQLException
	 */
	public List<AssignVO> selectAssignByDate(ClassingVO classing) throws SQLException;

	/**
	 * 해당 과제를 제출했는지 여부를 카운트로 반환(제출했으면  1이다)
	 * @param assignAttachVO 과제코드, 아이디
	 * @return
	 * @throws SQLException
	 */
	public int selectAssignAttachCheckCount(AssignAttachVO assignAttachVO) throws SQLException;

	/**
	 * 해당 수업의 시험 점수를 가져오는 메서드
	 * @param classingVO id, classCode
	 * @return
	 * @throws SQLException
	 */
	public List<AcademyScoreVO> selectExamScoreById(ClassingVO classingVO) throws SQLException;

	/**
	 * 해당 수업의 수업 시수를 가져온다(재무 계산용)
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public ClassVO getTotalTimeByClassCode(String classCode) throws SQLException;

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
	 * 해당 수업의 수업시간 데이터를 가져온다
	 * @param classCode
	 * @return
	 * @throws SQLException
	 */
	public List<TimeDetailVO> selectTimeDetailByClassCode(String classCode) throws SQLException;

	/**
	 * 수업기간이 지난 수업코드들을 가져온다(스케줄러용)
	 * @return classCode 리스트
	 * @throws SQLException
	 */
	public List<String> selectEndClassCode() throws SQLException;

	/**
	 * 해당 수업의 시간표를 삭제한다(스케줄러용)
	 * @param classCode
	 * @throws SQLException
	 */
	public void deleteEndClassFromTimeDetail(String classCode) throws SQLException;

	/**
	 * 학생이 듣는 수업코드, 이름 리스트(원생 학원성적 조회 리스트용)
	 * @param id
	 * @throws SQLException
	 */
	public List<ClassVO> selectClassNameListById(String id) throws SQLException;

	/**
	 * 수강신청 목록 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<ClassVO> selectApplicationClassList(String id, SearchCriteria cri) throws SQLException;
	public int selectApplicationClassListCount(String id, SearchCriteria cri) throws SQLException;

	/**
	 * 수업상세코드로 과목VO 가져오기
	 * @param code
	 * @return
	 * @throws SQLException
	 */
	public SubjectVO selectSubjectBySubdetail(int code) throws SQLException;

	public String selectOverStuCnt(int code) throws SQLException;

	public void registClassing(ClassingVO vo) throws SQLException;

	public ClassVO selectRecomendClass(String grade, String rank, int subjectCode) throws SQLException;

	public ClassingVO getClassingByclassingVO(ClassingVO vo) throws SQLException;

}

















