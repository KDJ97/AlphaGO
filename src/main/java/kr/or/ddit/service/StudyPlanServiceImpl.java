package kr.or.ddit.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import kr.or.ddit.dao.StudyPlanDAO;
import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.StudyPlanerVO;

public class StudyPlanServiceImpl implements StudyPlanService {

	private StudyPlanDAO studyPlanDAO;
	public void setStudyPlanDAO(StudyPlanDAO studyPlanDAO) {
		this.studyPlanDAO = studyPlanDAO;
	}


	@Override
	public int getSpCode(String date, String id) throws SQLException {
		//있으면 return 없으면 insert해서 return
		StudyPlanerVO planerVO = studyPlanDAO.getStudyPlaner(date);

		if(planerVO == null) {
			planerVO = new StudyPlanerVO();

			int spCode = studyPlanDAO.slectNextStudyPlanerSeq();
			planerVO.setSpCode(spCode);

			planerVO.setId(id);

			try {
				SimpleDateFormat formatter =  new SimpleDateFormat("yyyy.MM.dd");
				Date regDate = formatter.parse(date);
				planerVO.setRegDate(regDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}

			studyPlanDAO.insertPlaner(planerVO);
		}

		return planerVO.getSpCode();

	}


	@Override
	public int getMaxPlanCode() throws SQLException {
		return studyPlanDAO.slectNextStudyPlanSeq();
	}


	@Override
	public void insertPlan(StudyPlanVO stp) throws SQLException {
		studyPlanDAO.insertPlan(stp);
	}


	@Override
	public List<StudyPlanVO> getPlanList(int spCode) throws SQLException {
		return studyPlanDAO.selectPlanListBySpCode(spCode);
	}


	@Override
	public void deletePlan(int planCode) throws SQLException{
		studyPlanDAO.deletePlan(planCode);
	}


	@Override
	public void updatePlan(StudyPlanVO stp) throws SQLException {
		studyPlanDAO.updatePlan(stp);
	}


	@Override
	public void checkPlan(int code) throws SQLException {
		StudyPlanVO stp = studyPlanDAO.selectStudyPlan(code);
		switch (stp.getStudyResult()) {
		case 0:
			stp.setStudyResult(1);
			break;
		case 1:
			stp.setStudyResult(0);
			break;
		}

		studyPlanDAO.updatePlan(stp);
	}


	@Override
	public StudyPlanerVO getStudyPlaner(int spCode) throws SQLException{
		return studyPlanDAO.selectStudyPlanerBySpCode(spCode);
	}


	@Override
	public void updatePlaner(StudyPlanerVO planer) throws SQLException {
		studyPlanDAO.updatePlaner(planer);
	}

}
