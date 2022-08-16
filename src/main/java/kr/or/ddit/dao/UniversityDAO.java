package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dto.UniversityVO;

public interface UniversityDAO {

	public List<UniversityVO> selectAllUniList() throws SQLException;

	public UniversityVO selectUniByCode(String code) throws SQLException;

	public List<UniversityVO> selectUniListByStandard(Map<String, String> keyMap) throws SQLException;

}
