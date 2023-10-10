package com.Jumpstart.Service;

import java.util.Base64;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Jumpstart.Entity.Product;
import com.Jumpstart.Repository.ProductRepository;

@Service
@Transactional
public class ProductService {
	
	@Autowired
	ProductRepository productRepository;
	
	public Product saveProduct(Product product) {
		return productRepository.save(product);
	}
	
	public List<Product> searchByKey(String key) {
		return productRepository.searchByKey(key);
	}
	
	public String getImageAsBase64(Long productId) {
		Product product = productRepository.getByProductId(productId);
		
		byte[] productImage = product.getProductImage();
		if (productImage != null && productImage.length > 0) {
			return Base64.getEncoder().encodeToString(productImage);
		}
		
		return "";
	}



}
