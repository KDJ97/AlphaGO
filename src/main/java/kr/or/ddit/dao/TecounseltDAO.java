package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.TecounseltVO;

public interface TecounseltDAO {
	
	// 상담 신청 리스트

		List<TecounseltVO> selectCounseltList() throws Exception;

		List<TecounseltVO> selectCounseltList(Criteria cri) throws Exception;

		int selectCounseltListCount(SearchCriteria cri) throws Exception;

		// 검색 결과의 전체 리스트 개수
		int selectSearchCounseltListCount(SearchCriteria cri) throws Exception;

		List<TecounseltVO> selectSearchCounseltList(SearchCriteria cri) throws SQLException;
				
		
		// 이름조회 이름 가져오기
		String selectName(Integer counCode) throws Exception;
}
