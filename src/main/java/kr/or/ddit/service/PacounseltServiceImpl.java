package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;

import kr.or.ddit.dao.PacounseltDAO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class PacounseltServiceImpl implements PacounseltService {



	private PacounseltDAO counseltDAO;

	public void setCounseltDAO(PacounseltDAO counseltDAO) {
		this.counseltDAO = counseltDAO;
	}

	@Override
	public Map<String, Object> getCounseltList(Criteria cri, Integer pcCode) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(counseltDAO.selectCounseltListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<PacounseltVO> counseltList = counseltDAO.selectSearchCounseltList(searchCri);

		for (PacounseltVO counselt : counseltList) {
			try {
				String name = counseltDAO.selectName(counselt.getPcCode());
				String universityname = counseltDAO.selectFuUniv(counselt.getPcCode());
				String universitynames = counseltDAO.selectSuUniv(counselt.getPcCode());
				String phone = counseltDAO.selectStudentPhone(counselt.getPcCode());
				String id = counseltDAO.selectId(counselt.getPcCode());
				// String universitynames=counseltDAO.selectSuUniv(counselt.getPcCode());
				// String name=counseltDAO.selectName(counselt.getCounCode());
				// counselt.setPcCode(pcCode);
				// counselt.setCounCode(counCode);
				counselt.setUniversityNames(universitynames);
				counselt.setUniversityName(universityname);
				// counselt.setUniversityName(universitynames);
				counselt.setName(name);
				counselt.setPhone(phone);
				counselt.setId(id);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		dataMap.put("counseltList", counseltList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public Map<String, Object> getCounseltEndList(Criteria cri, Integer pcCode) throws SQLException {
		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		try {
			pageMaker.setTotalCount(counseltDAO.selectCounseltEndListCount(searchCri));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<PacounseltVO> counseltEndList = counseltDAO.selectSearchCounseltEndList(searchCri);
		for (PacounseltVO counselt : counseltEndList) {
			try {
				String name = counseltDAO.selectName(counselt.getPcCode());

				// String name=counseltDAO.selectName(counselt.getCounCode());

				// counselt.setPcCode(pcCode);
				// counselt.setCounCode(counCode);
				counselt.setName(name);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		dataMap.put("counseltEndList", counseltEndList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public PacounseltVO getCounseltEnd(int pcCode) throws SQLException {
		PacounseltVO counselt = counseltDAO.selectCounseltByPcCode(pcCode);
		return counselt;
	}

	@Override
	public int updateCounseltDetailList(PacounseltVO paco) throws SQLException {
		System.out.println(paco.getPcCode());
		int abc = counseltDAO.updateCounseltDetailList(paco);
		return abc;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode2(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode2(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode3(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode3(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode4(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode4(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode5(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode5(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode6(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode6(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO getPacounselt(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectPacounseltByPcCode(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin2(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin2(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin3(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin3(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin4(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin4(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin5(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin5(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSchoolnaesin6(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSchoolnaesin6(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectStudentGrade(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectStudentGrade(pcCode);

		return pacoun;
	}

	@Override
	public Map<String, Object> getlowUniversityList(Integer pcCode) throws SQLException {

		Map<String, Object> dat = new HashMap<String, Object>();

		List<PacounseltVO> lowschool = null;
		try {
			lowschool = counseltDAO.selectLowUniversity(pcCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		dat.put("lowschool", lowschool);

		return dat;
	}

	@Override
	public Map<String, Object> getPosibleUniversityList(Integer pcCode) throws SQLException {
		Map<String, Object> data = new HashMap<String, Object>();

		List<PacounseltVO> posschool = null;
		try {
			posschool = counseltDAO.selectPosibleUniversity(pcCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		data.put("posschool", posschool);

		return data;
	}

	@Override
	public Map<String, Object> getOverUniversityList(Integer pcCode) throws SQLException {
		Map<String, Object> dataMa = new HashMap<String, Object>();

		List<PacounseltVO> overschool = null;
		try {
			overschool = counseltDAO.selectOverUniversity(pcCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		dataMa.put("overschool", overschool);

		return dataMa;
	}

	@Override
	public PacounseltVO selectFisrtHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectFisrtHighSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectScoreHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectScoreHighSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectFisrtPosibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectFisrtPosibleSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectFisrtPosibleScoreSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectFisrtPosibleScoreSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectFisrtDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectFisrtDownSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectFisrtDownScoreSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectFisrtDownScoreSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSecondHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSecondHighSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSecondScorePossibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSecondScorePossibleSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectThirdPossibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectThirdPossibleSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSecondOverSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSecondOverSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectThirdOverSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectThirdOverSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectSecondDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectSecondDownSchool(pcCode);

		return pacoun;
	}

	@Override
	public PacounseltVO selectThirdDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacoun = counseltDAO.selectThirdDownSchool(pcCode);

		return pacoun;
	}

	@Override
	public int insertCalender(PacounseltVO paco) throws SQLException {
		int abc = counseltDAO.insertCalender(paco);
		return abc;
	}

	@Override
	public PacounseltVO getpacounseltStatus(int pcCode) throws Exception {
		PacounseltVO pacounselt = counseltDAO.selectPacounseltBypcCodeStatus(pcCode);
		return pacounselt;
	}

	@Override
	public Map<String, Object> getselectCounseltListstatus() throws SQLException {

		Map<String, Object> da = new HashMap<String, Object>();

		List<PacounseltVO> conseltstatus = null;
		try {
			conseltstatus = counseltDAO.selectCounseltListstatus();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		for (PacounseltVO counselt : conseltstatus) {
			try {
				String name = counseltDAO.selectName(counselt.getPcCode());

				counselt.setName(name);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		da.put("conseltstatus", conseltstatus);

		return da;
	}

	@Override
	public void removecalender(int pcCode) throws Exception {
		// TODO Auto-generated method stub

		counseltDAO.deletePacounselt(pcCode);
	}

	@Override
	public int modifyCalender(PacounseltVO paco) throws SQLException {
		int abc = counseltDAO.modifyCalender(paco);
		return abc;
	}

	@Override
	public void updatePacounselt(String pcCode) throws SQLException {
		counseltDAO.updatePacounselt(pcCode);
	}

	@Override
	public void registPacounselt(PacounseltVO pvo) throws SQLException {
		int code = counseltDAO.selectNextSeq();
		pvo.setPcCode(code);
		counseltDAO.intsertPacounselt(pvo);
	}

}
