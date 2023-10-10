package com.Jumpstart.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.Jumpstart.Entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{
	
	@Query(value="SELECT * FROM PRODUCT", nativeQuery = true)
	public List<Product> getAllProducts();
	
	@Query(value="SELECT * FROM PRODUCT WHERE product_type = 'LAPTOP'", nativeQuery = true)
	public List<Product> getAllLaptops();
	
	@Query(value="SELECT * FROM PRODUCT WHERE product_type = 'PHONE'", nativeQuery = true)
	public List<Product> getAllPhones();
	
	@Query(value="SELECT * FROM PRODUCT WHERE product_type = 'OTHERS'", nativeQuery = true)
	public List<Product> getAllOthers();
	
	@Query(value = "SELECT * FROM PRODUCT " +
		       "WHERE product_brand LIKE %:key% " +
		       "OR product_name LIKE %:key% " +
		       "OR product_type LIKE %:key%", nativeQuery = true)
	public List<Product> searchByKey(@Param("key") String key);
	
	public Product getProductByProductId(Long productId);
	
	public Product getByProductName (String productName);
	
	Product getByProductId(Long productId);

}
