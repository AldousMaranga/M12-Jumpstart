package com.Jumpstart.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Jumpstart.Entity.Orders;
import com.Jumpstart.Entity.Product;
import com.Jumpstart.Entity.Users;
import com.Jumpstart.Repository.OrderRepository;
import com.Jumpstart.Repository.ProductRepository;
import com.Jumpstart.Service.ProductService;
import com.Jumpstart.Service.UserService;

@RestController
@RequestMapping("/rest")
public class AjaxController {
	
	@Autowired
	ProductRepository productRepository;
	
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ProductService productService;
	
	@GetMapping("/productImage/{productId}")
	public ResponseEntity<String> getProductImage(@PathVariable Long productId) {
	    // Find the product with the specified productId
	    Product product = productRepository.getByProductId(productId);

	    if (product != null) {
	        // Get the image for the specific product
	        String base64Image = productService.getImageAsBase64(productId);
	        return new ResponseEntity<>(base64Image, HttpStatus.OK);
	    } else {
	        // Return a 404 Not Found response if the product is not found
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	}
	
	@GetMapping("/getAllProducts")
	public ResponseEntity<List<Product>> getProducts() {
		List<Product> allProducts = productRepository.getAllProducts();
		return new ResponseEntity<>(allProducts, HttpStatus.OK);
	}
	
	@GetMapping("/getLaptops")
	public ResponseEntity<List<Product>> getTheLaptops() {
		List<Product> allProducts = productRepository.getAllLaptops();
		return new ResponseEntity<>(allProducts, HttpStatus.OK);
	}
	
	@GetMapping("/getPhones")
	public ResponseEntity<List<Product>> getThePhones() {
		List<Product> allProducts = productRepository.getAllPhones();
		
		return new ResponseEntity<>(allProducts, HttpStatus.OK);
	}
	
	@GetMapping("/getOthers")
	public ResponseEntity<List<Product>> getTheOthers() {
		List<Product> allProducts = productRepository.getAllOthers();
		
		return new ResponseEntity<>(allProducts, HttpStatus.OK);
	}
	
	@GetMapping("/getCart")
	public ResponseEntity<List<Orders>> getCart() {
		Authentication authenticate = SecurityContextHolder.getContext().getAuthentication();
		
		if (authenticate != null && authenticate.isAuthenticated()) {
			String username = authenticate.getName();
			Users user = userService.findByUsername(username);	
			Long userId = user.getUserId();
			
			List<Orders> allOrders = orderRepository.getOnCart();
			List<Orders> userCart = new ArrayList<>();
			
			for (Orders order: allOrders) {
				if(order.getUserId().equals(userId)) {
					userCart.add(order);
				}
			}
			
			return new ResponseEntity<>(userCart, HttpStatus.OK);
			
		}
		return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	}
	
	@GetMapping("/getDelivery")
	public ResponseEntity<List<Orders>> getDelivery() {
		List<Orders> delivery = orderRepository.getOnDelivery();
		return new ResponseEntity<>(delivery, HttpStatus.OK);
	}
	
	@GetMapping("/getDelivered")
	public ResponseEntity<List<Orders>> getDelivered() {
		Authentication authenticate = SecurityContextHolder.getContext().getAuthentication();
		
		if (authenticate != null && authenticate.isAuthenticated()) {
			String username = authenticate.getName();
			Users user = userService.findByUsername(username);	
			Long userId = user.getUserId();
			
			List<Orders> allOrders = orderRepository.getDelivered();
			List<Orders> userCart = new ArrayList<>();
			
			for (Orders order: allOrders) {
				if(order.getUserId().equals(userId)) {
					userCart.add(order);
				}
			}
			
			return new ResponseEntity<>(userCart, HttpStatus.OK);
			
		}
		return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	}
}
