package com.Jumpstart.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;

import com.Jumpstart.Entity.Feedback;
import com.Jumpstart.Entity.Product;
import com.Jumpstart.Entity.Users;
import com.Jumpstart.Repository.OrderRepository;
import com.Jumpstart.Repository.ProductRepository;
import com.Jumpstart.Service.FeedbackService;
import com.Jumpstart.Service.OrderService;
import com.Jumpstart.Service.ProductService;
import com.Jumpstart.Service.UserService;

@Controller
public class ProductController {
	
	@Autowired
	ProductRepository productRepository;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	FeedbackService feedbackService;
	
	//views

	
	@GetMapping("/contactUs")
	public String customerFeedback() {
		return "contact";
	}
	
	@GetMapping("/searchPage")
	public String searchPage() {
		return "search";
	}
	
	@PostMapping("/addProduct")
	public String registerProduct(@RequestParam String productName, 
			@RequestParam String productBrand, 
//			@RequestParam("productImage") MultipartFile productImage,
			@RequestParam String productType,
			@RequestParam Long productPrice,
			@RequestParam Long stockesAvailable,
			@RequestParam MultipartFile productImage
			) throws IOException {
	    
		Product product = new Product();
		
		product.setProductBrand(productBrand);
		product.setProductType(productType);
		product.setProductPrice(productPrice);
		product.setProductName(productName);
		product.setStockesAvailable(stockesAvailable);
		product.setProductImage(productImage.getBytes());

	    product.setDateAdded(java.time.LocalDate.now().toString());
	    productService.saveProduct(product); // Save the product and get the saved entity
	    
//	    Product name = productRepository.getByProductName(product.getProductName());
//	    productService.uploadProfileImg(name.getProductId(), productImage);
	    return "redirect:/admin-dashboard";
	}
	
	//User add feedback
	@PostMapping("/addFeedback")
	public String messageUs(@ModelAttribute("order") Feedback feedback, 
			@RequestParam String feedbackBody) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		String username = authentication.getName();
		
		Users user = userService.findByUsername(username);
		String name = user.getName();
		String email = user.getEmail();
		Long userId = user.getUserId();
		
		feedback.setName(name);
    	feedback.setEmail(email);
    	feedback.setUserId(userId);
    	feedbackService.addFeedback(feedback);
        System.out.print("Feedback Saved");

	    return "redirect:/dashboard";
	}
	
	@DeleteMapping("/deleteProduct/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable Long productId) {

		Product product = productRepository.getProductByProductId(productId);
		productRepository.delete(product);
		
        return ResponseEntity.ok("Product with ID " + productId + " deleted successfully");
    }
}
