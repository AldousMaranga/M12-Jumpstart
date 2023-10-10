package com.Jumpstart.Entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Entity
public class Orders {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id")
	private Long orderId;
	
	@Column(name = "user_id")
	private Long userId;
	
	@Column(name = "product_id")
	private Long productId;
	
	@Column(name = "quantity")
	private Long quantity;
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "date_ordered")
	private String dateOrdered;
	
	@Column(name = "email")
	private String email;
	
	@Column(name = "product_brand")
	private String productBrand;
	
	@Column(name = "product_name")
	private String productName;
	
	@Column(name = "product_price")
	private Long productPrice;
	
	@Column(name = "stockes_available")
	private Long stockesAvailable; 
	
	@Column(name = "total_payment")
	private Long totalPayment;
	
	@Column(name = "payment_type")
	private String paymentType;
	
	@Column(name = "account_number")
	private String accountNumber;
	
	@OneToOne(fetch = FetchType.EAGER, optional=false)
	@JoinColumn(name = "product_id", referencedColumnName = "product_id", insertable=false, updatable=false)
	private Product product;
	
	public Orders() {

	}
	

	public Orders(Long orderId, Long userId, Long productId, Long quantity, String status, String dateOrdered,
			String email, String productBrand, String productName, Long productPrice, Long stockesAvailable,
			Long totalPayment, String paymentType, String accountNumber) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.productId = productId;
		this.quantity = quantity;
		this.status = status;
		this.dateOrdered = dateOrdered;
		this.email = email;
		this.productBrand = productBrand;
		this.productName = productName;
		this.productPrice = productPrice;
		this.stockesAvailable = stockesAvailable;
		this.totalPayment = totalPayment;
		this.paymentType = paymentType;
		this.accountNumber = accountNumber;
	}


	public Long getOrderId() {
		return orderId;
	}


	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}


	public Long getUserId() {
		return userId;
	}


	public void setUserId(Long userId) {
		this.userId = userId;
	}


	public Long getProductId() {
		return productId;
	}


	public void setProductId(Long productId) {
		this.productId = productId;
	}


	public Long getQuantity() {
		return quantity;
	}


	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getDateOrdered() {
		return dateOrdered;
	}


	public void setDateOrdered(String dateOrdered) {
		this.dateOrdered = dateOrdered;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getProductBrand() {
		return productBrand;
	}


	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public Long getProductPrice() {
		return productPrice;
	}


	public void setProductPrice(Long productPrice) {
		this.productPrice = productPrice;
	}


	public Long getStockesAvailable() {
		return stockesAvailable;
	}


	public void setStockesAvailable(Long stockesAvailable) {
		this.stockesAvailable = stockesAvailable;
	}


	public Long getTotalPayment() {
		return totalPayment;
	}


	public void setTotalPayment(Long totalPayment) {
		this.totalPayment = totalPayment;
	}


	public String getPaymentType() {
		return paymentType;
	}


	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}


	public String getAccountNumber() {
		return accountNumber;
	}


	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	

}
