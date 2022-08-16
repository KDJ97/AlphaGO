package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.StudentVO;

public class ApplyDAOImpl implements ApplyDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<ApplyVO> selectApplyList() throws SQLException {
		List<ApplyVO>applyList=null;
		
		try {
			applyList=session.selectList("Apply-Mapper.selectApplyList");
		} catch (Exception e) {
			throw e;
		}
		return applyList;
	}

	@Override
	public List<ApplyVO> selectApplyList (Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		List<ApplyVO> applyList
		= session.selectList("Apply-Mapper.selectApplyList",null,rowBounds);
		
		return applyList;
	}

	@Override
	public int selectApplyListCount(SearchCriteria cri) throws Exception {
	    return session.selectOne("Apply-Mapper.selectSearchApplyListCount", cri);
	}

	@Override
	public int selectSearchApplyListCount(SearchCriteria cri) throws Exception {
		int totalCount = session.selectOne("Apply-Mapper.selectSearchApplyListCount", cri);
		return totalCount;
	}

	@Override
	public List<ApplyVO> selectSearchApplyList( SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<ApplyVO> applyList = session.selectList("Apply-Mapper.selectSearchApplyList", cri, rowBounds);

		return applyList;
	}

	@Override
	public ApplyVO selectAttachByApplyCode(int applyCode) throws SQLException {
		ApplyVO apply=session.selectOne("Apply-Mapper.selectAttachByApplyCode",applyCode);
		return apply;
	}

	
	//지원서 등록
	@Override
	public int insertApply(ApplyVO apply) throws SQLException {
		int applys=session.update("Apply-Mapper.insertApply",apply);
		
		return applys;
	}

	@Override
	public int selectApplySequenceNextValue() throws SQLException {
		int applyCode=session.selectOne("Apply-Mapper.selectApplySequenceNextValue");
		return applyCode;
	}

	@Override
	public int updateresume(String applyfilename) throws SQLException {
		int upresume=session.update("Apply-Mapper.updateresume",applyfilename);
		
		return upresume;
	}

	@Override
	public ApplyVO selectApplyByApplyCode(int applyCode) throws SQLException {
		 return session.selectOne("Apply-Mapper.selectApplyByApplyCode",applyCode);
	
	}


}
