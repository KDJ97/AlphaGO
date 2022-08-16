package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;

public class TeacherMasDAOImpl implements TeacherMasDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<TeachermasVO> selectTeacherList() throws Exception {
		List<TeachermasVO> teacherList = null;

		try {
			teacherList = session.selectList("TeacherMas-Mapper.selectTeacherList");
		} catch (Exception e) {
			throw e;
		}
		return teacherList;
	}

	@Override
	public List<TeachermasVO> selectTeacherList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TeachermasVO> teacherList = session.selectList("TeacherMas-Mapper.selectTeacherList", null, rowBounds);

		return teacherList;
	}

	@Override
	public int selectTeacherListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("TeacherMas-Mapper.selectSearchTeacherListCount", cri);
	}

	@Override
	public int selectSearchTeacherListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("TeacherMas-Mapper.selectTeacherListCount", cri);
		return totalCount;
	}

	@Override
	public List<TeachermasVO> selectSearchTeacherList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TeachermasVO> teacherList = session.selectList("TeacherMas-Mapper.selectSearchTeacherList", cri,
				rowBounds);

		return teacherList;
	}

	@Override
	public void insertTeacher(TeachermasVO teamas) throws SQLException {
		session.update("TeacherMas-Mapper.insertTeacher", teamas);

	}

//
//	@Override
//	public StudentVO selectStudentById(String id) throws SQLException {
//		StudentVO student = session.selectOne("Student-Mapper.selectStudentById",id);
//		return student;
//	}
//
//	@Override
//	public StudentVO selectStudentByPicture(String picture) throws SQLException {
//		StudentVO student = null;
//		student = session.selectOne("Student-Mapper.selectStudentByPicture", picture);
//		return student;
//	}
//
	@Override
	public void deleteTeacher(String id) throws SQLException {
		session.update("TeacherMas-Mapper.deleteTeacher", id);
	}

	@Override
	public TeachermasVO selectTeacherById(String id) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectTeacherById", id);
		return teamas;
	}

	@Override
	public String selectTeacherSequenceNextValue() throws SQLException {
		String id = session.selectOne("TeacherMas-Mapper.selectTeacherSequenceNextValue");
		return id;
	}

	@Override
	public TeachermasVO selectScoreBySubjectName(String subjectName) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectScoreBySubjectName", subjectName);
		return teamas;
	}

	@Override
	public TeachermasVO selectTeacherByPicture(String picture) throws SQLException {
		TeachermasVO teamas = null;
		teamas = session.selectOne("TeacherMas-Mapper.selectTeacherByPicture", picture);
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectTeacherAttendList() throws Exception {
		List<TeachermasVO> teacherList = null;

		try {
			teacherList = session.selectList("TeacherMas-Mapper.selectTeacherAttendList");
		} catch (Exception e) {
			throw e;
		}
		return teacherList;
	}

	@Override
	public List<TeachermasVO> selectTeacherAttendList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();

		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TeachermasVO> teacherList = session.selectList("TeacherMas-Mapper.selectTeacherAttendList", null,
				rowBounds);

		return teacherList;
	}

	@Override
	public int selectTeacherAttendListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("TeacherMas-Mapper.selectSearchTeacherAttendListCount", cri);
	}

	@Override
	public int selectSearchTeacherAttendListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("TeacherMas-Mapper.selectTeacherAttendListCount", cri);
		return totalCount;
	}

	@Override
	public List<TeachermasVO> selectSearchTeacherAttendList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();

		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TeachermasVO> teacherList = session.selectList("TeacherMas-Mapper.selectSearchTeacherAttendList", cri,
				rowBounds);

		return teacherList;
	}

	@Override
	public List<TeachermasVO> selectAllAttendTeacherById(String id) throws SQLException {
//		int offset = cri.getStartRowNum();
//		int limit = cri.getPerPageNum();
//		cri.setPerPageNum(30);
//		RowBounds rowBounds = new RowBounds(offset, limit);

		List<TeachermasVO> teacherList = null;

		try {
			teacherList = session.selectList("TeacherMas-Mapper.selectAllAttendTeacherById", id);
		} catch (Exception e) {
			throw e;
		}
		return teacherList;
	}

//	@Override
//	public List<TeachermasVO> selectAllAttendTeacherById(String id,Criteria cri) throws Exception {
//		int offset = cri.getStartRowNum();
//		int limit = cri.getPerPageNum();
//		RowBounds rowBounds = new RowBounds(offset,limit);
//		
//	List<TeachermasVO> teacherList
//		= session.selectList("TeacherMas-Mapper.selectAllAttendTeacherById",null,rowBounds);
//		
//		return teacherList;
//	}
////
//	@Override
//	public int selectAllAttendTeacherAttendByIdListCount(SearchCriteria cri) throws Exception {
//		return session.selectOne("TeacherMas-Mapper.selectSearchAllAttendTeacherByIdListCount",cri);
//	}
//
	@Override
	public int selectSearchAllAttendTeacherByIdListCount(String id) throws Exception {

		return session.selectOne("TeacherMas-Mapper.selectAllAttendTeacherAttendByIdListCount", id);

	}
//
//	@Override
//	public List<TeachermasVO> selectSearchAllAttendTeacherByIdList(SearchCriteria cri) throws SQLException {
//		int offset = cri.getStartRowNum();
//		int limit = cri.getPerPageNum();
//		RowBounds rowBounds = new RowBounds(offset, limit);
//
//		List<TeachermasVO> teacherList = session.selectList("TeacherMas-Mapper.selectSearchAllAttendTeacherByIdList", cri, rowBounds);
//
//		return teacherList;
//	}

	@Override
	public List<TeachermasVO> selectAllAttendTeacherByChartId(String id) throws SQLException {
		return session.selectList("TeacherMas-Mapper.selectAllAttendTeacherById", id);
	}

	@Override
	public TeachermasVO selectFinalTestBykor(String subject) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectFinalTestBykor", subject);
		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestByFisrtFinal(String subject) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectFinalTestByFisrtFinal", subject);
		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestBySecondMiddle(String subject) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectFinalTestBySecondMiddle", subject);
		return teamas;
	}

	@Override
	public TeachermasVO selectFinalTestBySecondFinal(String subject) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectFinalTestBySecondFinal", subject);
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectclassName(String id) throws Exception {
		List<TeachermasVO> teamas = null;

		try {
			teamas = session.selectList("TeacherMas-Mapper.selectclassName", id);
		} catch (Exception e) {
			throw e;
		}
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectReviewListByClassCode(int classCode) throws Exception {
		List<TeachermasVO> teamas = null;

		try {
			teamas = session.selectList("TeacherMas-Mapper.selectReviewListByClassCode", classCode);
		} catch (Exception e) {
			throw e;
		}
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectAllReviewListById(String id) throws Exception {
		List<TeachermasVO> teamas = null;

		try {
			teamas = session.selectList("TeacherMas-Mapper.selectAllReviewListById", id);
		} catch (Exception e) {
			throw e;
		}
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectTeacherCareer(String id) throws Exception {
		List<TeachermasVO> teamas = null;

		try {
			teamas = session.selectList("TeacherMas-Mapper.selectTeacherCareer", id);
		} catch (Exception e) {
			throw e;
		}
		return teamas;
	}

	@Override
	public TeachermasVO selectAllStarById(String id) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectAllStarById",id);
		return teamas;
	}

	@Override
	public TeachermasVO selectAvgByclassCode(int classCode) throws SQLException {
		TeachermasVO teamas = session.selectOne("TeacherMas-Mapper.selectAvgByclassCode",classCode);
		return teamas;
	}

	@Override
	public List<TeachermasVO> selectClassTeacheringById(String id) throws Exception {
		List<TeachermasVO> teamas = null;

		try {
			teamas = session.selectList("TeacherMas-Mapper.selectClassTeacheringById", id);
		} catch (Exception e) {
			throw e;
		}
		return teamas;
	}

	//강사의 해당수업의 시작시간과 끝나는시간
	@Override
	public TeachermasVO selectClassTimeByClassDay(ClassVO classvo) throws SQLException {
		TeachermasVO teamas=session.selectOne("TeacherMas-Mapper.selectClassTimeByClassDay",classvo);
		return teamas;
	}

	@Override
	public TeachermasVO selectTeacherAttendDetail(String id) throws SQLException {
		TeachermasVO teamas=session.selectOne("TeacherMas-Mapper.selectTeacherAttendDetail",id);
		return teamas;
	}

	@Override
	public int getMemberPictureSeq() throws SQLException {
		return session.selectOne("TeacherMas-Mapper.getMemberPictureSeq");
	}
}
