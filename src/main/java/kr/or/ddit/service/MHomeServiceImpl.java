package kr.or.ddit.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.command.PacounseltDateCommand;
import kr.or.ddit.command.TeachermasCommand;
import kr.or.ddit.dao.ApplyDAO;
import kr.or.ddit.dao.MHomeDAO;
import kr.or.ddit.dao.PacounseltDAO;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.MemberCountVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubdetailClassingVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TeachermasVO;

public class MHomeServiceImpl implements MHomeService {

	private MHomeDAO mhomeDAO;
	public void setMhomeDAO(MHomeDAO mhomeDAO) {
		this.mhomeDAO = mhomeDAO;
	}
	
	private PacounseltDAO counseltDAO;
	public void setCounseltDAO(PacounseltDAO counseltDAO) {
		this.counseltDAO = counseltDAO;
	}
	
	private ApplyDAO applyDAO;
	public void setApplyDAO(ApplyDAO applyDAO) {
		this.applyDAO = applyDAO;
	}
	/**
	 * 오늘의 강사 근태 리스트를 불러오는 서비스
	 */
	@Override
	public List<TeachermasCommand> selectTeacherAttendList() throws SQLException {
		List<TeachermasVO> teacherAttendList = mhomeDAO.selectTeacherAttendList();
		List<TeachermasCommand> teacherCommandList = new ArrayList<TeachermasCommand>();
		try {
			for(TeachermasVO vo : teacherAttendList) {
				TeachermasCommand command = new TeachermasCommand();
				
				command.setId(vo.getId());
				command.setName(vo.getName());
				command.setPhone(vo.getPhone());
				command.setAttendanceStatus(String.valueOf(vo.getAttendanceStatus()));
				
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm");
				if(vo.getInTime()!=null) {
					String inTime = simpleDateFormat.format(vo.getInTime());
					command.setInTime(inTime);
				}
				if(vo.getOutTime()!=null) {
					String outTime = simpleDateFormat.format(vo.getOutTime());
					command.setOutTime(outTime);
				}
				teacherCommandList.add(command);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return teacherCommandList;
	}
	/**
	 * 원장에게 들어온 상담 신청 리스트
	 */
	@Override
	public List<PacounseltDateCommand> selectCounseltList() throws SQLException {
		List<PacounseltVO> counseltList = mhomeDAO.selectCounseltList();
		List<PacounseltDateCommand> commandList = new ArrayList<PacounseltDateCommand>();
		for (PacounseltVO counselt : counseltList) {
			try {
				PacounseltDateCommand command = new PacounseltDateCommand();
				
				String name = counseltDAO.selectName(counselt.getPcCode());
				String id = counseltDAO.selectId(counselt.getPcCode());
				command.setName(name);
				command.setId(id);
				
				SimpleDateFormat hourDateFormat = new SimpleDateFormat("HH:mm");
				SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy/MM/dd");
				String pcStart = hourDateFormat.format(counselt.getPcStart());
				String pcEnd = hourDateFormat.format(counselt.getPcEnd());
				String meetDate = yearDateFormat.format(counselt.getMeetDate());
				command.setPcStart(pcStart);
				command.setPcEnd(pcEnd);
				command.setMeetDate(meetDate);
				command.setPcCode(String.valueOf(counselt.getPcCode()));
				
				commandList.add(command);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return commandList;
	}
	
	/**
	 * 월별 원생수를 최근 12개 꺼 가져온다(그래프용)
	 */
	@Override
	public List<MemberCountVO> selectMemberCount() throws SQLException {
		List<MemberCountVO> cntList = mhomeDAO.selectMemberCount();
		
		for(MemberCountVO vo : cntList) {
			String regdate = vo.getRegdate().substring(5, 7);
			vo.setRegdate(regdate+"월");
		}
		
		return cntList;
	}
	
	@Override
	public List<SubdetailClassingVO> selectSubdetailClassingCountList() throws SQLException {
		List<SubjectVO> subjectList = mhomeDAO.selectSubdetail();//상세과목 코드, 이름
		System.out.println(subjectList);
		List<SubdetailClassingVO> resList = new ArrayList<SubdetailClassingVO>();
//		List<SubdetailClassingVO> list = mhomeDAO.selectSubdetailClassingList();
		if(subjectList!=null&&subjectList.size()>0)
			for(SubjectVO subjectVO : subjectList) {
				String subdetailCode = subjectVO.getSubdetailCode();
				SubdetailClassingVO classingVO = mhomeDAO.selectSubdetailClassingList(subdetailCode);//cnt, name
				if(classingVO!=null) {
					resList.add(classingVO);
				}
			}
		System.out.println(resList);
		return resList;
	}
	@Override
	public List<SchoolVO> selectSchoolCountBySchoolCodeFromMember() throws SQLException {

		List<SchoolVO> schoolList = mhomeDAO.selectSchoolList();
		List<SchoolVO> resList = new ArrayList<SchoolVO>();
		for(SchoolVO schoolVO : schoolList) {
			String schoolCode = schoolVO.getSchoolCode();
			
			SchoolVO resSchool = mhomeDAO.selectSchoolCountBySchoolCodeFromMember(schoolCode);
			if(resSchool!=null)	resList.add(resSchool);
		}
		
		return resList;
	}
	/**
	 * 지원목록
	 */
	@Override
	public List<ApplyVO> selectApplyList() throws SQLException {
		return applyDAO.selectApplyList();
	}

	
	
	
	
}
















