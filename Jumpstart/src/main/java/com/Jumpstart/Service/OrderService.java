package com.Jumpstart.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Jumpstart.Entity.Orders;
import com.Jumpstart.Repository.OrderRepository;

@Service
@Transactional
public class OrderService {
	
	@Autowired
	OrderRepository orderRepository;
	
	public Orders addOrder(Orders order) {
		return orderRepository.save(order);
	}
	
	public Orders getOrderByOrderId (Long orderId) {
		return orderRepository.getOrderByOrderId (orderId);
	}

}
