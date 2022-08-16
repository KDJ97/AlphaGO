package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dao.UniversityDAO;
import kr.or.ddit.dto.UniversityVO;

public class UniversityServiceImpl implements UniversityService {

	private UniversityDAO universityDAO;
	public void setUniversityDAO(UniversityDAO universityDAO) {
		this.universityDAO = universityDAO;
	}

	@Override
	public List<UniversityVO> getUniversityList() throws SQLException {
		return universityDAO.selectAllUniList();
	}

}
