package com.Jumpstart.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.Jumpstart.Entity.Users;
import com.Jumpstart.Repository.UserRepository;
import com.Jumpstart.Service.UserService;

@Controller
public class LoginController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
    private PasswordEncoder passwordEncoder; 
	
	@GetMapping("/")
	public String landingPage() {
		return "login";
	}
	
	@GetMapping("/register_page")
	public String registerPage() {
		return "register";
	}
	
	@PostMapping("/register")
    public String registerNewUser(@ModelAttribute Users users) {
    	
		try {
			String encryptedPass = passwordEncoder.encode(users.getPassword());
			users.setPassword(encryptedPass);
			users.setRoleId(2);
	    	userService.register(users);
	    	
	    	System.out.print("Login Successful");
	    	
		} catch (Exception e) {
			System.out.print("Error: " + e);
		}

    	
    	return "redirect:/login";
    }
	
	
	@GetMapping("/login_success")
	public String loginSuccess(HttpSession session) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();

	    if (auth != null && auth.isAuthenticated()) {
	        UserDetails loggedUser = (UserDetails) auth.getPrincipal();
	        session.setAttribute("user", loggedUser);

	        String username = loggedUser.getUsername();
	        String role = userRepository.findRoleIdByUsername(username);

	        if ("1".equals(role)) {
	            return "redirect:/admin-dashboard";
	        } else if ("2".equals(role)) {
	            return "redirect:/dashboard";
	        } else {
	            return "redirect:/login_error";
	        }
	    }
	    return "redirect:/login_error";
		
//		return "redirect:/dashboard";
	}
	
	@GetMapping("login_error")
	public String onLoginError(Model model) {
	    model.addAttribute("loginError", true);
	    return "login";
	}

	
	@GetMapping("/login")
	public String loginPage() {
		return "login";
	}

	@GetMapping("/admin-dashboard")
	public String AdminDashborad() {
		return "admin-dashboard";
	}
	
	@GetMapping("/dashboard")
	public String UserDashborad() {
		return "user-dashboard";
	}

}
