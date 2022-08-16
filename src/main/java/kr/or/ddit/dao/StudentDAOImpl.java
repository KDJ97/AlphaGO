package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;
import kr.or.ddit.dto.TeachermasVO;

public class StudentDAOImpl implements StudentDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<StudentVO> selectStudentList(String id) throws Exception {
		List<StudentVO> studentList = null;

		try {
			studentList = session.selectList("Student-Mapper.selectStudentList", id);
		} catch (Exception e) {
			throw e;
		}
		return studentList;
	}

	@Override
	public List<StudentVO> selectStudentList(Criteria cri, String id) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<StudentVO> studentList = session.selectList("Student-Mapper.selectStudentList", null, rowBounds);

		return studentList;
	}

	@Override
	public int selectStudentListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("Student-Mapper.selectSearchStudentListCount", cri);
	}

	@Override
	public int selectSearchStudentListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("Student-Mapper.selectSearchStudentListCount", cri);
		return totalCount;
	}

	@Override
	public List<StudentVO> selectSearchStudentList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<StudentVO> studentList = session.selectList("Student-Mapper.selectSearchStudentList", cri, rowBounds);

		return studentList;
	}

	@Override
	public void insertStudent(StudentVO student) throws SQLException {
		session.update("Student-Mapper.insertStudent", student);

	}

	@Override
	public StudentVO selectStudentById(String id) throws SQLException {
		StudentVO student = session.selectOne("Student-Mapper.selectStudentById", id);
		return student;
	}

	@Override
	public StudentVO selectStudentByPicture(String picture) throws SQLException {
		StudentVO student = null;
		student = session.selectOne("Student-Mapper.selectStudentByPicture", picture);
		return student;
	}

	@Override
	public void deleteStudent(String id) throws SQLException {
		session.update("Student-Mapper.deleteStudent", id);
	}

	@Override
	public String selectStudentSequenceNextValue() throws SQLException {

		String id = session.selectOne("Student-Mapper.selectStudentSequenceNextValue");
		return id;
	}

	@Override
	public List<StudentVO> selectHopeSchool(String id) throws Exception {
		List<StudentVO> student = null;

		try {
			student = session.selectList("Student-Mapper.selectHopeSchool", id);
		} catch (Exception e) {
			throw e;
		}
		return student;
	}

	@Override
	public StudentVO selectFirstHopeSchool(String id) throws SQLException {
		StudentVO student = session.selectOne("Student-Mapper.selectFirstHopeSchool", id);
		return student;
	}

	@Override
	public int getMemberPictureSeq() throws SQLException {
		return session.selectOne("Student-Mapper.getMemberPictureSeq");
	}

//	@Override
//	public String selectFuUniversity(String id) throws SQLException {
//		return session.selectOne("Student-Mapper.selectFuUniversity",id);
//	}

}
