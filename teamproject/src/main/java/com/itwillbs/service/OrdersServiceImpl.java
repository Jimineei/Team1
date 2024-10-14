package com.itwillbs.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.persistence.OrdersDAO;

@Service
public class OrdersServiceImpl implements OrdersService{
	
	@Autowired
	private OrdersDAO odao;
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersServiceImpl.class);
	
	
	
	
	
	
	@Override
	public int insert(OrdersVO ordersVO) {
		
		int result = odao.insert(ordersVO);
		
//		StringBuilder orderSb = new StringBuilder();
//		
//		LocalDateTime now = LocalDateTime.now();
//		
//		DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy");
//		
//		if(ordersVO.getOrd_count() == 0) {
//		orderSb.append("ord-").append(now.format(dateFormat)).append("-1");
//		} else {
//			orderSb.append("ord-").append(now.format(dateFormat)).append("-").append(ordersVO.getOrd_count());
//		}
//		
//		ordersVO.setOrd_number(orderSb.toString());
		
//		result = odao.insert(ordersVO);
		
		//orderSb.setLength(0);
		
		logger.debug("@@@@@@@@@@@@ordersVO.count:"+ordersVO.getOrd_count());
		logger.debug("@@@@@@@@@@@@ordersVO.number:"+ordersVO.getOrd_number());
		logger.debug("@@@@@@@@@@@@ordersVO.date:"+ordersVO.getOrd_date());
		logger.debug("@@@@@@@@@@@@ordersVO.prod_id:"+ordersVO.getProd_id());
		
		return result;
	}
	
	
	
	@Override
	public List<OrdersVO> listOrder() {
		
		return odao.listOrder();
	}
	
	@Override
	public void updateOrder(OrdersVO ordersVO) {
		odao.updateOrder(ordersVO);
	}
	
	
	
}
