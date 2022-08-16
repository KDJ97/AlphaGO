package kr.or.ddit.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.TimeZone;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.StudentVO;

public class PacounseltDAOImpl implements PacounseltDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<PacounseltVO> selectCounseltList() throws Exception {

		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectCounseltList");
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public List<PacounseltVO> selectCounseltList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<PacounseltVO> counseltList = session.selectList("Pacounselt-Mapper.selectCounseltList", null, rowBounds);

		return counseltList;
	}

	@Override
	public int selectCounseltListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectSearchCounseltListCount", cri);
	}

	@Override
	public int selectSearchCounseltListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("Pacounselt-Mapper.selectSearchCounseltListCount", cri);
		return totalCount;
	}

	@Override
	public List<PacounseltVO> selectSearchCounseltList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<PacounseltVO> counseltList = session.selectList("Pacounselt-Mapper.selectSearchCounseltList", cri,
				rowBounds);

		return counseltList;
	}

	@Override
	public List<PacounseltVO> selectCounseltEndList() throws Exception {
		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectCounseltEndList");
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public List<PacounseltVO> selectCounseltEndList(Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<PacounseltVO> counseltList = session.selectList("Pacounselt-Mapper.selectCounseltEndList", null,
				rowBounds);

		return counseltList;
	}

	@Override
	public int selectCounseltEndListCount(SearchCriteria cri) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectSearchCounseltEndListCount", cri);
	}

	@Override
	public int selectSearchCounseltEndListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("Pacounselt-Mapper.selectSearchCounseltEndListCount", cri);
		return totalCount;
	}

	@Override
	public List<PacounseltVO> selectSearchCounseltEndList(SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<PacounseltVO> counseltList = session.selectList("Pacounselt-Mapper.selectSearchCounseltEndList", cri,
				rowBounds);

		return counseltList;
	}

	@Override
	public PacounseltVO selectCounseltByPcCode(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectCounseltByPcCode", pcCode);
		return pacounselt;
	}

	@Override
	public int updateCounseltDetailList(PacounseltVO paco) throws SQLException {

		System.out.println("???");
		System.out.println(paco);
		System.out.println("???");
		int pacounselt = session.update("Pacounselt-Mapper.updateCounseltDetailList", paco);

		return pacounselt;
	}

	@Override
	public String selectName(Integer pcCode) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectName", pcCode);
	}

	@Override
	public String selectFuUniv(Integer pcCode) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectFuUniv", pcCode);

	}

	@Override
	public PacounseltVO selectPacounseltByPcCode(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode2(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode2", pcCode);
		return pacounselt;
	}

	@Override
	public String selectSuUniv(Integer pcCode) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectSuUniv", pcCode);
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode3(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode3", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode4(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode4", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode5(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode5", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectPacounseltByPcCode6(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltByPcCode6", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin2(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin2", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin3(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin3", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin4(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin4", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin5(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin5", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSchoolnaesin6(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSchoolnaesin6", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectStudentGrade(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectStudentGrade", pcCode);
		return pacounselt;
	}

	@Override
	public String selectStudentPhone(Integer pcCode) throws SQLException {
		return session.selectOne("Pacounselt-Mapper.selectStudentPhone", pcCode);
	}

	@Override
	public List<PacounseltVO> selectLowUniversity(int pcCode) throws Exception {

		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectLowUniversity", pcCode);
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public List<PacounseltVO> selectPosibleUniversity(int pcCode) throws Exception {
		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectPosibleUniversity", pcCode);
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public List<PacounseltVO> selectOverUniversity(int pcCode) throws Exception {
		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectOverUniversity", pcCode);
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public PacounseltVO selectFisrtHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectFisrtHighSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectScoreHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectScoreHighSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectFisrtPosibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectFisrtPosibleSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectFisrtPosibleScoreSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectFisrtPosibleScoreSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectFisrtDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectFisrtDownSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectFisrtDownScoreSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectFisrtDownScoreSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSecondHighSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSecondHighSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSecondScorePossibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSecondScorePossibleSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectThirdPossibleSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectThirdPossibleSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSecondOverSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSecondOverSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectThirdOverSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectThirdOverSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectSecondDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectSecondDownSchool", pcCode);
		return pacounselt;
	}

	@Override
	public PacounseltVO selectThirdDownSchool(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectThirdDownSchool", pcCode);
		return pacounselt;
	}

	@Override
	public int insertCalender(PacounseltVO paco) throws SQLException {
		int pacounselt = session.update("Pacounselt-Mapper.insertCalender", paco);

		return pacounselt;
	}

	@Override
	public String selectId(Integer pcCode) throws Exception {
		return session.selectOne("Pacounselt-Mapper.selectId", pcCode);
	}

	@Override
	public PacounseltVO selectPacounseltBypcCodeStatus(int pcCode) throws SQLException {
		PacounseltVO pacounselt = session.selectOne("Pacounselt-Mapper.selectPacounseltBypcCodeStatus", pcCode);
		return pacounselt;
	}

	@Override
	public List<PacounseltVO> selectCounseltListstatus() throws Exception {
		List<PacounseltVO> counseltList = null;

		try {
			counseltList = session.selectList("Pacounselt-Mapper.selectCounseltListstatus");
		} catch (Exception e) {
			throw e;
		}
		return counseltList;
	}

	@Override
	public void deletePacounselt(int pcCode) throws SQLException {
		session.update("Pacounselt-Mapper.deletePacounselt", pcCode);

	}

	@Override
	public int modifyCalender(PacounseltVO paco) throws SQLException {

		int pacounselt = session.update("Pacounselt-Mapper.modifyCalender", paco);

		return pacounselt;
	}

	/**
	 * delay 상담 상태 업데이트
	 */
	@Override
	public void updatePacounselt(String pcCode) throws SQLException {
		session.update("Pacounselt-Mapper.updateDelayCounselt", pcCode);
	}

	@Override
	public int selectNextSeq() throws SQLException {
		return session.selectOne("Pacounselt-Mapper.selectNextSeq");
	}

	@Override
	public void intsertPacounselt(PacounseltVO pvo) throws SQLException {
		session.update("Pacounselt-Mapper.intsertPacounselt", pvo);
	}

//	@Override
//	public PacounseltVO selectPacounseltByPcCode(int pcCode) throws SQLException {
//		// TODO Auto-generated method stub
//		return null;
//	}

//	@Override
//	public PacounseltVO selectFuUniv(int pcCode) throws SQLException {
//		PacounseltVO pacounselt=session.selectOne("Pacounselt-Mapper.selectFuUniv",pcCode);
//		return pacounselt;
//	}

}
