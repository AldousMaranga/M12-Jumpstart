package com.Jumpstart.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Jumpstart.Entity.Users;
import com.Jumpstart.Repository.UserRepository;

@Service
@Transactional
public class UserService {
	
	@Autowired
	UserRepository userRepository;
	
	public Users register(Users user) {
		return userRepository.save(user);
	}
	
	public Users findByUsername(String username) {
		return userRepository.findByUsername(username);
	}
}
