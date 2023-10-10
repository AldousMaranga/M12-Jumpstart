package com.Jumpstart.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.Jumpstart.Entity.Orders;

public interface OrderRepository extends JpaRepository<Orders, Long>{
	
	@Query(value="SELECT * FROM ORDERS", nativeQuery = true)
	public List<Orders> getAllOrders();
	
	@Query(value="SELECT * FROM ORDERS WHERE status = 'ON-CART'", nativeQuery = true)
	public List<Orders> getOnCart();
	
	@Query("SELECT o FROM Orders o LEFT JOIN FETCH o.product WHERE o.userId = :userId")
	List<Orders> findByUserIdWithProduct(@Param("userId") Long userId);
	
	@Query(value="SELECT * FROM ORDERS WHERE status = 'DELIVERING'", nativeQuery = true)
	public List<Orders> getOnDelivery();
	
	@Query(value="SELECT * FROM ORDERS WHERE status = 'DELIVERED'", nativeQuery = true)
	public List<Orders> getDelivered();
	
	public Orders getOrderByOrderId(Long orderId);
	public Orders getOrderByProductId(Long productId);
}
