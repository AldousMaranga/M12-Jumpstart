<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Admin!</title>
	
	<style>
		.bg-dark{
			background-color: black;
			font-size: 20px;
			min-height: 100vh;
		}
		
		.white-font{
			color: white;
		}
		
		.product-container {
		    width: 100%;
		    margin-bottom: 25px;
		    padding: 20px;
		    border: 1px solid #54566A;
		    background-color: #54566A;
		    text-align: center;
		    color: white;
		    border-radius: 20px;
		}

	</style>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		$(document).ready(function() {
			function fetchOnDelivery() {
				$.ajax({
					type: 'GET',
					url: 'rest/getDelivery',
					dataType: 'json',
					success: function(response) {
						displayDeliveryt(response);
					},
					error: function(error) {
						console.error('Error fetching buil mail: ', error);
					}
				});
			}
			
			function displayDeliveryt(deliveryOrder) {
				var container = $("#deliveryContainer");
				
				container.empty();
				
				$.each(deliveryOrder, function(index, orders) {
					var deliveryContainer = $("<div>").addClass("product-container");
					
					 var image = $("<img>")
				        .attr("src", "https://www.asus.com/media/Odin/Websites/global/Series/12.png")
				        .attr("width", "100%")
				        .attr("height", "auto")
				        .attr("alt", "laptop");

				    var imageContainer = $("<div>")
				        .append(image);
				    
					var name = $("<h3>").text(orders.productBrand + " " + orders.productName);
					var price = $("<h5>").text("Total Price: " + orders.totalPayment);
					var productQuantity = $("<p>").text("Quantity: " + orders.quantity);
					var customer = $("<p>").text("Customer: " + orders.email);

					
					var deliverButton = $("<button>").addClass("btn btn-primary").text("Delivered");
					deliverButton.on("click", function() {
						var orderId = orders.orderId;
						
						$.ajax({
							type: 'PUT',
							url: '/delivered/' + orderId,
							success: function(response) {
								console.log("Order Delivered");
								window.alert("Order Delivered");
								location.reload(); // Reload the page after successful update
							},
							error: function(error) {
								console.error(error);
							}
						})
					});
					
					var detailsContainer = $("<div>").append(name, price, productQuantity, customer, deliverButton);
					
					deliveryContainer.append(imageContainer, detailsContainer);
					
					var styleContainer = $("<div class='mail-card'>").append(deliveryContainer);
					
					container.append(styleContainer);
				});
			} 
			fetchOnDelivery();
		});
	</script>
	
	<script>
		$(document).ready(function() {
			function fetchProducts() {
				$.ajax({
					type: 'GET',
					url: '/rest/getAllProducts',
					dataType: 'json',
					success: function(response) {
						displayProducts(response);
					},
					error: function(error) {
						console.error('Error Details:', error);
					}
				});
			}
			
			function displayProducts(products) {
			    var container = $("#productContainer").addClass("table-responsive");
			    container.empty();

			    // Create a table element
			    var productTable = $("<table class='table table-bordered'>");

			    // Create a table header row
			    var headerRow = $("<thead class='mb-3'>").append(
			            $("<tr>").append(
			            $("<th>").text("Product Name"),
			            $("<th>").text("Product Brand"),
			            $("<th>").text("Product Type"),
			            $("<th>").text("Product Price"),
			            $("<th>").text("Quantity"),
			            $("<th>").text("Action")
			            )
			        );

			    var tbody = $("<tbody>");

			    $.each(products, function(index, product) {
			        // Create a new table row for each product
			        var productContainer = $("<tr class='product-container'>");

			        var name = $("<td class='align-middle'>").text(product.productName);
			        var brand = $("<td class='align-middle'>").text(product.productBrand);
			        var type = $("<td class='align-middle'>").text(product.productType);
			        var price = $("<td class='align-middle'>").text("$" + product.productPrice);
			        var quantity = $("<td class='align-middle'>").text(product.stockesAvailable);

			        var productIdInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productId); // Set the value to the productId
		            
			        var cartButton = $("<button>").addClass("btn btn-danger").text("Delete");

			        cartButton.on("click", function() {
			        	var productId = productIdInput.val();
			            console.log("Clicked Add to Cart for productId: " + productId);

			            $.ajax({
			                type: 'DELETE',
			                url: '/deleteProduct/' + productId,
			                data: {productId : productId},
			                success: function(response) {
			                    console.log("Product deleted successfully");
			                    window.alert("Product Deleted");
			                    window.location.href = '/admin-dashboard';
			                },
			                error: function(error) {
			                    window.alert("There is an error on deleting product");
			                    console.error('Error Details:', error);
			                }
			            });
			        });
			        
			        var deleteButton = $("<td class='align-middle'>").append(cartButton);
			        // Append each <td> element to the current product row
			        productContainer.append(name, brand, type, price, quantity, productIdInput, deleteButton);
			        tbody.append(productContainer);

			        // Append the product row to the table
			        productTable.append(headerRow, tbody);
			    });

			    container.append(productTable);
			}




			
			fetchProducts();
		})
	</script>
	
	
</head>
<body>
<%@ include file="admin-header.jsp" %>

<div class="bg-dark">
	<div class="container">
		<button type="submit" class="btn btn-primary mt-3 mb-3" data-bs-toggle="modal" data-bs-target="#product">Add Products</button>
		
			
		<form action="addProduct" method="post" class="was-validated" enctype="multipart/form-data">
		<!-- enctype="multipart/form-data" -->
			<div class="modal fade" id="product" style="z-index: 2000;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">Product Details</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="text" class="form-control" id="product_name" name="productName" placeholder="Name" required>
							<select class="form-select" id="product_type" name="productType" required>
								<option selected disabled>Choose Type of Product</option>
							    <option value="LAPTOP">Laptop</option>
							    <option value="PHONE">Cellphone</option>
							    <option value="OTHERS">Others</option>
							</select>
							
							<input type="text" class="form-control" id="product_brand" name="productBrand" placeholder="Brand" required>
							<input type="number" class="form-control" id="product_price" name="productPrice" placeholder="Price" required>
							<input type="number" class="form-control" id="stockes_available" name="stockesAvailable" placeholder="Number of Items" required>

							<input type="file" class="form-control" id="productImage" name="productImage"  required> 
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" type="submit">Submit</button>
						</div>
					</div>
				</div>	
			</div>
	    </form>
	    
	    <div class="row">
	    	<div class="col-lg-9 col-md-12">
	    		<div class="product-container">
	    			<h2 class="mb-2">List of Products</h2>
	    			<div id="productContainer"></div>
	    		</div>
	    	</div>
	    	<div class="col-lg-3 col-md-12">
	    		<div id="deliveryContainer"></div>
	    	</div>
	    </div>
	    	    
	</div>
</div>
</body>
</html>