package com.Jumpstart.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.Jumpstart.Entity.Feedback;

public interface FeedbackRepository extends JpaRepository<Feedback, Long>{
	
	@Query(value="SELECT * FROM FEEDBACK", nativeQuery = true)
	public List<Feedback> getAllFeedbacks();
}
