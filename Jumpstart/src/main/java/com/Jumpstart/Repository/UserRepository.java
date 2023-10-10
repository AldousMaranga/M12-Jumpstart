package com.Jumpstart.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.Jumpstart.Entity.Users;

public interface UserRepository extends JpaRepository<Users, Long>{
	
	@Query(value="SELECT role_id FROM Users WHERE user_id = :user_id", nativeQuery = true)
	public String findRoleByUid(@Param("user_id")Long uid);

	
    @Query(value="SELECT * FROM users WHERE email = :email", nativeQuery = true)
    public Users findByEmail(String email);
	
	Users findByUsername(String username);
	
	@Query("SELECT u.roleId FROM Users u WHERE u.username = :username")
    public String findRoleIdByUsername(@Param("username") String username);
}
