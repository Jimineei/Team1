package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;

/**
 * 
 * MemberDAO 동작을 수행
 *
 */
// @Repository : 스프링이 해당클래스를 DAO객체 (Bean)로 인식
// 				root-context.xml파일에서 해당객체를 사용하도록 설정.
// 
@Repository
public class MemberDAOImpl implements MemberDAO {
	// 파일에 S라고 붙어 있으면 spring이 관리하는대상을 나타냄.

	// 공통변수, 디비 연결, 자원해제
	// 디비 연결객체(SqlSessionFactory)가 필요함 => 의존관계 주입
//	@Inject
//	private SqlSessionFactory sqlFactory;

	@Inject
	private SqlSession sqlSession; // 자동으로 연결, 자원해제,SQL실행, mybatis...

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper";

	@Override
	public String insertMember(MemberVO vo) {
		System.out.println(" DAO : 회원가입 동작 실행! ");

		// ID 중복 체크
		if (getMember(vo.getMember_id()) != null) {
			return "아이디 중복";
		}

		// 이메일 중복 체크
		if (getMemberEmail(vo.getMember_email()) != null) {
			return "이메일 중복";
		}

		// 전화번호 중복 체크
		if (getMemberTel(vo.getMember_tel()) != null) {
			return "전화번호 중복";
		}

		// 회원가입 처리
		int result = sqlSession.insert(NAMESPACE + ".insertMember", vo);
		System.out.println(" DAO : result : " + result);
		System.out.println(" DAO : 회원가입 완료! ");

		return "회원가입 완료";
	}
	
	@Override
	public String insertCompanyMember(MemberVO vo) {
		System.out.println(" DAO : 회원가입 동작 실행! ");

		// ID 중복 체크
		if (getMember(vo.getMember_id()) != null) {
			return "아이디 중복";
		}

		// 이메일 중복 체크
		if (getMemberEmail(vo.getMember_email()) != null) {
			return "이메일 중복";
		}

		// 전화번호 중복 체크
		if (getMemberTel(vo.getMember_tel()) != null) {
			return "전화번호 중복";
		}

		// 회원가입 처리
		int result = sqlSession.insert(NAMESPACE + ".insertCompanyMember", vo);
		System.out.println(" DAO : result : " + result);
		System.out.println(" DAO : 회원가입 완료! ");

		return "회원가입 완료";
	}

	@Override
	public MemberVO loginMember(MemberVO vo) {
		System.out.println(" DAO : loginMember(MemberVO vo) 실행 ");

		// SQL 구문을 mapper에 생성
		System.out.println(" DAO : mapper SQL 생성완료. ");
		// SQL 구문 실행.
		MemberVO resultVO = sqlSession.selectOne(NAMESPACE + ".loginMember", vo);
		if(resultVO == null ) {
			return null;
		}

		System.out.println(" DAO : " + resultVO);

		return resultVO;
	}

	// 안씀
	@Override
	public MemberVO loginMember(String userid, String userpw) {
		System.out.println(" DAO : loginMember(String userid, String userpw) 실행");
		// SQL 구문을 mapper에 생성
		// SQL 구문 실행.
		// MemberVO resultVO = sqlSession.selectOne( NAMESPACE+".loginMember", userid,
		// userpw); X
		// MemberVO vo = new MemberVO();
		// vo.setUserid(userid);
		// vo.setUserpw(userpw);
		//
		// MemberVO resultVO = sqlSession.selectOne( NAMESPACE+".loginMember", vo);
		// => 전달 받은 정보를 하나의 공통객체에 저장 => 전달할때 객체로 전달

		// * userid(회원가입), userpw(게시판)는 하나의 객체(MemberVO)에
		// => 저장이 불가능하다고 가정. Ex) join구문 실행할때
		Map<String, Object> paramMap = new HashMap<String, Object>();
		// paramMap.put("mapper에서 호출하는 이름", 전달되는 값);
		paramMap.put("userid", userid);
		paramMap.put("userpw", userpw);

		MemberVO resultVO = sqlSession.selectOne(NAMESPACE + ".loginMember", paramMap);
		System.out.println(" DAO : " + resultVO);

		return resultVO;
	} // 안씀
	// 안씀

	@Override
	public MemberVO getMember(String member_id) {
		System.out.println(" DAO : getMember(String userid) ");

		return sqlSession.selectOne(NAMESPACE + ".getMemberId", member_id);
	}

	@Override
	public MemberVO getMemberEmail(String email) {
		System.out.println(" DAO : getMemberEmail(String email) ");
		return sqlSession.selectOne(NAMESPACE + ".getMemberEmail", email);
	}

	@Override
	public MemberVO getMemberTel(String tel) {
		// TODO Auto-generated method stub
		System.out.println("tel : DAO " + tel);
		return sqlSession.selectOne(NAMESPACE + ".getMemberTel", tel);
	}

	@Override
	public int updateMember(MemberVO uvo) {
		System.out.println(" DAO : updateMember(MemberVO uvo) ");
		System.out.println(uvo + "uvo");
		// mapper - sql 작성
		// sqlSession - sql 실행 (결과에 따른 정수데이터를 리턴)

		int result = sqlSession.update(NAMESPACE + ".updateMember", uvo);

		return result;
	}

	@Override
	public Integer deleteMember(MemberVO dvo) {
		System.out.println(" DAO : deleteMember(MemberVO dvo) ");
		return sqlSession.update(NAMESPACE + ".deleteMember", dvo);
	}

	// admin 회원 전체 조회.
	@Override
	public List<MemberVO> getMemberList( ) {
		System.out.println(" DAO : getMemberList() ");

		return sqlSession.selectList(NAMESPACE + ".getMemberList");

	}
	
	@Override
	public List<MemberVO> getSignupRequestList() {
		List resultList = new ArrayList();
		
			// 합쳐진 List결과를 리턴
			List resultWaitingMember = sqlSession.selectList(NAMESPACE + ".getWaitingMember");
			if(resultWaitingMember.isEmpty()) {
				return resultList;
				
			}
			List resultEmpMap = sqlSession.selectList(NAMESPACE + ".getEmp_rank", "common_value");
			List resultDeptMap = sqlSession.selectList(NAMESPACE + ".getDepartment", "department_id");
			resultList.add(resultWaitingMember);
			resultList.add(resultEmpMap);
			resultList.add(resultDeptMap);
			return resultList;

	
	}
	
	

	// admin 특정 회원 조회
	@Override
	public Map<String, Object> getMemberDetails(String member_id) {
		// 왜 map으로 사용하는지? . List로 쓰면 위의 getMemberList에도 사용할 수 있음.
		System.out.println(" DAO : getMemberDetails : " + member_id);
		Map<String, Object> commonStatuses = new HashMap<>();

		MemberVO member = sqlSession.selectOne(NAMESPACE + ".getMemberById", member_id);
		Map<String, Object> resultEmpMap = sqlSession.selectMap(NAMESPACE + ".getEmp_rank", "common_value");
		Map<String, Object> resultMemberStateMap = sqlSession.selectMap(NAMESPACE + ".getMemberState", "common_value");
		Map<String, Object> resultDeptMap = sqlSession.selectMap(NAMESPACE + ".getDepartment", "department_id");

		// List<String> result4 = sqlSession.selectList(NAMESPACE+".getApproval");

		// 결과를 map에 추가
		commonStatuses.put("member", member);
		commonStatuses.put("empRank", resultEmpMap); // 키와 값을 추가합니다.
		commonStatuses.put("memberState", resultMemberStateMap);
		commonStatuses.put("department", resultDeptMap);

//		commonStatuses.put("approval", result4);

		return commonStatuses;
	}

	// admin 회원가입신청 승인
	@Override
	public int updateMembers(List<MemberVO> memberList) {
		System.out.println("DAO: updateMembers");
		int totalUpdated = 0; // 업데이트된 총 개수 초기화

		for (MemberVO vo : memberList) {
			int result = sqlSession.update(NAMESPACE + ".UpdateMembers", vo);
			if (result > 0) {
				totalUpdated++; // 업데이트가 성공한 경우 카운트 증가
			}
		}

		return totalUpdated;
	}
	
	// admin 회원가입 신청 목록 삭제
		@Override
		public Integer deleteMembers(List<MemberVO> memberList) {
			int totalDelete = 0;
			
			
			for (MemberVO vo : memberList) {
				int result = sqlSession.delete(NAMESPACE + ".deleteMembers", vo);
				if (result > 0) {
					totalDelete++; // 업데이트가 성공한 경우 카운트 증가
				}
			}
			return totalDelete;
		}

}
