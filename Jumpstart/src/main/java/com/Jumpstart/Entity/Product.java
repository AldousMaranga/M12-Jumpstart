package com.Jumpstart.Entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;

@Entity
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_id")
	private Long productId;
	
	@Column(name = "product_name")
	private String productName;
	
	@Column(name = "product_type")
	private String productType;
	
	@Column(name = "product_brand")
	private String productBrand;
	
	@Column(name = "product_price")
	private Long productPrice;
	
	@Column(name = "date_added")
	private String dateAdded;
	
	@Column(name = "stockes_available")
	private Long stockesAvailable;
	
	@Lob
    @Basic(fetch = FetchType.LAZY)
    private byte[] productImage;
	
	public Product() {

	}

	public Product(Long productId, String productName, String productType, String productBrand, Long productPrice,
			String dateAdded, Long stockesAvailable, byte[] productImage) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productType = productType;
		this.productBrand = productBrand;
		this.productPrice = productPrice;
		this.dateAdded = dateAdded;
		this.stockesAvailable = stockesAvailable;
		this.productImage = productImage;
	}

	public Long getProductId() {
		return productId;
	}

	public byte[] getProductImage() {
		return productImage;
	}

	public void setProductImage(byte[] productImage) {
		this.productImage = productImage;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}

	public Long getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Long productPrice) {
		this.productPrice = productPrice;
	}

	public String getDateAdded() {
		return dateAdded;
	}

	public void setDateAdded(String dateAdded) {
		this.dateAdded = dateAdded;
	}

	public Long getStockesAvailable() {
		return stockesAvailable;
	}

	public void setStockesAvailable(Long stockesAvailable) {
		this.stockesAvailable = stockesAvailable;
	}
	
	
}
