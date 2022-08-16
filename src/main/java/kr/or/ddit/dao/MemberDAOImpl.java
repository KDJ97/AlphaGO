package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.TimeTableCommand;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.SHUnivVO;

public class MemberDAOImpl implements MemberDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<MemberVO> selectMemberList() throws Exception {
		List<MemberVO> memberList = null;
		try {

			memberList = session.selectList("Member-Mapper.selectMemberList");
		} catch (Exception e) {
			// 에러처리
			throw e;
		}
		return memberList;
	}

	@Override
	public List<MemberVO> selectMemberList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<MemberVO> memberList = session.selectList("Member-Mapper.selectMemberList", null, rowBounds);

		return memberList;
	}

	@Override
	public int selectMemberListCount() throws Exception {
		int totalCount = session.selectOne("Member-Mapper.selectMemberListCount");

		return totalCount;
	}

	@Override
	public int selectSearchMemberListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("Member-Mapper.selectMemberListCount", cri);
		return totalCount;
	}

	@Override
	public MemberVO selectMemberById(String id) throws SQLException {
		MemberVO member = session.selectOne("Member-Mapper.selectMemberById", id);
		return member;
	}

	@Override
	public void insertMember(MemberVO member) throws SQLException {
		session.update("Member-Mapper.insertMember", member);

	}

	@Override
	public void updateMember(MemberVO member) throws SQLException {
		session.update("Member-Mapper.updateMember", member);

	}

	@Override
	public void deleteMember(String id) throws SQLException {
		session.update("Member-Mapper.deleteMember", id);
	}

	@Override
	public void enabledMember(String id, int enabled) throws SQLException {

		Map<String, Object> dataMap = new HashMap<String, Object>();

		dataMap.put("id", id);
		dataMap.put("enabled", enabled);

		session.update("Member-Mapper.enabledMember", dataMap);

	}

	@Override
	public MemberVO selectMemberByPicture(String picture) throws SQLException {
		MemberVO member = null;
		member = session.selectOne("Member-Mapper.selectMemberByPicture", picture);
		return member;
	}

	@Override
	public List<MemberVO> selectMemberListByAuthority(String authority) {
		List<MemberVO> list = null;
		list = session.selectList("Member-Mapper.selectMemberListByAuthority",authority);
		return list;
	}

	@Override
	public List<Map<String, String>> selectMemberTodayClass(String id) throws SQLException {
		return session.selectList("Member-Mapper.selectMemberTodayClass",id);
	}

	@Override
	public List<TimeTableCommand> selectTimeTable(String id) throws SQLException {
		return session.selectList("Member-Mapper.selectTimeTable",id);
	}

	@Override
	public List<TimeTableCommand> selectTimeTableForTeacher(String id) throws SQLException {
		return session.selectList("Member-Mapper.selectTimeTableForTeacher",id);
	}
	
	@Override
	public String selectUniCodeByUniName(String name) throws SQLException {
		return session.selectOne("Member-Mapper.selectUniCodeByUniName", name);
	}

	@Override
	public SHUnivVO selectSHUniv(String id) throws SQLException {
		return session.selectOne("Member-Mapper.selectSHUniv", id);
	}

	@Override
	public int selectSHUnivNextSeq() throws SQLException {
		return session.selectOne("Member-Mapper.selectSHUnivNextSeq");
	}

	@Override
	public void insertSHUniv(SHUnivVO uni) throws SQLException {
		session.update("Member-Mapper.insertSHUniv", uni);
	}

	@Override
	public void updateSHUniv(SHUnivVO uni) throws SQLException {
		session.update("Member-Mapper.updateSHUniv", uni);
	}

}
