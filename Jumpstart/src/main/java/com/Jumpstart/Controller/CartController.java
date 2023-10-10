package com.Jumpstart.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Jumpstart.Entity.Orders;
import com.Jumpstart.Entity.Users;
import com.Jumpstart.Repository.OrderRepository;
import com.Jumpstart.Service.OrderService;
import com.Jumpstart.Service.UserService;

@Controller
public class CartController {

	@Autowired
	OrderService orderService;

	@Autowired
	UserService userService;

	@Autowired
	OrderRepository orderRepository;

	@GetMapping("/cart")
	public String cartPage() {
		return "cart";
	}

	// User add product to cart
	@PostMapping("/addToCart")
	public String cart(@ModelAttribute("order") Orders order, @RequestParam("productId") Long productId,
			@RequestParam String productBrand, @RequestParam String productName, @RequestParam Long productPrice, @RequestParam Long stockesAvailable) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			String username = authentication.getName(); // Get the username
			// Retrieve the user from the database based on the username and obtain the
			Users user = userService.findByUsername(username);
			Long userId = user.getUserId();
			String email = user.getEmail();

			try {
				order.setProductBrand(productBrand);
				order.setProductName(productName);
				order.setProductPrice(productPrice);
				order.setUserId(userId);
				order.setEmail(email);
				order.setProductId(productId);
				order.setStatus("ON-CART");
				order.setStockesAvailable(stockesAvailable);
				order.setDateOrdered(java.time.LocalDate.now().toString());
				orderService.addOrder(order);
				System.out.print("Order Saved");
			} catch (Exception e) {
				System.out.print(e);
			}
		}

		return "redirect:/cart";
	}

	@PutMapping("/payment/{orderId}")
	public ResponseEntity<String> pay(@PathVariable Long orderId, @RequestParam String accountNumber, 
			@RequestParam String paymentType, 
			@RequestParam Long productPrice, 
			@RequestParam Long quantity) {

		Orders order = orderService.getOrderByOrderId(orderId);
		
		Long totalPayment = productPrice * quantity;
		
		if(order != null) {
			if("ON-CART".equals(order.getStatus())) {
				order.setAccountNumber(accountNumber);
				order.setPaymentType(paymentType);
				order.setTotalPayment(totalPayment);
				order.setQuantity(quantity);
				order.setStatus("DELIVERING");
				orderRepository.save(order);
			}
		}

		return new ResponseEntity<>(HttpStatus.OK);
	}

	// Admin set product to delivered
	@PutMapping("/delivered/{orderId}")
	public ResponseEntity<String> updateToDelivered(@PathVariable Long orderId) {
		// Retrieve the order by orderId
		Orders order = orderService.getOrderByOrderId(orderId);

		if (order == null) {
			// Handle the case where the order with the given orderId is not found
			return new ResponseEntity<>("Order not found", HttpStatus.NOT_FOUND);
		}

		// Check if the current status is "ON-CART"
		if ("DELIVERING".equals(order.getStatus())) {
			// Update the status to "DELIVERY"
			order.setStatus("DELIVERED");

			// Save the updated order
			orderService.addOrder(order);

			return new ResponseEntity<>("Order status updated to DELIVERED", HttpStatus.OK);
		} else {
			// Handle the case where the status is not "ON-CART"
			return new ResponseEntity<>("Order status cannot be updated", HttpStatus.BAD_REQUEST);
		}
	}
	
	

	@DeleteMapping("/deleteOrder/{orderId}")
	public ResponseEntity<String> deleteOrder(@PathVariable Long orderId) {

		Orders order = orderRepository.getOrderByOrderId(orderId);
		orderRepository.delete(order);

		return ResponseEntity.ok("Order with ID " + orderId + " deleted successfully");
	}

}
