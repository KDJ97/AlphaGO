package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SchoolVO;

public interface SchoolService {

	/**
	 * 고등학교 목록을 반환하는 서비스
	 * @param cri
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> selectSearchSchoolList(SearchCriteria cri) throws SQLException;

	/**
	 * 학교 상세정보를 처리하는 서비스
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public SchoolVO getSchoolDetail(String schoolCode) throws SQLException;

	/**
	 * 학교 정보를 삭제한다
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public int removeSchool(String schoolCode) throws SQLException;
	
	/**
	 * 학교 등록 
	 * @param schoolVO
	 * @return
	 * @throws SQLException
	 */
	public int insertSchool(SchoolVO schoolVO) throws SQLException;
	
	/**
	 *  학생 리스트 (이름,번호, 아이디,학년)
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
	 * 해당 학교의 과목별 점수 평균을 구한다
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public List<SchoolScoreVO> selectSchoolScoreAvg(String schoolCode) throws SQLException;
	
	/**
	 * 해당 학교 재학생의 학교성적 과목별 평균을 구한다
	 * @param schoolScoreVO
	 * @return
	 * @throws SQLException
	 */
 	public List<SchoolScoreVO> selectSchoolScoreById(SchoolScoreVO schoolScoreVO) throws SQLException;
}












