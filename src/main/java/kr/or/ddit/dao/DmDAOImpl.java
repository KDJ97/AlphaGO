package kr.or.ddit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.DmVO;

public class DmDAOImpl implements DmDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<DmVO> selectSendList(String id) throws Exception {
		List<DmVO> dmList = null;

		try {
			dmList = session.selectList("Dm-Mapper.selectSendList", id);
		} catch (Exception e) {
			throw e;
		}

		return dmList;
	}

	@Override
	public List<DmVO> selectReciveList(String id) throws Exception {
		List<DmVO> dmList = null;

		try {
			dmList = session.selectList("Dm-Mapper.selectReciveList", id);
		} catch (Exception e) {
			throw e;
		}

		return dmList;
	}

	@Override
	public DmVO selectDm(String code, String div) {

		DmVO dm = null;

		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("div", div);

		try {
			dm = session.selectOne("Dm-Mapper.selectDm", map);
		} catch (Exception e) {
			throw e;
		}
		return dm;
	}

	@Override
	public void updateDmByRead(String code) {
		session.update("Dm-Mapper.updateDmByRead", code);
	}

	@Override
	public int selectNewDm(String id) throws Exception {
		int cnt = session.selectOne("Dm-Mapper.selectNewDm", id);
		return cnt;
	}

	@Override
	public void deleteDm(String code, String div) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("div", div);

		session.update("Dm-Mapper.deleteDm",map);
	}

	@Override
	public int selectMaxDm() {
		return session.selectOne("Dm-Mapper.selectMaxDm");
	}

	@Override
	public void insertDm(DmVO dm) {
		session.update("Dm-Mapper.insertDm", dm);
	}

	@Override
	public List<DmVO> selectNotReadDmById(String id) {
		return session.selectList("Dm-Mapper.selectNotReadDmById", id);
	}

}
