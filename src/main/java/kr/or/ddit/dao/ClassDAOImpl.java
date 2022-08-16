package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

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

public class ClassDAOImpl implements ClassDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	/**
	 * 페이지네이션이 가능한 수업 목록을 불러오는 메서드
	 */
	@Override
	public List<ClassVO> selectSearchClassList(SearchCriteria cri) throws SQLException {
		cri.setPerPageNum(5);
		int offset=cri.getStartRowNum();
		int limit=cri.getPerPageNum();
		RowBounds rowBounds=new RowBounds(offset,limit);

		List<ClassVO> classList = session.selectList("Class-Mapper.selectSearchClassList", cri, rowBounds);

		return classList;
	}
	/**
	 * 모든 수업 리스트
	 */
	@Override
	public List<ClassVO> getAllClass(Map<String, Object> dataParam) throws SQLException {
		List<ClassVO> classList = session.selectList("Class-Mapper.getAllClass", dataParam);
		return classList;
	}

	/**
	 * 리스트 전체 개수를 가져온다.
	 */
	@Override
	public int selectSearchClassListCount(SearchCriteria cri) throws SQLException {
		return session.selectOne("Class-Mapper.selectSearchClassListCount",cri);
	}

	/**
	 * 과목영역 정보 리스트를 불러온다
	 */
	@Override
	public List<SubjectVO> getSubDetail(int subcode) throws SQLException {
		return session.selectList("Class-Mapper.getSubDetail", subcode);
	}

	/**
	 * 수업 상세 정보를 불러온다.
	 */
	@Override
	public ClassVO getClassDetail(int class_code) throws SQLException {
		return session.selectOne("Class-Mapper.getClassDetail", class_code);
	}

	@Override
	public int getClassCode() throws SQLException {
		return session.selectOne("Class-Mapper.getClassCode");
	}

	@Override
	public int registClass(ClassVO classVO) throws SQLException {
		return session.update("Class-Mapper.registClass", classVO);
	}

	@Override
	public void removeClass(ClassVO classVO) throws SQLException {
		session.update("Class-Mapper.removeClass", classVO);
	}

	/**
	 * 과목명에 맞는 강사 리스트를 불러온다
	 * @param subjectName 과목명에 맞는 강사 리스트를 불러오기 위해 과목명을 넣어줌
	 * @throws SQLException
	 */
	@Override
	public List<MemberVO> getTeacherList(String subjectName) throws SQLException {
		return session.selectList("Class-Mapper.getTeacherList", subjectName);
	}
	/**
	 * id에 맞는 강사 상세 정보
	 */
	@Override
	public MemberVO getTeacherById(String id) throws SQLException {
		return session.selectOne("Class-Mapper.getTeacherById", id);
	}

	/**
	 * classCode에 맞는 강사 상세
	 */
	@Override
	public MemberVO getTeacherByClassCode(String classCode) throws SQLException {
		return session.selectOne("Class-Mapper.getTeacherByClassCode", classCode);
	}

	/**
	 * 아이디에 맞는 자격증리스트
	 */
	@Override
	public List<CertificateVO> getCertificateList(String id) throws SQLException {
		return session.selectList("Class-Mapper.getCertificate", id);
	}


	@Override
	public List<ClassingVO> getClassing(String id) throws SQLException {

		return session.selectList("Class-Mapper.getClassing", id);
	}

	/**
 	 * 사용중인 강의실 리스트를 불러온다
 	 * 사용시간, 사용기간 등
	 */
	@Override
	public List<UseRoomVO> getUseRoomList(String roomCode) throws SQLException {
		return session.selectList("Class-Mapper.getUseRoomTime", roomCode);
	}

	/**
	 * 수업을 개설한다
	 */
	@Override
	public int updateClassOpen(ClassVO classVO) throws SQLException {
		return session.update("Class-Mapper.updateClassOpen", classVO);
	}

	@Override
	public int getTimedetailSeq() throws SQLException {
		return session.selectOne("Class-Mapper.getTimedetailSeq");
	}

	@Override
	public int registTimeDetail(TimeDetailVO timeDetailVO) throws SQLException {
		return session.update("Class-Mapper.registTimeDetail", timeDetailVO);
	}
	@Override
	public List<ClassVO> selectSearchClassListInClassList(SearchCriteria cri) throws SQLException {
		cri.setPerPageNum(5);
		int offset=cri.getStartRowNum();
		int limit=cri.getPerPageNum();
		RowBounds rowBounds=new RowBounds(offset,limit);

		List<ClassVO> classList = session.selectList("Class-Mapper.selectSearchClassListInClassList", cri, rowBounds);

		return classList;
	}
	//수업을 수강중인 학생 id리스트
	@Override
	public List<ClassingVO> selectClassIngMemberList(String classCode) throws SQLException {
		return session.selectList("Class-Mapper.selectClassIngMemberList", classCode);
	}
	@Override
	public List<TimeDetailVO> selectClassTimeDetail(String classCode) throws SQLException {
		return session.selectList("Class-Mapper.selectClassTimeDetail", classCode);
	}
	@Override
	public MemberVO selectSchoolDetail(String id) throws SQLException {
		return session.selectOne("Class-Mapper.selectSchoolDetail", id);
	}

	/**
	 * 해당 강사의 리뷰 목록을 불러온다
	 */
	@Override
	public List<ClassReviewVO> selectClassReviewById(String id) throws SQLException {
		return session.selectList("Class-Mapper.selectClassReviewById", id);
	}
	/**
	 * 해당 강사 경력 사항 리스트 가져오기
	 */
	@Override
	public List<CareerVO> getCareer(String id) throws SQLException {
		return session.selectList("Class-Mapper.getCareer", id);
	}
	/**
	 * 해당 수업의 리뷰를 불러온다
	 */
	@Override
	public List<ClassReviewVO> selectClassReview(String classCode) throws SQLException {
		return session.selectList("Class-Mapper.selectClassReview", classCode);
	}
	/**
	 * 해당 수업을 수강하는 수강생 id, 수업신청일 목록
	 */
	@Override
	public List<ClassingVO> selectClassingByClassCode(String classCode) throws SQLException {
		return session.selectList("Class-Mapper.selectClassingByClassCode",classCode);
	}
	/**
	 * 해당 수업 과제의 시작일보다 수업 신청일이 더 큰 과제들
	 */
	@Override
	public List<AssignVO> selectAssignByDate(ClassingVO classing) throws SQLException {
		return session.selectList("Class-Mapper.selectAssignByDate", classing);
	}
	/**
	 * 해당 과제를 제출했는지 여부를 카운트로 반환(제출했으면  1이다)
	 */
	@Override
	public int selectAssignAttachCheckCount(AssignAttachVO assignAttachVO) throws SQLException {
		return session.selectOne("Class-Mapper.selectAssignAttachCheckCount", assignAttachVO);
	}

	/**
	 * 해당 수업 수강 원생의 시험 점수 리스트
	 */
	@Override
	public List<AcademyScoreVO> selectExamScoreById(ClassingVO classingVO) throws SQLException {
		return session.selectList("Class-Mapper.selectExamScoreById", classingVO);
	}

	/**
	 * 해당 수업의 수업 시수를 가져온다(재무 계산용)
	 */
	@Override
	public ClassVO getTotalTimeByClassCode(String classCode) throws SQLException {
		return session.selectOne("Class-Mapper.getTotalTimeByClassCode", classCode);
	}
	/**
	 * 오늘보다 종료일이 큰 수업 리스트
	 */
	@Override
	public List<ClassVO> selectClassByEndDate() throws SQLException {
		return session.selectList("Class-Mapper.selectClassByEndDate");
	}
	/**
	 * 오늘보다 시작일이 큰 수업 리스트
	 */
	@Override
	public List<ClassVO> selectClassByStartDate() throws SQLException {
		return session.selectList("Class-Mapper.selectClassByStartDate");
	}
	/**
	 * 해당 수업에 대한 수업 시간을 가져온다
	 */
	@Override
	public List<TimeDetailVO> selectTimeDetailByClassCode(String classCode) throws SQLException {
		return session.selectList("Class-Mapper.selectTimeDetailByClassCode", classCode);
	}
	/**
	 * 수업기간이 지난 수업코드를 가져온다
	 */
	@Override
	public List<String> selectEndClassCode() throws SQLException {
		return session.selectList("Class-Mapper.selectEndClassCode");
	}
	/**
	 * 해당 수업의 시간표를 삭제한다(스케줄러용)
	 */
	@Override
	public void deleteEndClassFromTimeDetail(String classCode) throws SQLException {
		session.update("Class-Mapper.deleteEndClassFromTimeDetail", classCode);
	}

	/**
	 * 학생이 듣는 수업코드, 이름 리스트(원생 학원성적 조회 리스트용)
	 */
	@Override
	public List<ClassVO> selectClassNameListById(String id) throws SQLException {
		return session.selectList("Class-Mapper.selectClassNameListById", id);
	}
	@Override
	public SubjectVO selectSubjectBySubdetail(int code) throws SQLException {
		return session.selectOne("Class-Mapper.selectSubjectBySubdetail", code);
	}


	@Override
	public List<ClassVO> selectApplicationClassList(String id, SearchCriteria cri) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("id", id);
		keyMap.put("keyword", cri.getKeyword());

		System.out.println("list keyword" + cri.getKeyword());

		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		return session.selectList("Class-Mapper.selectApplicationClassList", keyMap, rowBounds);
	}
	@Override
	public int selectApplicationClassListCount(String id, SearchCriteria cri) throws SQLException {
		Map<String, String> keyMap = new HashMap<String, String>();
		keyMap.put("id", id);
		keyMap.put("keyword", cri.getKeyword());

		System.out.println("cnt keyword" + cri.getKeyword());

		return session.selectOne("Class-Mapper.selectApplicationClassListCount", keyMap);

	}
	@Override
	public String selectOverStuCnt(int code) throws SQLException {
		return session.selectOne("Class-Mapper.selectOverStuCnt", code);
	}
	@Override
	public void registClassing(ClassingVO vo) throws SQLException {
		session.update("Class-Mapper.registClassing", vo);
	}
	@Override
	public ClassVO selectRecomendClass(String grade, String rank, int subjectCode) throws SQLException {
		Map<String, Object> keyMap = new HashMap<String, Object>();
		keyMap.put("grade", grade);
		keyMap.put("subjectCode", subjectCode);
		keyMap.put("rank", rank);

		return session.selectOne("Class-Mapper.selectRecomendClass", keyMap);
	}
	@Override
	public ClassingVO getClassingByclassingVO(ClassingVO vo) throws SQLException {
		return session.selectOne("Class-Mapper.getClassingByclassingVO",vo);
	}




}
