package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.FixtureVO;
import kr.or.ddit.dto.UseFixtVO;

public interface UseFixtureDAO {
	/**
	 * 모든 기자재 목록을 가져온다
	 * @return
	 * @throws SQLException
	 */
	public List<FixtureVO> getAllFixture() throws SQLException;
	/**
	 * useFixture 테이블 기본키 시퀀스 받기
	 * @return
	 * @throws SQLException
	 */
	public int getUseFixtSeq() throws SQLException;
	
	/**
	 * 사용 비품 등록
	 * @throws SQLException
	 */
	public void registUseFixt(UseFixtVO useFixtVO) throws SQLException;
	
	/**
	 * 사용 비품 삭제
	 * @param roomCode
	 * @throws SQLException
	 */
	public void removeUseFixt(int roomCode) throws SQLException;
	
	/**
	 * 강의실에서 사용하는 비품 정보리스트
	 * @param roomCode
	 * @return
	 * @throws SQLException
	 */
	public List<UseFixtVO> getUseFixture() throws SQLException;
	
	
	
	
	
	
	
	
	
	
}
















