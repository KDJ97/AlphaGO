package kr.or.ddit.scheduler;

import java.util.List;

import kr.or.ddit.dao.ClassDAO;

public class RemoveClassTimeScheduler {

	private ClassDAO classDAO;
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}
	
	//수업을 삭제하는 메서드
	public void removeEndClass() throws Exception{
		//수업기간이 종료된 수업코드들을 가져온다.(ClassCode)
		List<String> endClassCodes = classDAO.selectEndClassCode();
		
		if(endClassCodes!=null && endClassCodes.size()>0) 
			for(String classCode : endClassCodes) {
				classDAO.deleteEndClassFromTimeDetail(classCode);
			}
	}//메서드 종료
	
}
