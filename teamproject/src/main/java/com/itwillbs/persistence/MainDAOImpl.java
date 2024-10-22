package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MainVO;

@Repository
public class MainDAOImpl implements MainDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MainMapper";
	private static final Logger logger = LoggerFactory.getLogger(MainDAOImpl.class);
	
	@Override
	public MainVO getQty() {
		logger.debug("( •̀ ω •́ )✧ MainDAO : getQty() 실행");
		MainVO vo = new MainVO();
		vo.setProd_all_qty(sqlSession.selectOne(NAMESPACE + ".prodAllQty"));
		vo.setMonth_ord(sqlSession.selectOne(NAMESPACE + ".monthOrd"));
		vo.setMonth_rcv(sqlSession.selectOne(NAMESPACE + ".monthRcv"));
		vo.setMonth_shp(sqlSession.selectOne(NAMESPACE + ".monthShp"));
		
		return vo;
	}

	@Override
	public List<MainVO> dayQty() {
		logger.debug("( •̀ ω •́ )✧ MainDAO : dayQty() 실행");
		
		return sqlSession.selectList(NAMESPACE + ".dayQty");
	}
	
	

}
