package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dao.TMyPageDAO;
import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.MemberVO;

public class TMyPageServiceImpl implements TMyPageService{

	private TMyPageDAO tMyPageDAO;
	public void settMyPageDAO(TMyPageDAO tMyPageDAO) {
		this.tMyPageDAO = tMyPageDAO;
	}
	@Override
	public MemberVO selectInfoForMypage(String id) throws SQLException {
		return tMyPageDAO.selectInfoForMypage(id);
	}
	@Override
	public List<CareerVO> selectTeacherCareerList(String id) throws SQLException {
		return tMyPageDAO.selectTeacherCareerList(id);
	}
	@Override
	public void modifyTeacherInfo(MemberVO member) throws SQLException {
		tMyPageDAO.modifyTeacherInfo(member);
	}
	@Override
	public void modifyCareer(CareerVO career) throws SQLException {
		tMyPageDAO.modifyCareer(career);
	}
}
