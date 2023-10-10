package com.Jumpstart.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Jumpstart.Entity.Product;
import com.Jumpstart.Service.ProductService;

@RestController
public class SearchController {
	@Autowired
	ProductService productService;
	
	@GetMapping("/search")
    public ResponseEntity<List<Product>> search(@RequestParam String key) {
        // Perform the search operation based on the query
        List<Product> results = productService.searchByKey(key);

        // Return the results as JSON
        return ResponseEntity.ok(results);
    }
	

}
