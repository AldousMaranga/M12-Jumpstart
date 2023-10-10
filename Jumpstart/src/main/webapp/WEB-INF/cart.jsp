<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
</head>
	<style>
		.bg-dark{
			background-color: black;
			font-size: 20px;
			min-height: 100vh;
		}
		
		.white-font{
			color: white;
		}
		
		.cart-order-container {
		    width: 100%;
		    margin-bottom: 25px;
		    padding: 20px;
		    border: 1px solid #54566A;
		    background-color: #54566A;
		    border-radius: 20px;
		    text-align: center;
		    color: white;
		}

	</style>

	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		$(document).ready(function() {
			function fetchOnCart() {
				$.ajax({
					type: 'GET',
					url: 'rest/getCart',
					dataType: 'json',
					success: function(response) {
						displayOnCart(response);
					},
					error: function(error) {
						console.error('Error fetching buil mail: ', error);
					}
				});
			}
			
			var productIdInput;
			
			function displayOnCart(cartOrder) {
				var container = $("#cartContainer");

				container.empty();

				$.each(cartOrder, function(index, orders) {
				    var cartContainer = $("<div>").addClass("row align-items-center");

				    var imageId = "productImage_" + orders.productId;

			        var image = $("<img>")
			        	.attr("src", "")
			        	.attr("id", imageId)
			        	.attr("width", "100%")
			        	.attr("height", "auto")
			        	.attr("alt", "laptop");

				    var imageContainer = $("<div>")
				        .addClass("col-md-6 col-xs-12") // Bootstrap class to occupy half of the container width
				        .append(image);

				    var name = $("<h3>").text(orders.productBrand + " " + orders.productName);
				    var price = $("<h5>").text("Price: $" + orders.productPrice);
				    
				    var quantity = $("<h5>").text("Stockes Available: " + orders.stockesAvailable)

				    var orderButton = $("<button>")
				        .addClass("btn btn-primary")
				        .text("Order");
				    function getImage() {
		        		var productId = productIdInput.val();

		        		console.log("Image Product Id: " + productId);
		        		
		        		$.ajax({
				            type: 'GET',
				            url: '/rest/productImage/' + productId, // Use the new mapping
				            dataType: 'text',
				            success: function (base64Image) {
				                if (base64Image) {
				                	console.log(base64Image);
				                    // Set the src attribute of the img element with the Base64 image data
				                    $("#" + imageId).attr("src", "data:image/jpeg;base64," + base64Image); // Change the MIME type if needed
				                }
				            },
				            error: function (error) {
				                console.error('Error Details:', error);
				            }
				        });
		        	}

				    orderButton.on("click", function() {
				 		var orderId = orders.orderId;
				    	var productId = orders.productId;
				    	var productPrice = orders.productPrice;
				        console.log("Quantity: " + productPrice);
				       
						$("#paypalProductId").val(productId);
						$("#gcashProductId").val(productId);
						$("#codProductId").val(productId);
						
						$("#paypalProductPrice").val(productPrice);
						$("#gcashProductPrice").val(productPrice);
						$("#codProductPrice").val(productPrice);
						
						$("#paypalOrderId").val(orderId);
						$("#gcashOrderId").val(orderId);
						$("#codOrderId").val(orderId);
				        
				        $('#orderModal').modal('show');

				    });

				    var detailsContainer = $("<div>")
				        .addClass("col-md-6 col-xs-12") // Bootstrap class to occupy half of the container width
				        .append(name, price, quantity, orderButton);

				    cartContainer.append(imageContainer, detailsContainer);

				    var styleContainer = $("<div class='cart-order-container'>").append(cartContainer);

				    container.append(styleContainer);
				});

			} 
			fetchOnCart();
		});
	</script>
	
	<script>
		$(document).ready(function() {
			function fetchOnDelivered() {
				$.ajax({
					type: 'GET',
					url: 'rest/getDelivered',
					dataType: 'json',
					success: function(response) {
						displayDelivered(response);
					},
					error: function(error) {
						console.error('Error fetching buil mail: ', error);
					}
				});
			}
			
			function displayDelivered(deliveredOrder) {
				var container = $("#deliveredContainer");

				container.empty();

				$.each(deliveredOrder, function(index, orders) {
				    var cartContainer = $("<div>").addClass("align-items-center");

				    var image = $("<img>")
				        .attr("src", "https://www.asus.com/media/Odin/Websites/global/Series/12.png")
				        .attr("width", "100%")
				        .attr("height", "auto")
				        .attr("alt", "laptop");

				    var imageContainer = $("<div>")
				        .append(image);

				    var name = $("<h3>").text(orders.productBrand + " " + orders.productName);
				    var price = $("<h5>").text("Price: " + orders.productPrice);
					
				    var productQuantity = $("<h5>").text("Quantity: " + orders.quantity);
				   /*
				    var productQuantity = $("<input>")
				        .addClass("form-control mb-3")
				        .attr("type", "number")
				        .attr("name", "quantity")
				        .attr("id", "quantity")
				        .attr("min", "1")
				        .val(orders.quantity);*/

				    var orderButton = $("<button>")
				        .addClass("btn btn-success")
				        .text("Order Received");

				    orderButton.on("click", function() {
				        var quantity = productQuantity.val();
				        var orderId = orders.orderId;
				        console.log("Quantity: " + quantity);

				        $.ajax({
				            type: 'DELETE',
				            url: '/deleteOrder/' + orderId,
				            data: {quantity: quantity},
				            success: function(response) {
				                console.log("Order Deleted");
				                window.alert("Thank you for your purchase!");
				                location.reload(); // Reload the page after successful update
				            },
				            error: function(error) {
				            	window.alert("Order not deleted");
				                console.error(error);
				            }
				        });
				    });

				    var detailsContainer = $("<div>")
				        .append(name, price, productQuantity, orderButton);

				    cartContainer.append(imageContainer, detailsContainer);

				    var styleContainer = $("<div class='cart-order-container'>").append(cartContainer);

				    container.append(styleContainer);
				});

			} 
			fetchOnDelivered();
		});
	</script>
	
<body>
<%@ include file="header.jsp" %>
<div class="bg-dark">
	<div class="container pt-4">
		<div class="row">
			<div class="col-md-9 col-xs-12">
				<div class="cart-order-container">
					<h2>Products on Cart</h2>
					<hr>
				</div>
				<div id="cartContainer"></div>	
			</div>
			
			<div class="col-md-3 col-xs-12">
				<div class="cart-order-container">
					<h2>Delivered Orders</h2>
					<hr>
				</div>
				<div id="deliveredContainer"></div>	
			</div>
		</div>
			
			<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="true">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="orderModalLabel">Place Your Order</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body" id="modalBody">
			               <select class="form-select mb-3" id="payment_type" name="paymentType" required onchange="showPaymentFields()">
							    <option selected disabled>Payment Type</option>
							    <option value="PAYPAL">Paypal</option>
							    <option value="GCASH">G-Cash</option>
							    <option value="COD">Cash on Delivery</option>
							</select>
							
							<!-- Input fields for different payment methods -->
							<form action="payment" method="post" class="was-validated" id="paypalPayment">
								<div id="paypalField" style="display: none;">
									<input type="text" class="form-control mb-3" id="paypal" name="accountNumber" placeholder="Paypal Account Number" required>
									<input class="form-control mb-3" type="number" name="quantity" id="pquantity" min="1" value="1">
									<input type="hidden" name="paymentType" id="ptype" value="PAYPAL">
									<input type="hidden" name="productId" id="paypalProductId" >
									<input type="hidden" name="productPrice" id="paypalProductPrice" >
									<input type="hidden" name="orderId" id="paypalOrderId" >
									<button type="submit" class="btn btn-primary" id="forDeliver">Place Order</button>
								</div>
							</form>
							<script>
							// Intercept the form submission to PUT mapping
							$('#paypalPayment').submit(function (event) {
							    event.preventDefault(); // Prevent the default form submission
							    
							    // Extract form data
							    var accountNumber = $('#paypal').val();
							    var quantity = $('#pquantity').val();
							    var paymentType = $('#ptype').val();
							    var productId = $('#paypalProductId').val();
							    var productPrice = $('#paypalProductPrice').val();
							    var orderId = $('#paypalOrderId').val();

							    // Send a PUT request using AJAX
							    $.ajax({
							        type: 'PUT',
							        url: '/payment/' + orderId, // Replace with your actual PUT endpoint
							        data: {accountNumber: accountNumber,
							        		quantity: quantity,
							        		paymentType: paymentType,
							        		productId: productId,
							        		productPrice: productPrice},

							        success: function (response) {
							            console.log("PUT request successful:", response);
							            window.alert("Payment Successful!");
							            window.location.href = '/cart';
							            // Handle success response here
							        },
							        error: function (error) {
							            console.error("PUT request failed:", error);
							            // Handle error here
							        }
							    });
							});
							</script>
							
							
							<form action="payment" method="post" class="was-validated" id="gcashPayment">
								<div id="gcashField" style="display: none;">
								    <input type="text" class="form-control mb-3" id="gcash" name="accountNumber" placeholder="G-Cash Account Number" required>
								    <input class="form-control mb-3" type="number" name="quantity" id="gquantity" min="1" value="1">
								    <input type="hidden" name="paymentType" id="gpayment" value="GCASH">
								    <input type="hidden" name="productId" id="gcashProductId" >
								    <input type="hidden" name="productPrice" id="gcashProductPrice" >
								    <input type="hidden" name="orderId" id="gcashOrderId" >
								    <button type="submit" class="btn btn-primary">Place Order</button>
								</div>
							</form>
							<script>
							// Intercept the form submission to PUT mapping
							$('#gcashPayment').submit(function (event) {
							    event.preventDefault(); // Prevent the default form submission
							    
							    // Extract form data
							    var accountNumber = $('#gcash').val();
							    var quantity = $('#gquantity').val();
							    var paymentType = $('#gpayment').val();
							    var productId = $('#gcashProductId').val();
							    var productPrice = $('#gcashProductPrice').val();
							    var orderId = $('#gcashOrderId').val();

							    // Send a PUT request using AJAX
							    $.ajax({
							        type: 'PUT',
							        url: '/payment/' + orderId, // Replace with your actual PUT endpoint
							        data: {accountNumber: accountNumber,
							        		quantity: quantity,
							        		paymentType: paymentType,
							        		productId: productId,
							        		productPrice: productPrice},

							        success: function (response) {
							            console.log("PUT request successful:", response);
							            window.alert("Payment Successful!");
							            window.location.href = '/cart';
							            // Handle success response here
							        },
							        error: function (error) {
							            console.error("PUT request failed:", error);
							            // Handle error here
							        }
							    });
							});
							</script>
							
							
							<form action="payment" method="post" class="was-validated" id="codPayment">
								<div id="codField" style="display: none;">
								    <input class="form-control mb-3" type="number" name="quantity" id="cquantity" min="1" value="1">
									<input type="hidden" name="paymentType" id="codpayment" value="GCASH">
									<input type="hidden" name="productId" id="codProductId" >
									<input type="hidden" name="productPrice" id="codProductPrice" >
									<input type="hidden" name="accountNumber" id="cod" value="NULL" >
									<input type="hidden" name="orderId" id="codOrderId" >
									<button type="submit" class="btn btn-primary">Place Order</button>
								</div>
							</form>
							<script>
							// Intercept the form submission to PUT mapping
							$('#codPayment').submit(function (event) {
							    event.preventDefault(); // Prevent the default form submission
							    
							    // Extract form data
							    var accountNumber = $('#cod').val();
							    var quantity = $('#cquantity').val();
							    var paymentType = $('#codpayment').val();
							    var productId = $('#codProductId').val();
							    var productPrice = $('#codProductPrice').val();
							    var orderId = $('#codOrderId').val();

							    // Send a PUT request using AJAX
							    $.ajax({
							        type: 'PUT',
							        url: '/payment/' + orderId, // Replace with your actual PUT endpoint
							        data: {accountNumber: accountNumber,
							        		quantity: quantity,
							        		paymentType: paymentType,
							        		productId: productId,
							        		productPrice: productPrice},

							        success: function (response) {
							            console.log("PUT request successful:", response);
							            window.alert("Payment Successful!");
							            window.location.href = '/cart';
							            // Handle success response here
							        },
							        error: function (error) {
							            console.error("PUT request failed:", error);
							            // Handle error here
							        }
							    });
							});
							</script>
							
							<!-- Script for showing different payment methods -->
							<script>
							function showPaymentFields() {
							    var selectedOption = document.getElementById("payment_type").value;
							
							    // Hide all payment fields
							    document.getElementById("paypalField").style.display = "none";
							    document.getElementById("gcashField").style.display = "none";
							    document.getElementById("codField").style.display = "none";
							
							    // Show fields based on the selected option
							    if (selectedOption === "PAYPAL") {
							        document.getElementById("paypalField").style.display = "block";
							    } else if (selectedOption === "GCASH") {
							        document.getElementById("gcashField").style.display = "block";
							    } else if (selectedOption === "COD") {
							        document.getElementById("codField").style.display = "block";
							    }
							}
							</script>
	
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			            </div>
			        </div>
			    </div>
			</div>
		
	</div>
</div>
</body>
</html>