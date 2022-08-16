package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.MemberVO;

public interface TMyPageService {

	/**
	 * 멤버VO 불러온다
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	MemberVO selectInfoForMypage(String id) throws SQLException;
	
	/**
	 * 커리어VO리스트 불러온다
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	List<CareerVO> selectTeacherCareerList(String id)throws SQLException;
	
	/**
	 * 마이페이지에서 강사 정보 수정 
	 * @param id
	 * @throws SQLException
	 */
	void modifyTeacherInfo(MemberVO member) throws SQLException;
	
	/**
	 * 마이페이지에서 강사 커리어 수정
	 * @param career
	 * @throws SQLException
	 */
	void modifyCareer(CareerVO career) throws SQLException;
	
}
