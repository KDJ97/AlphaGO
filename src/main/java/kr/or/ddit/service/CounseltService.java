package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.CounseltVO;
import kr.or.ddit.dto.PacounseltVO;

public interface CounseltService {
	public void registCounselt(CounseltVO con) throws SQLException;

	public List<CounseltVO> selectApplyingCounselt(String id) throws SQLException;
	public List<PacounseltVO> selectApplyingPacounselt(String id) throws SQLException;
	public List<CounseltVO> selectAppliedCounselt(String id) throws SQLException;
	public List<PacounseltVO> selectAppliedPacounselt(String id) throws SQLException;

	public void deleteCounselt(int code) throws SQLException;
	public void deletePacounselt(int code) throws SQLException;

	public CounseltVO selectCounselt(int code) throws SQLException;
	public PacounseltVO selectPacounselt(int code) throws SQLException;
}
