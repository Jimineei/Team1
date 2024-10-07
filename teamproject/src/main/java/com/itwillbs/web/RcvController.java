package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.persistence.ReceivingDAO;

@Controller
public class RcvController {

    private static final Logger logger = LoggerFactory.getLogger(RcvController.class);

    @Autowired
    private ReceivingDAO receivingDAO; // DAO �������̽� ����

    // �԰� - �԰��û������ �̵�
   //http://localhost:8080/web/rcvRQ
    @RequestMapping(value = "/rcvRQ", method = RequestMethod.GET)
    public String requestRcv() {
        logger.debug("requestRcv() ����");
        return "rcvRQ"; // JSP �� ��ȯ
    }

    @PostMapping("/web/rcvRQ")
    public void receiveRequest(@ModelAttribute ReceivingVO receivingVO) {
      
            receivingDAO.insertRcv(receivingVO); // DAO �޼��� ȣ��
            logger.debug("�԰� ��û ����");
    }
    
}