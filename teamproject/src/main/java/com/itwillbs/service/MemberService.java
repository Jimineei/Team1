package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.MemberVO;

public interface MemberService {
	
	
	// 사용자의 처리 로직을 구현
	
	// 회원가입 동작
	public String memberJoin(MemberVO vo);
	
	// 회원로그인 체크 동작
	public MemberVO memberLoginCheck(MemberVO vo);
	
	// 회원가입 id 중복 체크
	public MemberVO memberIdCheck(String member_id);
	
	// 회원정보 조회 
	public MemberVO memberEmailSearch(String email);
	
	// 회원정보 수정
	public int memberUpdate(MemberVO vo);

	// 회원정보 삭제
	public Integer memberDelete(MemberVO vo);
	
	// 회원정보 전화번호 조회
	public MemberVO memberInfoTel(String tel);
	
	// 회원정보 목록
	public List<MemberVO> memberList();

	// admin 특정 회원 조회.
	public Map<String, Object> memberInfo(String Member_id);
}
