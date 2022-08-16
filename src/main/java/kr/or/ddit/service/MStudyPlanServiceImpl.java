package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.dao.ClassDAO;
import kr.or.ddit.dao.MStudyPlanDAO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;

public class MStudyPlanServiceImpl implements MStudyPlanService {

	private MStudyPlanDAO mStudyPlanDAO;
	public void setmStudyPlanDAO(MStudyPlanDAO mStudyPlanDAO) {
		this.mStudyPlanDAO = mStudyPlanDAO;
	}
	
	private ClassDAO classDAO;
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}
	
	@Override
	public List<ClassVO> selectClassListByCpcheck(String cpcheck) throws SQLException {
		List<ClassVO> classList = null;
		classList = mStudyPlanDAO.selectClassListByCpcheck(cpcheck);
		if(classList!=null&&classList.size()>0)
			for(ClassVO classVO : classList) {
				String startDate = classVO.getStartDate();
				String endDate = classVO.getEndDate();

				String newStartDate = startDate.substring(0, 11);
				String newEndDate = endDate.substring(0, 11);
				
				classVO.setStartDate(newStartDate);
				classVO.setEndDate(newEndDate);
			}
		return classList;
	}

	@Override
	public void updateCpcheck(ClassVO classVO) throws SQLException {
		mStudyPlanDAO.updateCpcheck(classVO);
	}

	/**
	 * 후기가 4.0이상인 HOT한 수업
	 */
	@Override
	public List<ClassVO> selectHotClassList() throws SQLException {
		List<ClassVO> tempList = new ArrayList<ClassVO>();//건너갈 리스트
		List<ClassVO> resultList = new ArrayList<ClassVO>();//보내줄 리스트
		List<ClassVO> selectClassList = mStudyPlanDAO.selectClassList();//진행중인 수업리스트
//		System.out.println("size : " + selectClassList.size());
		if(selectClassList!=null&&selectClassList.size()>0) {
			for(ClassVO classVO : selectClassList) {
				String classCode = classVO.getClassCode();//수업 코드
				int reviewCnt = mStudyPlanDAO.selectClassReviewCount(classCode);//수업 리뷰 개수
//				System.out.println("reviewCnt : " + reviewCnt);
				if(reviewCnt>=5) {//리뷰 개수가 10개 이상인 수업들만..
					tempList.add(classVO);
				}
			}
		}
//		System.out.println("tempList : " + tempList);
//		System.out.println("tempList Size : " + tempList.size());
		if(tempList.size()>0&&tempList!=null) {
			for(ClassVO classVO : tempList) {
				double res=0;
				double sum = 0;
				String classCode = classVO.getClassCode();
//				System.out.println(classCode);
				//리뷰 리스트
				List<ClassReviewVO> reviewList = classDAO.selectClassReview(classCode);
//				System.out.println(reviewList.toString());
//				System.out.println(reviewList.size());
				for(ClassReviewVO reviewVO : reviewList) {
					sum += reviewVO.getStarScore();//점수합산
					System.out.println(reviewVO.getStarScore());
				}
				System.out.println("starScore SUM : " + sum);
				res = sum/reviewList.size();//평균 별점 계산
				System.out.println("starScore res : " + res);
				if(res>=4.0) {
					classVO.setStarScore(res);
					classVO.setCpcheck("5");//임의로 설정한 값입니다
					classVO.setStartDate(classVO.getStartDate().substring(0, 11));
					classVO.setEndDate(classVO.getEndDate().substring(0, 11));
					resultList.add(classVO);
				}
			}
		}
		System.out.println(resultList);
		return resultList;
	}

	/**
	 * 후기가 3.0 미만인 비인기 수업
	 */
	@Override
	public List<ClassVO> selectWorstClassList() throws SQLException {
		List<ClassVO> tempList = new ArrayList<ClassVO>();//건너갈 리스트
		List<ClassVO> resultList = new ArrayList<ClassVO>();//보내줄 리스트
		List<ClassVO> selectClassList = mStudyPlanDAO.selectClassList();//진행중인 수업리스트
//		System.out.println("size : " + selectClassList.size());
		if(selectClassList!=null&&selectClassList.size()>0) {
			for(ClassVO classVO : selectClassList) {
				String classCode = classVO.getClassCode();//수업 코드
				int reviewCnt = mStudyPlanDAO.selectClassReviewCount(classCode);//수업 리뷰 개수
//				System.out.println("reviewCnt : " + reviewCnt);
				if(reviewCnt>=5) {//리뷰 개수가 5개 이상인 수업들만..
					tempList.add(classVO);
				}
			}
		}
//		System.out.println("tempList : " + tempList);
//		System.out.println("tempList Size : " + tempList.size());
		if(tempList.size()>0&&tempList!=null) {
			for(ClassVO classVO : tempList) {
				double res=0;
				double sum = 0;
				String classCode = classVO.getClassCode();
				System.out.println(classCode);
				//리뷰 리스트
				List<ClassReviewVO> reviewList = classDAO.selectClassReview(classCode);
//				System.out.println(reviewList.toString());
				System.out.println(reviewList.size());
				for(ClassReviewVO reviewVO : reviewList) {
					sum += reviewVO.getStarScore();//점수합산
					System.out.println(reviewVO.getStarScore());
				}
				System.out.println("starScore SUM : " + sum);
				res = sum/reviewList.size();//평균 별점 계산
				System.out.println("starScore res : " + res);
				if(res<3.0) {
					classVO.setStarScore(res);
					classVO.setCpcheck("6");//임의로 설정한 값입니다
					classVO.setStartDate(classVO.getStartDate().substring(0, 11));
					classVO.setEndDate(classVO.getEndDate().substring(0, 11));
					resultList.add(classVO);
				}
			}
		}
		System.out.println(resultList);
		return resultList;
	}

	/**
	 * 수업계획 취소
	 */
	@Override
	public void removeClassPlan(String classCode) throws SQLException {
		mStudyPlanDAO.deleteTimeDetailByClassCode(classCode);
		mStudyPlanDAO.deleteClassByClassCode(classCode);
	}

}













