package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dao.ClassDAO;
import kr.or.ddit.dao.ScoreDAO;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SubAreaVO;

public class ScoreServiceImpl implements ScoreService{

	private ScoreDAO scoreDAO;
	public void setScoreDAO(ScoreDAO scoreDAO) {
		this.scoreDAO = scoreDAO;
	}

	private ClassDAO classDAO;
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}

	@Override
	public List<SchoolScoreVO> getScoreList(SchoolScoreVO score) throws SQLException {
		return scoreDAO.selectSchoolScoreListByTestName(score);
	}

	@Override
	public void deleteScoreDate(int sscode) throws SQLException {
		scoreDAO.deleteScoreData(sscode);
	}

	@Override
	public void insertScore(SchoolScoreVO score) throws SQLException {
		int sscode = scoreDAO.selectNextSeq();
		score.setSscode(sscode);

		System.out.println("scoreService : =========");
		System.out.println(score.toString());
		scoreDAO.insertScore(score);
	}

	@Override
	public void modifyScore(SchoolScoreVO score) throws SQLException {
		scoreDAO.modifyScore(score);
	}

	@Override
	public Map<String, Object> getScoreListBySubjectMap(String id) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();

		//국어 1 / 수학 2 / 사회 3 / 과학 4 / 영어 5
		List<SchoolScoreVO> korList = new ArrayList<SchoolScoreVO>();
		List<SchoolScoreVO> mathList = new ArrayList<SchoolScoreVO>();
		List<SchoolScoreVO> socialList = new ArrayList<SchoolScoreVO>();
		List<SchoolScoreVO> scienceList = new ArrayList<SchoolScoreVO>();
		List<SchoolScoreVO> engList = new ArrayList<SchoolScoreVO>();




		List<SchoolScoreVO> scoreList = scoreDAO.selectAllScoreList(id);
		for(SchoolScoreVO score : scoreList) {
			switch (score.getSubjectCode()) {
			case 1:
				korList.add(score);
				break;
			case 2:
				mathList.add(score);
				break;
			case 3:
				socialList.add(score);
				break;
			case 4:
				scienceList.add(score);
				break;
			case 5:
				engList.add(score);
				break;

			}
		}

		dataMap.put("korList", korList);
		dataMap.put("mathList", mathList);
		dataMap.put("socialList", socialList);
		dataMap.put("scienceList", scienceList);
		dataMap.put("engList", engList);


		double korAvg = getSchoolScoreAVG(korList);
		double mathAvg = getSchoolScoreAVG(mathList);
		double socialAvg = getSchoolScoreAVG(socialList);
		double scienceAvg = getSchoolScoreAVG(scienceList);
		double engAvg = getSchoolScoreAVG(engList);

		//점수평균
		dataMap.put("korAvg", korAvg);
		dataMap.put("mathAvg", mathAvg);
		dataMap.put("socialAvg", socialAvg);
		dataMap.put("scienceAvg", scienceAvg);
		dataMap.put("engAvg", engAvg);

		//등급평균
		korAvg = getSchoolGradeAVG(korList);
		mathAvg = getSchoolGradeAVG(mathList);
		socialAvg = getSchoolGradeAVG(socialList);
		scienceAvg = getSchoolGradeAVG(scienceList);
		engAvg = getSchoolGradeAVG(engList);

		dataMap.put("korGradeAvg", korAvg);
		dataMap.put("mathGradeAvg", mathAvg);
		dataMap.put("socialGradeAvg", socialAvg);
		dataMap.put("scienceGradeAvg", scienceAvg);
		dataMap.put("engGradeAvg", engAvg);

		//평균점수 평균
		korAvg = getSchoolStandardAVG(korList);
		mathAvg = getSchoolStandardAVG(mathList);
		socialAvg = getSchoolStandardAVG(socialList);
		scienceAvg = getSchoolStandardAVG(scienceList);
		engAvg = getSchoolStandardAVG(engList);

		dataMap.put("korStandardAvg", korAvg);
		dataMap.put("mathStandardAvg", mathAvg);
		dataMap.put("socialStandardAvg", socialAvg);
		dataMap.put("scienceStandardAvg", scienceAvg);
		dataMap.put("engStandardAvg", engAvg);

		return dataMap;
	}

	private double getSchoolScoreAVG(List<SchoolScoreVO> list) {
		double avg = 0.0;
		if(list != null && list.size() != 0) {
			int sum = 0;
			for(SchoolScoreVO score : list) {
				sum += score.getMyscore();
			}
			avg = (double)sum / list.size();
		}

		return avg;
	}

	private double getSchoolGradeAVG(List<SchoolScoreVO> list) {
		double avg = 0.0;
		if(list != null && list.size() != 0) {
			int sum = 0;
			for(SchoolScoreVO score : list) {
				sum += Integer.parseInt(score.getMygrade());
			}
			avg = (double)sum / list.size();
		}

		return avg;
	}

	private double getSchoolStandardAVG(List<SchoolScoreVO> list) {
		double avg = 0.0;
		if(list != null && list.size() != 0) {
			int sum = 0;
			for(SchoolScoreVO score : list) {
				sum += score.getStandardScore();
			}
			avg = (double)sum / list.size();
		}

		return avg;
	}

	@Override
	public List<AcademyScoreVO> getAcademyScoreList(String id, int classCode) throws SQLException {
		return scoreDAO.selectAcademyScoreListByClassCode(id, classCode);
	}

	@Override
	public List<ClassVO> getClassNameListById(String id) throws SQLException {
		return classDAO.selectClassNameListById(id);
	}

	@Override
	public Map<String, String> getExamData(int examCode) throws SQLException {
		Map<String, String> dataMap = new HashMap<String, String>();

		String name = scoreDAO.selectExamName(examCode);
		dataMap.put("name", name);

		double avg = scoreDAO.selectAvgByCode(examCode);
		dataMap.put("avg", String.format("%.2f", avg));

		return dataMap;
	}

	@Override
	public Map<String, List<Map<String, String>>> getSubjectScoreData(String id) throws SQLException {
		Map<String, List<Map<String, String>>> dataMap = new HashMap<String, List<Map<String,String>>>();

		List<Map<String, String>> korList = scoreDAO.selectExamScoreBySubjectCode(id, 1);
		List<Map<String, String>> mathList = scoreDAO.selectExamScoreBySubjectCode(id, 2);
		List<Map<String, String>> socialList = scoreDAO.selectExamScoreBySubjectCode(id, 3);
		List<Map<String, String>> scienceList = scoreDAO.selectExamScoreBySubjectCode(id, 4);
		List<Map<String, String>> engList = scoreDAO.selectExamScoreBySubjectCode(id, 5);

		dataMap.put("korList", korList);
		dataMap.put("mathList", mathList);
		dataMap.put("socialList", socialList);
		dataMap.put("scienceList", scienceList);
		dataMap.put("engList", engList);

		return dataMap;
	}

	@Override
	public Map<String, Double> getAllSubjectScoreDataAvg() throws SQLException {
		Map<String, Double> dataMap = new HashMap<String, Double>();

		double korSum = 0;
		double engSum = 0;
		double mathSum = 0;
		double socialSum = 0;
		double scienceSum = 0;

		double korAvg, engAvg, mathAvg, socialAvg, scienceAvg;

		List<Map<String, String>> korList = scoreDAO.selectAllExamScoreBySubjectCode(1);
		List<Map<String, String>> mathList = scoreDAO.selectAllExamScoreBySubjectCode(2);
		List<Map<String, String>> socialList = scoreDAO.selectAllExamScoreBySubjectCode(3);
		List<Map<String, String>> scienceList = scoreDAO.selectAllExamScoreBySubjectCode(4);
		List<Map<String, String>> engList = scoreDAO.selectAllExamScoreBySubjectCode(5);


		//EXAM_CODE, ACADEMY_SCORE, EXAM_NAME
		for(Map<String, String> data : korList) {
			korSum += Double.parseDouble(String.valueOf(data.get("ACADEMY_SCORE")));
		}
		korAvg = Math.round(korSum/korList.size()*100)/100.0;

		for(Map<String, String> data : engList) {
			engSum += Double.parseDouble(String.valueOf(data.get("ACADEMY_SCORE")));
		}
		engAvg =  Math.round(engSum/korList.size()*100)/100.0;

		for(Map<String, String> data : mathList) {
			mathSum += Double.parseDouble(String.valueOf(data.get("ACADEMY_SCORE")));
		}
		mathAvg = Math.round(mathSum/mathList.size()*100)/100.0;

		for(Map<String, String> data : socialList) {
			socialSum += Double.parseDouble(String.valueOf(data.get("ACADEMY_SCORE")));
		}
		socialAvg = Math.round(socialSum/socialList.size()*100)/100.0;

		for(Map<String, String> data : scienceList) {
			scienceSum += Double.parseDouble(String.valueOf(data.get("ACADEMY_SCORE")));
		}
		scienceAvg = Math.round(scienceSum/scienceList.size()*100)/100.0;


		//double korAvg, , mathAvg, socialAvg, scienceAvg;
		dataMap.put("korAvg", korAvg);
		dataMap.put("engAvg", engAvg);
		dataMap.put("mathAvg", mathAvg);
		dataMap.put("socialAvg", socialAvg);
		dataMap.put("scienceAvg", scienceAvg);

		return dataMap;
	}

	@Override
	public Map<String, Object> getSubjectAreaData(String id) throws SQLException {

		Map<String, Object> dataMap = new HashMap<String, Object>();

		List<SubAreaVO> korAreaList = scoreDAO.selectSubAreaListBySubject(1);
		List<SubAreaVO> mathAreaList = scoreDAO.selectSubAreaListBySubject(2);
		List<SubAreaVO> socialAreaList = scoreDAO.selectSubAreaListBySubject(3);
		List<SubAreaVO> scienceAreaList = scoreDAO.selectSubAreaListBySubject(4);
		List<SubAreaVO> engAreaList = scoreDAO.selectSubAreaListBySubject(5);

		dataMap.put("korAreaList", korAreaList);
		dataMap.put("mathAreaList", mathAreaList);
		dataMap.put("socialAreaList", socialAreaList);
		dataMap.put("scienceAreaList", scienceAreaList);
		dataMap.put("engAreaList", engAreaList);

		List<Map<String,String>> korProblemlist = scoreDAO.selectSubAreaListBySubjectProblem(id,1);
		List<Map<String,String>> korWorngProblemlist = scoreDAO.selectSubAreaListBySubjectWorngProblem(id,1);
		List<Map<String,String>> engProblemlist = scoreDAO.selectSubAreaListBySubjectProblem(id,5);
		List<Map<String,String>> engWorngProblemlist = scoreDAO.selectSubAreaListBySubjectWorngProblem(id,5);
		List<Map<String,String>> mathProblemlist = scoreDAO.selectSubAreaListBySubjectProblem(id,2);
		List<Map<String,String>> mathWorngProblemlist = scoreDAO.selectSubAreaListBySubjectWorngProblem(id,2);

		//틀린문제 영역별로 분류
		Map<String, Double> korAreaScoreMap = getAreaScoreMap(korAreaList, korProblemlist, korWorngProblemlist);
		Map<String, Double> engAreaScoreMap = getAreaScoreMap(engAreaList, engProblemlist, engWorngProblemlist);
		Map<String, Double> mathAreaScoreMap = getAreaScoreMap(mathAreaList, mathProblemlist, mathWorngProblemlist);

		dataMap.put("korAreaScoreMap",korAreaScoreMap);
		dataMap.put("engAreaScoreMap",engAreaScoreMap);
		dataMap.put("mathAreaScoreMap",mathAreaScoreMap);

		return dataMap;

	}

	private Map<String, Double> getAreaScoreMap(List<SubAreaVO> areaList, List<Map<String,String>> problemlist, List<Map<String,String>> worngProblemlist) {

		Map<String, Double> dataMap = new HashMap<String, Double>();

		for(SubAreaVO sub : areaList) {
			int cnt = 0;
			int w_cnt = 0;
			for(Map<String,String> map : problemlist) {
				if(String.valueOf(map.get("SANAME")).equals(sub.getSaname())) {
					cnt++;
				}
			}

			for(Map<String,String> worngmap : worngProblemlist) {
				if(String.valueOf(worngmap.get("SANAME")).equals(sub.getSaname())) {
					w_cnt++;
				}
			}
			if(cnt != 0) {
				double data = (w_cnt / (double) cnt)*100;
				dataMap.put(sub.getSaname(), Math.round(data*10)/10.0);
			}else {
				dataMap.put(sub.getSaname(), 0.0);
			}
		}

		return dataMap;
	}

	@Override
	public Map<String, Map<String, Integer>> getScoreDataForGraph(String id) throws SQLException {

		Map<String, Integer> school = new HashMap<String, Integer>();

		List<SchoolScoreVO> korList = scoreDAO.selectAllScoreList(id , 1);
		for(int i=0; i<korList.size(); i++) {
			if(i == korList.size()-1) {
				school.put("korNow", (int)korList.get(i).getMyscore());

			}else{
				if(school.get("korAfter") == null) {
					school.put("korAfter", (int)korList.get(i).getMyscore());
				}else {
					int score = school.get("korAfter");
					school.put("korAfter", (score + (int)korList.get(i).getMyscore())/2);
				}
			}
		}

		List<SchoolScoreVO> engList = scoreDAO.selectAllScoreList(id , 5);
		for(int i=0; i<engList.size(); i++) {
			if(i == engList.size()-1) {
				school.put("engNow", (int)engList.get(i).getMyscore());

			}else{
				if(school.get("engAfter") == null) {
					school.put("engAfter", (int)engList.get(i).getMyscore());
				}else {
					int score = school.get("engAfter");
					school.put("engAfter", (score + (int)engList.get(i).getMyscore())/2);
				}
			}
		}
		List<SchoolScoreVO> mathList = scoreDAO.selectAllScoreList(id , 2);
		for(int i=0; i<mathList.size(); i++) {
			if(i == mathList.size()-1) {
				school.put("mathNow", (int)mathList.get(i).getMyscore());

			}else{
				if(school.get("mathAfter") == null) {
					school.put("mathAfter", (int)mathList.get(i).getMyscore());
				}else {
					int score = school.get("mathAfter");
					school.put("mathAfter", (score + (int)mathList.get(i).getMyscore())/2);
				}
			}
		}
		List<SchoolScoreVO> socialList = scoreDAO.selectAllScoreList(id , 3);
		for(int i=0; i<socialList.size(); i++) {
			if(i == socialList.size()-1) {
				school.put("socialNow", (int)socialList.get(i).getMyscore());

			}else{
				if(school.get("socialAfter") == null) {
					school.put("socialAfter", (int)socialList.get(i).getMyscore());
				}else {
					int score = school.get("socialAfter");
					school.put("socialAfter", (score + (int)socialList.get(i).getMyscore())/2);
				}
			}
		}
		List<SchoolScoreVO> scienceList = scoreDAO.selectAllScoreList(id , 4);
		for(int i=0; i<scienceList.size(); i++) {
			if(i == scienceList.size()-1) {
				school.put("scienceNow", (int)scienceList.get(i).getMyscore());

			}else{
				if(school.get("scienceAfter") == null) {
					school.put("scienceAfter", (int)scienceList.get(i).getMyscore());
				}else {
					int score = school.get("scienceAfter");
					school.put("scienceAfter", (score + (int)scienceList.get(i).getMyscore())/2);
				}
			}
		}

		Map<String, Integer> academy = new HashMap<String, Integer>();

		List<AcademyScoreVO> korAList = scoreDAO.selectAcademyScoreListByClassCode(id, 1);
		List<AcademyScoreVO> engAList = scoreDAO.selectAcademyScoreListByClassCode(id, 5);
		List<AcademyScoreVO> mathAList = scoreDAO.selectAcademyScoreListByClassCode(id, 2);
		List<AcademyScoreVO> socialAList = scoreDAO.selectAcademyScoreListByClassCode(id, 3);
		List<AcademyScoreVO> scienceAList = scoreDAO.selectAcademyScoreListByClassCode(id, 4);


		for(int i=0; i<korAList.size(); i++) {
			if(i == korAList.size()-1) {
				academy.put("korNow", (int)korAList.get(i).getAcademyScore());
			}else{
				if(academy.get("korAfter") == null) {
					academy.put("korAfter", (int)korAList.get(i).getAcademyScore());
				}else {
					int score = school.get("korAfter");
					academy.put("korAfter", (score + (int)korAList.get(i).getAcademyScore())/2);
				}
			}
		}

		for(int i=0; i<engAList.size(); i++) {
			if(i == engAList.size()-1) {
				academy.put("engNow", (int)engAList.get(i).getAcademyScore());

			}else{
				if(academy.get("engAfter") == null) {
					academy.put("engAfter", (int)engAList.get(i).getAcademyScore());
				}else {
					int score = school.get("engAfter");
					academy.put("engAfter", (score + (int)engAList.get(i).getAcademyScore())/2);
				}
			}
		}
		for(int i=0; i<mathAList.size(); i++) {
			if(i == mathAList.size()-1) {
				academy.put("mathNow", (int)mathAList.get(i).getAcademyScore());

			}else{
				if(academy.get("mathAfter") == null) {
					academy.put("mathAfter", (int)mathAList.get(i).getAcademyScore());
				}else {
					int score = school.get("mathAfter");
					academy.put("mathAfter", (score + (int)mathAList.get(i).getAcademyScore())/2);
				}
			}
		}
		for(int i=0; i<socialAList.size(); i++) {
			if(i == socialAList.size()-1) {
				academy.put("socialNow", (int)socialAList.get(i).getAcademyScore());

			}else{
				if(academy.get("socialAfter") == null) {
					academy.put("socialAfter", (int)socialAList.get(i).getAcademyScore());
				}else {
					int score = school.get("socialAfter");
					academy.put("socialAfter", (score + (int)socialAList.get(i).getAcademyScore())/2);
				}
			}
		}
		for(int i=0; i<scienceAList.size(); i++) {
			if(i == scienceAList.size()-1) {
				academy.put("scienceNow", (int)scienceAList.get(i).getAcademyScore());

			}else{
				if(academy.get("scienceAfter") == null) {
					academy.put("scienceAfter", (int)scienceAList.get(i).getAcademyScore());
				}else {
					int score = school.get("scienceAfter");
					academy.put("scienceAfter", (score + (int)scienceAList.get(i).getAcademyScore())/2);
				}
			}
		}



		Map<String, Map<String, Integer>> dataMap = new HashMap<String, Map<String,Integer>>();
		dataMap.put("school", school);
		dataMap.put("academy", academy);

		return dataMap;
	}

	@Override
	public Map<String, List<PacounseltVO>> getPredictionPassUni(String id) throws SQLException {
		Map<String, List<PacounseltVO>> dataMap = new HashMap<String, List<PacounseltVO>>();
		List<PacounseltVO> topList = scoreDAO.selectOverUniversity(id);
		List<PacounseltVO> midList = scoreDAO.selectPosibleUniversity(id);
		List<PacounseltVO> botList = scoreDAO.selectLowUniversity(id);

		dataMap.put("top", topList);
		dataMap.put("mid", midList);
		dataMap.put("bot", botList);

		return dataMap;
	}


}
