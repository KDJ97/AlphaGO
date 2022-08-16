package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.UniversityVO;

public interface UniversityService {

	/**
	 * 모든 대학 데이터 리스트 조회
	 * @return 대학정보 리스트
	 * @throws SQLException
	 */
	public List<UniversityVO> getUniversityList() throws SQLException;
}
