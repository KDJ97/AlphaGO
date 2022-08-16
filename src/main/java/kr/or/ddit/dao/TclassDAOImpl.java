package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ClassPlanVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassTimeVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.HomeworkPlanVO;
import kr.or.ddit.dto.TecounseltVO;
import kr.or.ddit.dto.WeekPlanVO;

public class TclassDAOImpl implements TclassDAO{
	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	@Override
	public List<ClassVO> selectSearchClassList(SearchCriteria cri) throws SQLException {
		return session.selectList("Tclass-Mapper.selectSearchClassList", cri);
	}
	@Override
	public List<ClassVO> selectSearchUnregisteredClassList(Map<String,Object> map) throws SQLException {
		return session.selectList("Tclass-Mapper.selectSearchUnregisteredClassList", map);
	}
	@Override
	public ClassVO selectClassForModal(int classCode) throws SQLException {
		return session.selectOne("Tclass-Mapper.selectClassForModal", classCode);
	}
	@Override
	public List<ClassTimeVO> selectClassTime(int classCode) throws SQLException {
		return session.selectList("Tclass-Mapper.selectClassTime", classCode);
	}
	@Override
	public ClassPlanVO selectCPNOandTextbook(int classCode) throws SQLException {
		return session.selectOne("Tclass-Mapper.selectCPNOandTextbook", classCode);
	}
	@Override
	public List<WeekPlanVO> selectWeekPlan(int classCode) throws SQLException {
		return session.selectList("Tclass-Mapper.selectWeekPlan", classCode);
	}
	@Override
	public List<HomeworkPlanVO> selectHomeworkPlan(int classCode) throws SQLException {
		return session.selectList("Tclass-Mapper.selectHomeworkPlan", classCode);
	}
	
	@Override
	public int selectClassPlanSeqNextValue() throws SQLException {
		int cpno = session.selectOne("Tclass-Mapper.selectClassPlanSeqNextValue");
		return cpno;
	}
	@Override
	public void insertClassPlan(ClassPlanVO classPlan) throws SQLException {
		session.update("Tclass-Mapper.insertClassPlan", classPlan);
	}
	
	@Override
	public int selectWeekPlanSeqNextValue() throws SQLException {
		int seq = session.selectOne("Tclass-Mapper.selectWeekPlanSeqNextValue");
		return seq;
	}
	@Override
	public void insertWeekPlan(WeekPlanVO weekPlan) throws SQLException {
		session.update("Tclass-Mapper.insertWeekPlan", weekPlan);
	}
	
	@Override
	public int selectHomeworkPlanSeqNextValue() throws SQLException {
		int seq = session.selectOne("Tclass-Mapper.selectHomeworkPlanSeqNextValue");
		return seq;
	}
	@Override
	public void insertHomeworkPlan(HomeworkPlanVO homeworkPlan) throws SQLException {
		session.update("Tclass-Mapper.insertHomeworkPlan", homeworkPlan);
	}

	@Override
	public void updateClassToRegisterClassPlan(ClassVO classVO) throws SQLException {
		session.update("Tclass-Mapper.updateClassToRegisterClassPlan", classVO);
	}
	@Override
	public void deleteClassPlan(int wpno) throws SQLException {
		session.update("Tclass-Mapper.deleteClassPlan", wpno);
		
	}
	@Override
	public void deleteHomeworkPlan(int homeworkplan) throws SQLException {
		session.update("Tclass-Mapper.deleteHomeworkPlan", homeworkplan);
	}
	@Override
	public void updateWeekPlan(WeekPlanVO weekPlanVO) throws SQLException {
		session.update("Tclass-Mapper.updateWeekPlan", weekPlanVO);
	}
	@Override
	public void updateHomeworkPlan(HomeworkPlanVO homeworkPlanVO) throws SQLException {
		session.update("Tclass-Mapper.updateHomeworkPlan", homeworkPlanVO);
		
	}
	@Override
	public void updateClassPlan(ClassPlanVO classPlanVO) throws SQLException {
		session.update("Tclass-Mapper.updateClassPlan", classPlanVO);
	}
	@Override
	public List<ClassVO> selectClassesForHome(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectClassesForHome",id);
	}
	@Override
	public List<WeekPlanVO> selectProgressForHome(String cpno) throws SQLException {
		return session.selectList("Tclass-Mapper.selectProgressForHome", cpno);
	}
	@Override
	public int weekPlanCount(String cpno) throws SQLException {
		return session.selectOne("Tclass-Mapper.weekPlanCount", cpno);
	}
	@Override
	public List<ClassVO> selectClassForReview(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectClassForReview",id);
	}
	@Override
	public List<ClassReviewVO> selectReview(String classCode) throws SQLException {
		return session.selectList("Tclass-Mapper.selectReview",classCode);
	}
	@Override
	public ClassReviewVO selectReviewDetail(String reviewCode) throws SQLException {
		return session.selectOne("Tclass-Mapper.selectReviewDetail",reviewCode);
	}
	@Override
	public List<ClassReviewVO> selectAllReview(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectAllReview", id);
	}
	@Override
	public List<TecounseltVO> selectTodayConsult(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectTodayConsult", id);
	}
	@Override
	public List<AssignVO> selectTodayHomework(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectTodayHomework", id);
	}
	@Override
	public List<ExamVO> selectTodayTest(String id) throws SQLException {
		return session.selectList("Tclass-Mapper.selectTodayTest", id);
	}
}
