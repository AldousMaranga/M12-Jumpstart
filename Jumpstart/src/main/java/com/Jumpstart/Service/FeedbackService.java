package com.Jumpstart.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Jumpstart.Entity.Feedback;
import com.Jumpstart.Repository.FeedbackRepository;

@Service
@Transactional
public class FeedbackService {
	
	@Autowired
	FeedbackRepository feedbackRepository;
	
	public Feedback addFeedback(Feedback feedback) {
		return feedbackRepository.save(feedback);
	}

}
