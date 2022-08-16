package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubjectVO;

public class SchoolDAOImpl implements SchoolDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	/**
	 * 학교 리스트를 불러오는 메서드
	 */
	@Override
	public List<SchoolVO> selectSearchSchoolList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset,limit);
		return session.selectList("School-Mapper.selectSearchSchoolList", cri, rowBounds);
	}

	/**
	 * 학교 상세 정보를 불러오는 메서드
	 */
	@Override
	public SchoolVO getSchoolDetail(String schoolCode) throws SQLException {
		return session.selectOne("School-Mapper.getSchoolDetail", schoolCode);
	}
	
	/**
	 * 고등학교 리스트 개수
	 */
	@Override
	public int selectSearchSchoolListCount() throws SQLException {
		return session.selectOne("School-Mapper.selectSearchSchoolListCount");
	}

	/**
	 * 전체 학생수 구하기
	 */
	@Override
	public int studentCnt() throws SQLException {
		return session.selectOne("School-Mapper.studentCnt");
	}

	/**
	 * 해당 학교를 다니는 학생수
	 */
	@Override
	public int schoolCntStudent(String schoolCode) throws SQLException {
		return session.selectOne("School-Mapper.schoolCntStudent", schoolCode);
	}
	
	/**
	 * 학교 정보를 삭제하는 쿼리 작동
	 */
	@Override
	public int removeSchool(String schoolCode) throws SQLException {
		return session.update("School-Mapper.removeSchool", schoolCode);
	}

	/**
	 * 학교 정보 등록
	 */
	@Override
	public int insertSchool(SchoolVO schoolVO) throws SQLException {
		return session.update("School-Mapper.insertSchool", schoolVO);
	}
	
	/**
	 * 학교 시퀀스를 가져온다
	 */
	@Override
	public int getSchoolSeq() throws SQLException {
		return session.selectOne("School-Mapper.getSchoolSeq");
	}
	/**
	 * 해당 학교 재학 중인 학생 리스트 (이름,번호, 아이디,학년)
	 */
	@Override
	public List<MemberVO> selectMemberBySchoolCode(String schoolCode) throws SQLException {
		return session.selectList("School-Mapper.selectMemberBySchoolCode", schoolCode);
	}
	/**
	 * 학생 리스트 (이름,번호, 아이디,학년)
	 */
	@Override
	public List<MemberVO> selectMemberList() throws SQLException {
		return session.selectList("School-Mapper.selectMemberList");
	}
	/**
	 * 해당 학생의 학교 성적 등급 리스트
	 */
	@Override
	public List<SchoolScoreVO> selectScoreGradeById(String id) throws SQLException {
		return session.selectList("School-Mapper.selectScoreGradeById", id);
	}
	/*
	 * 과목 리스트 
	 */
	@Override
	public List<SubjectVO> selectSubjectList() throws SQLException {
		return session.selectList("School-Mapper.selectSubjectList");
	}
	/**
	 * 해당 학교의 점수 리스트를 가져온다
	 * return 과목코드, 과목명,점수,학교명,학교코드
	 */
	@Override
	public List<SchoolScoreVO> selectSchoolScoreListBySchoolCode(SchoolScoreVO schoolScoreVO) throws SQLException {
		return session.selectList("School-Mapper.selectSchoolScoreListBySchoolCode", schoolScoreVO);
	}
	/**
	 * 해당 학교의 재학중인 학생의 성적 정보리스트
	 * @param schoolScoreVO id,schoolCode, subjectCode
	 * @return  과목코드, 과목명,점수,학교명,학교코드
	 */
	@Override
	public List<SchoolScoreVO> selectSchoolScoreListById(SchoolScoreVO schoolScoreVO) throws SQLException {
		return session.selectList("School-Mapper.selectSchoolScoreListById", schoolScoreVO);
	}


}
