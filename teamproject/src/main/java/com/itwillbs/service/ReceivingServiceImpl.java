package com.itwillbs.service;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.persistence.ReceivingDAO;

public class ReceivingServiceImpl implements ReceivingService  {

	// ReceivingDAO ��ü ����
	
	@Autowired 
	ReceivingDAO receivingDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingServiceImpl.class);
	
	@Override
	public void rcvRQ(ReceivingVO VO) {
		logger.debug("��Ʈ�ѷ�->����");
		logger.debug("�԰��û �޼���  rcvRQ(ReceivingVO VO) ���� ");
		
		logger.debug("����->DAO");
		receivingDAO.insertRcv(VO);
		logger.debug("DAO->����");
		logger.debug("����->��Ʈ�ѷ�");
	
		
	}

}
