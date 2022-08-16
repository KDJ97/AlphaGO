package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.MemberCountVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubdetailClassingVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TeachermasVO;

public interface MHomeDAO {

	/**
	 * 강사의 근태 리스트를 불러온다
	 * @return
	 * @throws SQLException
	 */
	public List<TeachermasVO> selectTeacherAttendList() throws SQLException;
	/**
	 * 원장에게 들어온 상담 신청 목록 반환
	 * @return
	 * @throws SQLException
	 */
	public List<PacounseltVO> selectCounseltList() throws SQLException;
	
	
	/**
	 * 원생의 월별 수를 가져오는 메서드
	 * @return
	 * @throws SQLException
	 */
	public List<MemberCountVO> selectMemberCount() throws SQLException;
	
	
	public List<SubjectVO> selectSubdetail() throws SQLException;
	
	/**
	 * 수업 별 수강 인원수
	 * @return subdetailName, classCode,className,cnt
	 * @throws SQLException
	 */
	public SubdetailClassingVO selectSubdetailClassingList(String subdetailCode) throws SQLException;
	
	/**
	 * 고등학교 목록
	 * @return
	 * @throws SQLException
	 */
	public List<SchoolVO> selectSchoolList() throws SQLException;
	
	
	/**
	 * 해당 학교의 원생 수를 계산
	 * @param schoolCode
	 * @return
	 * @throws SQLException
	 */
	public SchoolVO selectSchoolCountBySchoolCodeFromMember(String schoolCode) throws SQLException;
}















