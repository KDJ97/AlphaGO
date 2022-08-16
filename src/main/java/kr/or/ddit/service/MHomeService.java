package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.PacounseltDateCommand;
import kr.or.ddit.command.TeachermasCommand;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.MemberCountVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubdetailClassingVO;

public interface MHomeService {

	/**
	 * 강사들의 근태 리스트를 불러오는 서비스
	 * @return
	 * @throws SQLException
	 */
	public List<TeachermasCommand> selectTeacherAttendList() throws SQLException; 
	
	/**
	 * 원장에게 들어온 상담 신청 리스트
	 * @return
	 * @throws SQLException
	 */
	public List<PacounseltDateCommand> selectCounseltList() throws SQLException;
	
	/**
	 * 월별 원생수를 최근 12개 꺼 가져온다(그래프용)
	 * @return
	 * @throws SQLException
	 */
	public List<MemberCountVO> selectMemberCount() throws SQLException;
	
	/**
	 * 수업 별 수강 인원수
	 * @return
	 * @throws SQLException
	 */
	public List<SubdetailClassingVO> selectSubdetailClassingCountList() throws SQLException;
	
	/**
	 * 학교별 원생수 계산
	 * @return
	 * @throws SQLException
	 */
	public List<SchoolVO> selectSchoolCountBySchoolCodeFromMember() throws SQLException;
	
	/**
	 * 지원 목록 가져오기
	 * @return
	 * @throws SQLException
	 */
	public List<ApplyVO> selectApplyList() throws SQLException;
}
