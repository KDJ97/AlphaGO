package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubjectVO;

public interface SchoolDAO {

	/**
	 * 학교 리스트를 불러오는 메서드
	 * @return
	 * @throws SQLException
	 */
	public List<SchoolVO> selectSearchSchoolList(SearchCriteria cri) throws SQLException;
	
	/**
	 * 한 학교의 정보를 불러오는 메서드
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public SchoolVO getSchoolDetail(String schoolCode) throws SQLException;
	
	/**
	 * 고등학교 리스트 개수
	 * @return
	 * @throws SQLException
	 */
	public int selectSearchSchoolListCount() throws SQLException;
	
	/**
	 * 전체 학생수 구하기
	 * @return
	 * @throws SQLException
	 */
	public int studentCnt() throws SQLException;
	
	/**
	 * 해당 학교를 다니는 학생수
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public int schoolCntStudent(String schoolCode) throws SQLException;
	
	/**
	 * 학교 정보를 삭제한다
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public int removeSchool(String schoolCode) throws SQLException;
	
	/**
	 * 학교 기본키 시퀀스값 가져오기
	 * @return
	 * @throws SQLException
	 */
	public int getSchoolSeq() throws SQLException;
	
	/**
	 * 학교 등록 메서드
	 * @return
	 * @throws SQLException
	 */
	public int insertSchool(SchoolVO schoolVO) throws SQLException;
	
	/**
	 * 학교 학생 리스트 (이름,번호, 아이디,학년)
	 * @return
	 * @throws SQLException
	 */
	public List<MemberVO> selectMemberList() throws SQLException;
	
	/**
	 * 해당 학교 재학 중인 학생 리스트 (이름,번호, 아이디,학년)
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public List<MemberVO> selectMemberBySchoolCode(String schoolCode) throws SQLException;
	
	/**
	 * 해당 학생의 학교 성적 등급 리스트
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<SchoolScoreVO> selectScoreGradeById(String id) throws SQLException;
	
	/**
	 * 과목 리스트
	 * @return 과목명, 과목 코드
	 * @throws SQLException
	 */
	public List<SubjectVO> selectSubjectList() throws SQLException;
	
	/**
	 * 해당 학교의 점수 리스트를 가져온다
	 * @param schoolCode
	 * @return 과목코드, 과목명,점수,학교명,학교코드
	 * @throws SQLException
	 */
	public List<SchoolScoreVO> selectSchoolScoreListBySchoolCode(SchoolScoreVO schoolScoreVO) throws SQLException;

	/**
	 * 해당 학교의 재학중인 학생의 성적 정보리스트
	 * @param schoolScoreVO id,schoolCode, subjectCode
	 * @return  과목코드, 과목명,점수,학교명,학교코드
	 * @throws SQLException
	 */
	public List<SchoolScoreVO> selectSchoolScoreListById(SchoolScoreVO schoolScoreVO) throws SQLException;
	
}















