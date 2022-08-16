package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.MemberCountVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubdetailClassingVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TeachermasVO;

public class MHomeDAOImpl implements MHomeDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	/**
	 * 오늘의 강사 근태 리스트를 불러온다 
	 */
	@Override
	public List<TeachermasVO> selectTeacherAttendList() throws SQLException {
		return session.selectList("MasterHome-Mapper.selectTeacherAttendList");
	}

	/**
	 * 상담 신청 목록을 불러오는 다오
	 */
	@Override
	public List<PacounseltVO> selectCounseltList() throws SQLException {
		return session.selectList("MasterHome-Mapper.selectCounseltList");
	}

	/**
	 * 원생의 월별 수를 가져오는 메서드
	 */
	@Override
	public List<MemberCountVO> selectMemberCount() throws SQLException {
		return session.selectList("MasterHome-Mapper.selectMemberCnt");
	}

	/**
	 * 수업 별 수강 인원수
	 */
	@Override
	public SubdetailClassingVO selectSubdetailClassingList(String subdetailCode) throws SQLException {
		return session.selectOne("MasterHome-Mapper.selectSubDetailClassingCount",subdetailCode);
	}

	@Override
	public List<SubjectVO> selectSubdetail() throws SQLException {
		return session.selectList("MasterHome-Mapper.selectSubdetail");
	}

	/**
	 * 학교 목록(그래프)
	 */
	@Override
	public List<SchoolVO> selectSchoolList() throws SQLException {
		return session.selectList("MasterHome-Mapper.selectSchoolList");
	}
	/**
	 * 해당 학교의 원생 수를 계산
	 */
	@Override
	public SchoolVO selectSchoolCountBySchoolCodeFromMember(String schoolCode) throws SQLException {
		return session.selectOne("MasterHome-Mapper.selectSchoolCountBySchoolCodeFromMember", schoolCode);
	}

}
