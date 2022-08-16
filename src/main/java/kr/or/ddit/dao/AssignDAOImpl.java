package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.MemberVO;

public class AssignDAOImpl implements AssignDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<AssignNameVO> selectAssignName(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Assign-Mapper.selectAssignName", map);
	}
	
	@Override
	public AssignVO selectAssignDetail(int assignCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Assign-Mapper.selectAssignDetail", assignCode);
	}
	
	@Override
	public AssignAttachVO selectAssignAttach(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Assign-Mapper.selectAttach", map);
	}
	
	@Override
	public void insertAssignAttach(AssignAttachVO attachVO) throws SQLException {
		session.update("Assign-Mapper.insertAttach", attachVO);	
	}

	@Override
	public void updateAssignAttach(AssignAttachVO attachVO) throws SQLException {
		session.update("Assign-Mapper.updateAttach", attachVO);
		
	}
	
	@Override
	public void deleteAssignAttach(Map<String, Object> map) throws SQLException {
		session.update("Assign-Mapper.deleteAttach", map);
		
	}

	@Override
	public List<AssignNameVO> getAssign(String id) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Assign-Mapper.getAssign", id);
	}

	@Override
	public List<AssignVO> selectAssignForTeacher(String id) throws SQLException {
		return session.selectList("Assign-Mapper.selectAssignForTeacher", id);
	}

	@Override
	public List<AssignAttachVO> selectStudentAndStatusList(Map<String, Object> map) throws SQLException {
		return session.selectList("Assign-Mapper.selectStudentAndStatusList", map);
	}

	@Override
	public List<MemberVO> selectRegisteredStudentAtClass(Map<String, Object> map) throws SQLException {
		return session.selectList("Assign-Mapper.selectRegisteredStudentAtClass", map);
	}

	@Override
	public List<AssignAttachVO> selectAssignAttachList(Map<String, Object> map) throws SQLException {
		return session.selectList("Assign-Mapper.selectAssignAttachList", map);
	}

	@Override
	public List<ClassVO> selectClassListNotFinished(String id) throws SQLException {
		return session.selectList("Assign-Mapper.selectClassListNotFinished", id);
	}

	@Override
	public int selectAssignSeqNextValue() throws SQLException {
		int seq = session.selectOne("Assign-Mapper.selectAssignSeqNextValue");
		return seq;
	}

	@Override
	public void insertAssign(AssignVO assign) throws SQLException {
		session.update("Assign-Mapper.insertAssign", assign);
	}

	@Override
	public void deleteFile(int assignCode) throws SQLException {
		session.update("Assign-Mapper.deleteFile", assignCode);
	}

	@Override
	public void deleteAssign(int assignCode) throws SQLException {
		session.update("Assign-Mapper.deleteAssign", assignCode);
	}

	@Override
	public void updateAssign(AssignVO assign) throws SQLException {
		session.update("Assign-Mapper.updateAssign", assign);
	}

	@Override
	public int selectTotalCountStudent(int classCode) throws SQLException {
		return session.selectOne("Assign-Mapper.selectTotalCountStudent", classCode);
	}

	@Override
	public int selectSubmitStudentCount(int assignCode) throws SQLException {
		return session.selectOne("Assign-Mapper.selectSubmitStudentCount", assignCode);
	}

	@Override
	public void checkHomework(Map<String, Object> map) throws SQLException {
		session.update("Assign-Mapper.checkHomework",map);
	}

	@Override
	public List<AssignAttachVO> selectSubmitStudentForHome(String id) throws SQLException {
		return session.selectList("Assign-Mapper.selectSubmitStudentForHome",id);
	}

	@Override
	public List<AssignAttachVO> selectStudentAtClassForHome(String id) throws SQLException {
		return session.selectList("Assign-Mapper.selectStudentAtClassForHome",id);
	}
	
	

}
