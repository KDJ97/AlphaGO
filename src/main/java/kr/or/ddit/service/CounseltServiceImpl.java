package kr.or.ddit.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dao.CounseltDAO;
import kr.or.ddit.dto.CounseltVO;
import kr.or.ddit.dto.PacounseltVO;

public class CounseltServiceImpl implements CounseltService{

	private CounseltDAO counseltDAO;
	public void setCounseltDAO(CounseltDAO counseltDAO) {
		this.counseltDAO = counseltDAO;
	}

	@Override
	public void registCounselt(CounseltVO con) throws SQLException {
		int code = counseltDAO.selectNextSeq();
		con.setCounCode(code);

		counseltDAO.registConselt(con);
	}

	@Override
	public List<CounseltVO> selectApplyingCounselt(String id) throws SQLException {
		return counseltDAO.selectApplyingCounselt(id);
	}

	@Override
	public List<PacounseltVO> selectApplyingPacounselt(String id) throws SQLException {
		return counseltDAO.selectApplyingPacounselt(id);
	}

	@Override
	public void deleteCounselt(int code) throws SQLException {
		counseltDAO.deleteCounselt(code);
	}

	@Override
	public void deletePacounselt(int code) throws SQLException {
		counseltDAO.deletePacounselt(code);
	}

	@Override
	public List<CounseltVO> selectAppliedCounselt(String id) throws SQLException {
		return counseltDAO.selectAppliedCounselt(id);
	}

	@Override
	public List<PacounseltVO> selectAppliedPacounselt(String id) throws SQLException {
		return counseltDAO.selectAppliedPacounselt(id);
	}

	@Override
	public CounseltVO selectCounselt(int code) throws SQLException {
		return counseltDAO.selectCounselt(code);
	}

	@Override
	public PacounseltVO selectPacounselt(int code) throws SQLException {
		return counseltDAO.selectPacounselt(code);
	}



}
