package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.SchoolDAO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubjectVO;

public class SchoolServiceImpl implements SchoolService {

	private SchoolDAO schoolDAO;
	public void setSchoolDAO(SchoolDAO schoolDAO) {
		this.schoolDAO = schoolDAO;
	}
	
	/**
	 * 고등학교 목록을 반환하는 서비스
	 */
	@Override
	public Map<String, Object> selectSearchSchoolList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<SchoolVO> schoolList = schoolDAO.selectSearchSchoolList(cri);
		int totalCount = schoolDAO.selectSearchSchoolListCount();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		//학원생 전체 수
		int allStuCnt = schoolDAO.studentCnt();
		
		//학원 내 원생 학교 분포율 구하고 set하기
		for(SchoolVO schoolVO : schoolList) {
			String schoolCode = schoolVO.getSchoolCode();
			int schoolCnt = schoolDAO.schoolCntStudent(schoolCode);
			
			//(원생 학교 인원수/전체 원생수)*100
			double result = ((double)schoolCnt/allStuCnt)*100;
			String schoolPercent = String.valueOf(result);
			schoolVO.setSchoolPercent(schoolPercent);
		}
		Collections.sort(schoolList, new SortByDouble());
		
		dataMap.put("schoolList", schoolList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	/**
	 * 학교 상세정보를 처리하는 서비스
	 */
	@Override
	public SchoolVO getSchoolDetail(String schoolCode) throws SQLException {
		return schoolDAO.getSchoolDetail(schoolCode);
	}

	/**
	 * 학교 정보를 삭제하는 서비스
	 */
	@Override
	public int removeSchool(String schoolCode) throws SQLException {
		return schoolDAO.removeSchool(schoolCode);
	}

	/**
	 * 학교 등록 하는 서비스
	 */
	@Override
	public int insertSchool(SchoolVO schoolVO) throws SQLException {
		int seq = schoolDAO.getSchoolSeq();
		String schoolCode = String.valueOf(seq);
		schoolVO.setSchoolCode(schoolCode);
		int result=schoolDAO.insertSchool(schoolVO);
		return result;
	}

	/**
	 * 해당 학교 학생들의 리스트(평균 등급 계산)
	 */
	@Override
	public List<MemberVO> selectMemberBySchoolCode(String schoolCode) throws SQLException {
		List<MemberVO> memberList = schoolDAO.selectMemberBySchoolCode(schoolCode);
		for(MemberVO member : memberList) {//학생 평균 등급 구하기
			String id = member.getId();
			List<SchoolScoreVO> scoreList = schoolDAO.selectScoreGradeById(id);
			double avgGrade = 0.0;
			double sumGrade = 0.0;
			if(scoreList!=null&&scoreList.size()>0) {
				for(SchoolScoreVO score:scoreList) {
					double mgrade = Integer.parseInt(score.getMygrade());
					sumGrade += mgrade;
				}
				avgGrade = sumGrade/scoreList.size();//평균등급 계산 결과
			}
			member.setAcheive(avgGrade);
		}
		return memberList;
	}

	/**
	 * 학교목록에 전체 학생 리스트를 뿌려주기 위해 생성한 service
	 */
	@Override
	public List<MemberVO> selectMemberList() throws SQLException {
		List<MemberVO> memberList = schoolDAO.selectMemberList();
		for(MemberVO member : memberList) {//학생 평균 등급 구하기
			String id = member.getId();
			List<SchoolScoreVO> scoreList = schoolDAO.selectScoreGradeById(id);
			double avgGrade = 0.0;
			double sumGrade = 0.0;
			if(scoreList!=null&&scoreList.size()>0) {
				for(SchoolScoreVO score:scoreList) {
					double mgrade = Integer.parseInt(score.getMygrade());
					sumGrade += mgrade;
				}
				avgGrade = sumGrade/scoreList.size();//평균등급 계산 결과
			}
			member.setAcheive(avgGrade);
		}
		return schoolDAO.selectMemberList();
	}

	@Override
	public List<SchoolScoreVO> selectSchoolScoreAvg(String schoolCode) throws SQLException {
		List<SubjectVO> subjectList = schoolDAO.selectSubjectList();
		List<SchoolScoreVO> schoolScoreList = new ArrayList<SchoolScoreVO>();
	
		
		if(subjectList!=null&&subjectList.size()>0)//과목리스트가 있으면 실행
			for(SubjectVO subjectVO : subjectList) {
				//평균 값을 넣을 변수
				float res = 0;
				int subjectCode = Integer.parseInt(subjectVO.getSubjectCode());//과목코드 하나씩 꺼내기
				String subjectName = subjectVO.getSubjectName();//과목명 하나씩 꺼내기
				
				//쿼리로 보내줄 VO 생성
				SchoolScoreVO schoolScoreVO = new SchoolScoreVO();
				schoolScoreVO.setSchoolCode(schoolCode);
				schoolScoreVO.setSubjectCode(subjectCode);
//				System.out.println("과목코드 : " + subjectCode + " / 과목명 : " + subjectName);
				//VO에 학교코드, 과목코드 셋
				
				List<SchoolScoreVO> schoolSubjectScoreList = schoolDAO.selectSchoolScoreListBySchoolCode(schoolScoreVO);  
				float sumScore = 0;
				if(schoolSubjectScoreList!=null&&schoolSubjectScoreList.size()>0) {//점수 리스트가 있을때
					for(SchoolScoreVO schoolSubjectScoreVO : schoolSubjectScoreList) {
						if(schoolSubjectScoreVO.getMyscore()!=0) {
							sumScore += schoolSubjectScoreVO.getMyscore();//해당 과목 점수 합
						}
					}
					res = sumScore/schoolSubjectScoreList.size();
				}//if문 끝
				SchoolScoreVO resultVO = new SchoolScoreVO();
				resultVO.setSubjectCode(subjectCode);
				resultVO.setMyscore(res);
				resultVO.setSubjectName(subjectName);
				
				schoolScoreList.add(resultVO);
			}
//		System.out.println(schoolScoreList);
		
		return schoolScoreList;
	}

	@Override
	public List<SchoolScoreVO> selectSchoolScoreById(SchoolScoreVO schoolScoreVO) throws SQLException {
		List<SchoolScoreVO> resList = new ArrayList<SchoolScoreVO>();//결과를 넣을 리스트
		List<SubjectVO> subjectList = schoolDAO.selectSubjectList();//과목 리스트
		if(subjectList!=null&&subjectList.size()>0) {
			for(SubjectVO subjectVO : subjectList) {
				float res = 0;//평균값 넣을 변수
				int subjectCode = Integer.parseInt(subjectVO.getSubjectCode());//과목코드 하나씩 꺼내기
				String subjectName = subjectVO.getSubjectName();//과목명 하나씩 꺼내기
				
				//쿼리로 보내줄 파라미터 VO
				schoolScoreVO.setSubjectCode(subjectCode);
				//---------------------
				System.out.println("과목코드 : " + subjectCode + " / 과목명 : " + subjectName);
				//학생의 학교성적 리스트
				List<SchoolScoreVO> scoreList = schoolDAO.selectSchoolScoreListById(schoolScoreVO);
				float sumScore = 0;
				System.out.println(scoreList);
				if(scoreList!=null&&scoreList.size()>0) {
					for(SchoolScoreVO scoreVO : scoreList) {
							sumScore += scoreVO.getMyscore();//해당 과목 점수 합
					}
					res = sumScore/scoreList.size();
				}//if문 끝
				SchoolScoreVO resultVO = new SchoolScoreVO();
				resultVO.setSubjectCode(subjectCode);
				resultVO.setSubjectName(subjectName);
				resultVO.setMyscore(res);
				
				resList.add(resultVO);
			}
		}
		return resList;
	}

}

//학교 분포율 기준으로 정렬
class SortByDouble implements Comparator<SchoolVO> {
    @Override
    public int compare(SchoolVO o1, SchoolVO o2) {
       return -(o1.getSchoolPercent()).compareTo((String)o2.getSchoolPercent());
    }
 }










