package com.itwillbs.web;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.MemberService;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private MemberService mService;

	@RequestMapping(value = "adminMemberList", method = RequestMethod.GET)
	public void adminMemberListGET(Model model) {
		logger.debug("adminMemberListGET");

		List<MemberVO> memberList = mService.memberList();

		model.addAttribute("memberList", memberList);
	}

	@RequestMapping(value = "getMemberInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> memberDetails(@RequestBody MemberVO vo) {
		 Map<String, Object> memberInfo = mService.memberInfo(vo.getMember_id());

		 // 결과를 ResponseEntity로 반환
		 return ResponseEntity.ok(memberInfo);
	}
}
