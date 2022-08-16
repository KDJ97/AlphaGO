package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.MemberVO;

public class TMyPageDAOImpl implements TMyPageDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public MemberVO selectInfoForMypage(String id) throws SQLException {
		return session.selectOne("Mypage-Mapper.selectInfoForMypage",id);
	}

	@Override
	public List<CareerVO> selectTeacherCareerList(String id) throws SQLException {
		return session.selectList("Mypage-Mapper.selectTeacherCareerList",id);
	}

	@Override
	public void modifyTeacherInfo(MemberVO member) throws SQLException {
		session.update("Mypage-Mapper.modifyTeacherInfo",member);
	}

	@Override
	public void modifyCareer(CareerVO career) throws SQLException {
		session.update("Mypage-Mapper.modifyCareer", career);
	}

}
