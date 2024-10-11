package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ProdVO;

/**
 * 
 *	prod 테이블의 데이터를 활용하는 동작을 정의 
 *  
 */

public interface ProdDAO {
	
	// 제품등록
	public void insertProd(ProdVO vo);
	
	// 제품목록
	public List<ProdVO> listProd();
	
	// 제품조회
	public ProdVO findProd(ProdVO vo);
	
}
