package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dao.AssignDAO;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.MemberVO;

public class AssignServiceImpl implements AssignService {

	private AssignDAO assignDAO;
	public void setAssignDAO(AssignDAO assignDAO) {
		this.assignDAO = assignDAO;
	}
	
	@Override
	public List<AssignNameVO> selectAssignName(Map<String, Object> map) throws SQLException {
		List<AssignNameVO> assignNameList = assignDAO.selectAssignName(map);
		
		return assignNameList;
	}

	@Override
	public AssignVO selectAssignDetail(int assignCode) throws SQLException {
		AssignVO assignVO = assignDAO.selectAssignDetail(assignCode);
		
		return assignVO;
	}

	@Override
	public AssignAttachVO selectAssignAttach(Map<String, Object> map) throws SQLException {
		AssignAttachVO assignVO = assignDAO.selectAssignAttach(map);
		
		return assignVO;
	}

	@Override
	public void insertAssignAttach(AssignAttachVO attachVO) throws SQLException {
		assignDAO.insertAssignAttach(attachVO);		
	}

	@Override
	public void updateAssignAttach(AssignAttachVO attachVO) throws SQLException {
		assignDAO.updateAssignAttach(attachVO);	
	}

	@Override
	public void deleteAssignAttach(Map<String, Object> map) throws SQLException {
		assignDAO.deleteAssignAttach(map);
		
	}

	@Override
	public List<AssignNameVO> getAssign(String id) throws SQLException {
		List<AssignNameVO> assignList = assignDAO.getAssign(id);
		
		return assignList;
	}

	@Override
	public Map<String,Object> selectAssignForTeacher(String id) throws SQLException {
		List<AssignVO> assignList = assignDAO.selectAssignForTeacher(id);
		
		for(int i=0; i<assignList.size(); i++) {
			int classCode = assignList.get(i).getClassCode();
			int assignCode = assignList.get(i).getAssignCode();
			double totalCount = (double)assignDAO.selectTotalCountStudent(classCode);
			double submitStudentCount = assignDAO.selectSubmitStudentCount(assignCode);
			double submitRate = Math.round(submitStudentCount/totalCount*100*10)/10.0;
			assignList.get(i).setSubmitRate(submitRate);
		}
		
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("assignList", assignList);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectStudentAndStatusList(Map<String, Object> map) throws SQLException {
		List<AssignAttachVO> assignAttachList = assignDAO.selectStudentAndStatusList(map);
		//System.out.println(assignAttachList);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("assignAttachList", assignAttachList);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectRegisteredStudentAtClass(Map<String, Object> map) throws SQLException {
		List<MemberVO> studentList = assignDAO.selectRegisteredStudentAtClass(map);
		List<AssignAttachVO> submittingAssignStudentList = assignDAO.selectAssignAttachList(map);
		
		//수업에 등록된 학생들 ID와 과제제출한 학생들 ID를 비교해서 과제제출 테이블에 등록된 학생들의 STATUS는  제출완료로 SET 해준다
		for(int i=0; i<studentList.size(); i++) {
			for(int j=0; j<submittingAssignStudentList.size(); j++) {
				if(studentList.get(i).getId().equals(submittingAssignStudentList.get(j).getId())) {
					studentList.get(i).setStatus("제출완료");
				}
			}
		}
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("studentList", studentList);
		dataMap.put("submittingAssignStudentList", submittingAssignStudentList);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectClassListNotFinished(String id) throws SQLException {
		
		List<ClassVO> classVOList = assignDAO.selectClassListNotFinished(id);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("classVOList", classVOList);
		
		return dataMap;
	}

	@Override
	public void insertAssign(AssignVO assign) throws SQLException {
		int assignCode = assignDAO.selectAssignSeqNextValue();
		assign.setAssignCode(assignCode);
		assignDAO.insertAssign(assign);
	}

	@Override
	public void deleteFile(int assignCode) throws SQLException {
		assignDAO.deleteFile(assignCode);
	}

	@Override
	public void deleteAssign(int assignCode) throws SQLException {
		assignDAO.deleteAssign(assignCode);
	}

	@Override
	public void updateAssign(AssignVO assign) throws SQLException {
		assignDAO.updateAssign(assign);
	}

	@Override
	public void checkHomework(Map<String, Object> map) throws SQLException {
		assignDAO.checkHomework(map);
	}

	@Override
	public Map<String, Object> selectSubmitStudentForHome(String id) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		//해당 교사가 낸 과제를 제출한 학생들 리스트
		List<AssignAttachVO> assignAttachList = assignDAO.selectSubmitStudentForHome(id);
		//해당 교사의 수업을 듣는 학생들 리스트
		List<AssignAttachVO> studentList = assignDAO.selectStudentAtClassForHome(id);
		List<AssignAttachVO> studentList2 = new ArrayList<AssignAttachVO>();
		
		//현재날짜기준 가장 만기일이 다가온 과제만 출력
		for(int i=0; i<studentList.size()-1; i++) {
			if(studentList.get(i).getEndDate().equals(studentList.get(i+1).getEndDate())) {
				studentList2.add(studentList.get(i));
			}else if(studentList.get(studentList.size()-2).getEndDate().equals(studentList.get(studentList.size()-1).getEndDate())) {
				studentList2.add(studentList.get(studentList.size()-1));
			}
			else if(studentList.get(i+1).getEndDate().after(studentList.get(i).getEndDate())) {
				studentList2.add(studentList.get(i));
				break;
			}
		}
		
		//해당 교사의 수업을 듣는 학생들 중 과제를 제출한 학생들의 status에 제출완료 세팅
		for(int i=0; i<studentList.size(); i++) {
			for(int j=0; j<assignAttachList.size(); j++) {
				if(studentList.get(i).getName().equals(assignAttachList.get(j).getName())) {
					studentList.get(i).setStatus("제출완료");
					studentList.get(i).setAssignCode(assignAttachList.get(j).getAssignCode());
					studentList.get(i).setId(assignAttachList.get(j).getId());
				}
			}
		}
		
		dataMap.put("studentList", studentList2);
		
		return dataMap; 
	}

	

}
