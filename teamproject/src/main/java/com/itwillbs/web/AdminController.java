package com.itwillbs.web;

import javax.inject.Inject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.CompanyService;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value = "/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private MemberService mService;

	@Inject
	private CompanyService cService;

	Map<String, String> response = new HashMap<>();;

	@RequestMapping(value = "adminMemberList", method = RequestMethod.GET)
	public void adminMemberListGET(Model model) {
		logger.debug("adminMemberListGET");

		List<MemberVO> memberList = mService.memberList();

		model.addAttribute("memberList", memberList);
	}

	@RequestMapping(value = "/getMemberInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> memberDetails(@RequestBody MemberVO vo) {
		Map<String, Object> memberInfo = mService.memberInfo(vo.getMember_id());

		// 결과를 ResponseEntity로 반환
		return ResponseEntity.ok(memberInfo);
	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> updateMember(@RequestBody MemberVO vo) {
		response.clear();
		logger.debug("updateMember : " + vo.getMember_id());
		int result = mService.memberUpdate(vo);

		logger.debug("성공 했을때. result : " + result);
		if (result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response);
		}
		response.put("message", "수정");
		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> deleteMember(@RequestBody MemberVO vo) {
		response.clear();

		logger.debug("updateMember : " + vo.getMember_id());
		int result = mService.memberDelete(vo);

		logger.debug("성공 했을때. result : " + result);
		if (result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response);
		}
		response.put("message", "삭제");
		return ResponseEntity.ok(response);
	}

	@RequestMapping(value = "/signReq", method = RequestMethod.GET)
	public void memberRequest(Model model) {
		logger.debug("signReq");

		List result = mService.signupRequestList();
		logger.debug("result +: " + result.isEmpty());

		if (!result.isEmpty()) {
			model.addAttribute("WaitingList", result.get(0));
			model.addAttribute("EmpList", result.get(1));
			model.addAttribute("DeptList", result.get(2));
		}

	}

	@PostMapping("/signReq")
	public ResponseEntity<String> SignRequestUpdate(@RequestBody List<MemberVO> selectedMembers) {
		logger.debug("selectMembers: " + selectedMembers);

		try {
			// 처리 로직 추가 (예: DB에 저장, 승인 처리 등)
			mService.membersUpdate(selectedMembers);

			// 성공 응답 반환
			return ResponseEntity.ok("{\"result\": true}");
		} catch (Exception e) {
			// 예외 처리
			logger.error("Error updating members", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("{\"result\": false, \"message\": \"업데이트 중 오류가 발생했습니다.\"}");
		}
	}

	@PostMapping("/signReqDelete")
	public ResponseEntity<String> SignRequestDelete(@RequestBody List<MemberVO> selectedMembers) {
		logger.debug("selectMembers: " + selectedMembers);

		try {
			// 처리 로직 추가 (예: DB에 저장, 승인 처리 등)
			mService.membersDelete(selectedMembers);

			// 성공 응답 반환
			return ResponseEntity.ok("{\"result\": true}");
		} catch (Exception e) {
			// 예외 처리
			logger.error("Error updating members", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("{\"result\": false, \"message\": \"업데이트 중 오류가 발생했습니다.\"}");
		}
	}
	
	@RequestMapping(value = "/companySignUpModal", method = RequestMethod.GET)
	public void companyList(Model model) {
		 List<CompanyVO> result = cService.getCompanyList();
		 model.addAttribute("companyList", result );
	}
	
	

	@RequestMapping(value = "/companySignUpModal", method = RequestMethod.POST)
	public ResponseEntity<CompanyVO> companySignUpGET(@RequestBody CompanyVO company_code) {
	    if (company_code == null || company_code.getCompany_code() == null) {
	        return ResponseEntity.badRequest().body(null); // 400 Bad Request
	    }

	    CompanyVO result = cService.getCompany(company_code.getCompany_code());
	    
	    if (result == null) {
	        return ResponseEntity.notFound().build(); // 404 Not Found
	    }

	    return ResponseEntity.ok(result); // 200 OK
	}

	@RequestMapping(value = "checkUserEamil", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>>  checkUserEmail(@RequestBody MemberVO email) {
		response.clear();
		logger.debug("selectMembers: " + email);

	    try {
	        MemberVO result = mService.memberEmailSearch(email.getMember_email());

	        if (result != null) {
	            // 중복된 이메일이 있을 경우
	        	response.put("message", "중복된 이메일입니다.");
	        	response.put("result", "false");
	            return ResponseEntity.ok(response);
	        } else {
	            // 사용 가능한 이메일인 경우
	        	response.put("result", "true");
	        	response.put("message", "사용 가능한 이메일입니다.");
	        	return ResponseEntity.ok(response);
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        response.put("message", "업데이트 중 오류가 발생했습니다.");
	        response.put("result", "false");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(response);
	    }
	}
	
	@RequestMapping(value = "checkUserId", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>>  checkUserId(@RequestBody MemberVO member_id) {
		response.clear();
		logger.debug("selectMembers: " + member_id);

	    try {
	        MemberVO result = mService.memberIdCheck(member_id.getMember_id());

	        if (result != null) {
	            // 중복된 이메일이 있을 경우
	        	response.put("message", "중복된 아이디입니다.");
	        	response.put("result", "false");
	            return ResponseEntity.ok(response);
	        } else {
	            // 사용 가능한 이메일인 경우
	        	response.put("result", "true");
	        	response.put("message", "사용가능한 아이디 입니다!");
	        	return ResponseEntity.ok(response);
	        }
	    } catch (Exception e) {
	        // 예외 처리
	        response.put("message", "업데이트 중 오류가 발생했습니다.");
	        response.put("result", "false");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(response);
	    }
	}
	
	@RequestMapping(value ="membersignup" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> memberSignUpPost(@RequestBody MemberVO vo) {
		response.clear();

		String result = mService.companyMemberJoin(vo);

		// 중복 체크에 대한 메시지를 매핑
		Map<String, String> messageMap = new HashMap<>();
		messageMap.put("아이디 중복", "이미 등록된 아이디입니다.");
		messageMap.put("이메일 중복", "이미 등록된 이메일입니다.");
		messageMap.put("전화번호 중복", "이미 등록된 전화번호입니다.");

		if (messageMap.containsKey(result)) {
		    response.put("message", messageMap.get(result));
		    return ResponseEntity.ok(response); // 200 OK 응답
		}

		// 회원가입 실행
		response.put("message", "회원가입이 성공적으로 완료되었습니다!");
		return ResponseEntity.ok(response); // 200 OK 응답
	}

}
