package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.dao.ExamDAO;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.WrongVO;

public class ExamServiceImpl implements ExamService {

	private ExamDAO examDAO;

	public void setExamDAO(ExamDAO examDAO) {
		this.examDAO = examDAO;
	}

	/**
	 * 강의 선택전 전체 미응시 시험 리스트
	 * 
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<ExamVO> getExam(String id) throws SQLException {
		List<ExamVO> examList = examDAO.getExam(id);

		return examList;
	}

	/**
	 * 강의 선택후 시험 리스트
	 * 
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<ExamVO> selectExamList(Map<String, Object> map) throws SQLException {
		List<ExamVO> examList = examDAO.selectExamList(map);

		return examList;
	}

	/**
	 * 시험응시(시험지)
	 * 
	 * @param examCode
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<ProblemVO> getExamProblem(int examCode) throws SQLException {
		List<ProblemVO> problemList = examDAO.getExamProblem(examCode);

		for (ProblemVO problem : problemList) {
			if (problem.getProblemPrint() != null) {
				String content = problem.getProblemPrint().replace("\n", " ");
				String question = problem.getProblemContent().replace("\n", " ");

				problem.setProblemPrint(content);
				problem.setProblemContent(question);
			} else {
				String question = problem.getProblemContent().replace("\n", " ");
				problem.setProblemContent(question);
			}
		}

		return problemList;
	}

	/**
	 * 지문 유무
	 */
	@Override
	public ProblemVO getJimoon(int problemCode) throws SQLException {
		ProblemVO pro = examDAO.getJimoon(problemCode);

		return pro;
	}

	@Override
	public Map<String, Object> checkExam(HttpServletRequest request, int examCode, HttpSession session, int problem)
			throws SQLException {

		List<String> answerList = new ArrayList<String>();

		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();

		for (int i = 1; i <= problem; i++) {
			String answerKey = "select" + i;
			String zooKey = "zoo" + i;
			String answer = request.getParameter(answerKey);
			if (answer == null) {
				answer = request.getParameter(zooKey);
			}

			answerList.add(answer);
		}
		System.out.println(answerList);

		String ans = ""; // 실제 문제 답
		int score = 0; // 점수
		String wrong = ""; //오답문제번호
		String wrongCon = ""; // 오답
		
		List<String> wrongList = new ArrayList<String>(); // 오답번호 리스트	
		List<String> wrongConList = new ArrayList<String>(); //wrong 객체 리스트
		
		WrongVO wrongVO = new WrongVO();
		
		try {
			for (int i = 0; i < problem; i++) {
				ans = examDAO.getExamProblem(examCode).get(i).getProblemAnswer();

				if (ans.equals(answerList.get(i))) {
					score += 100 / problem;
				} else if (!ans.equals(answerList.get(i))) {
					wrong = "";
					wrong += (i + 1);					
					wrongList.add(wrong);
					
					wrongCon = answerList.get(i);	
					wrongConList.add(wrongCon);
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();

			map.put("examCode", examCode);

			int res = 0;
			for (int i = 0; i < wrongConList.size(); i++) {
				map.put("pronum", wrongList.get(i));
				if (examDAO.selectCode(map) != 0) {
					res = examDAO.selectCode(map);

					int wCode = examDAO.selectWrongSeq();

					wrongVO.setId(id);
					wrongVO.setExamCode(examCode);
					wrongVO.setProblemCode(res);
					wrongVO.setWno(wCode);
					wrongVO.setWrong(wrongConList.get(i));
					
					examDAO.insertWrong(wrongVO);
				}
			}
			
			AcademyScoreVO acaVO = new AcademyScoreVO();
			acaVO.setExamCode(examCode);
			acaVO.setAcademyScore(score);
			acaVO.setId(id);

			if (score >= 90) {
				acaVO.setAchievement("A");
			} else if (score >= 80) {
				acaVO.setAchievement("B");
			} else {
				acaVO.setAchievement("C");
			}

			int asCode = examDAO.selectSeq(); // 시퀀스 값 불러오기
			acaVO.setAscode(asCode);

			examDAO.insertScore(acaVO);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("answerList", answerList);
//
		return dataMap;
	}

	@Override
	public Map<String, Object> resultExam(int examCode, HttpSession session) throws SQLException {
		AcademyScoreVO acSVO = new AcademyScoreVO();
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();

		map.put("examCode", examCode);
		map.put("id", id);

		acSVO = examDAO.selectScore(map);

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("score", acSVO);

		return dataMap;
	}

	/**
	 * 문제 페이지네이션
	 */
	@Override
	public Map<String, Object> problemPrint(int examCode) throws SQLException {
		List<ProblemVO> problemList = null;

		try {
			problemList = examDAO.getExamProblem(examCode);
			
			for(ProblemVO problem : problemList) {
				if (problem.getProblemPrint() != null) {
					String content = problem.getProblemPrint().replace("\n", " ");
					String question = problem.getProblemContent().replace("\n", " ");
					//String solution = problem.getProblemSolution().replace("\n", " ");

					problem.setProblemPrint(content);
					problem.setProblemContent(question);
					//problem.setProblemSolution(solution);
				} else {
					String question = problem.getProblemContent().replace("\n", " ");
					//String solution = problem.getProblemSolution().replace("\n", " ");
					problem.setProblemContent(question);
					//problem.setProblemSolution(solution);
				}

			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<Map<String, Object>> pageInfo = new ArrayList<Map<String, Object>>();

		int i = 0;

		while (true) {
			try {
				if (examDAO.getJimoon(problemList.get(i).getProblemCode()) != null) {
					Map<String, Object> data = new HashMap<String, Object>();// 지문 있음
					if (i + 2 > problemList.size()) {
						data.put("startNum", i);
						data.put("endNum", problemList.size());

						pageInfo.add(data);

						i = problemList.size();
					} else {
						data.put("startNum", i);
						data.put("endNum", i + 1);

						pageInfo.add(data);

						i = i + 2;
					}
					if (i == problemList.size()) {
						break;
					}
				} else {
					Map<String, Object> data = new HashMap<String, Object>();
					if (i + 4 > problemList.size()) {
						data.put("startNum", i);
						data.put("endNum", problemList.size());

						pageInfo.add(data);

						i = problemList.size();
					} else {
						data.put("startNum", i);
						data.put("endNum", i + 3);

						pageInfo.add(data);

						i = i + 4;
					}

					if (i == problemList.size()) {
						break;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("pageInfo", pageInfo);
		dataMap.put("problem", problemList);

		return dataMap;
	}

	@Override
	public Map<String, Object> checkWrong(int examCode, HttpSession session) throws SQLException {
		   
		Map<String, Object> map =  new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();	
		map.put("id", id);
		map.put("examCode", examCode);
		
		List<WrongVO> wrongList = examDAO.selectWrong(map);	
		   
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap.put("wrongList", wrongList);
		   
	    return dataMap;
	}
}

