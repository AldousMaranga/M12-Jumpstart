<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Jumpstart</title>

	<style>
		.bg-dark{
			background-color: black;
			font-size: 26px;
			min-height: 100vh;
		}
		
		.white-font{
			color: white;
		}
		
		.user-dashboard {
		    /* Add your desired styles here */
		    /* For example, you can set width, margin, padding, etc. */
		    width: 100%;
		    margin-bottom: 25px;
		    padding: 20px;
		    border: 1px solid #54566A;
		    background-color: #54566A;
		    border-radius: 20px;
		    text-align: center;
		    color: white;
		    /* You can add more styles to customize the appearance */
		}
		
		/* Style for the outer container, if needed */
		#productContainer {
		    /* Add your desired styles here */
		    /* For example, you can set a maximum width, overflow, etc. */
		    max-width: 100%;
		    overflow-x: auto; /* Horizontal scrolling if products overflow the container */
		}
		
		.product-container::after {
		    content: "";
		    display: table;
		    clear: both;
		}
	</style>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		$(document).ready(function() {
			function fetchProducts() {
				$.ajax({
					type: 'GET',
					url: '/rest/getLaptops',
					dataType: 'json',
					success: function(response) {
						displayProducts(response);
					},
					error: function(error) {
						console.error('Error Details:', error);
					}
				});
			}
			
			var productIdInput;

			function displayProducts(products) {
			    var container = $("#laptopContainer");
			    container.empty();
			
			    $.each(products, function(index, product) {
			        var productContainer = $("<div>").addClass("user-dashboard");
			        
			        var imageId = "productImage_" + product.productId;

			        var image = $("<img>")
			        	.attr("src", "")
			        	.attr("id", imageId)
			        	.attr("width", "100%")
			        	.attr("height", "auto")
			        	.attr("alt", "laptop");

			        
			        var details = $("<h3>").text(product.productBrand + " " + product.productName);
			        var type = $("<p>").text(product.productType);
			        var price = $("<p>").text("$" + product.productPrice);

			        // Create a hidden input field for productId
			        productIdInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productId); // Set the value to the productId
			            
			        var productBrandInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productBrand); // Set the value to the productId
			            
			        getImage(product.productId);
			            
			        var productNameInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productName); // Set the value to the productId
			            
			        var productPriceInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productPrice); // Set the value to the productId
			            
			        var stockAvailableInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "stockesAvailable") // Set a name for the input field
			            .val(product.stockesAvailable); // Set the value to the productId 

			        var cartButton = $("<button>").addClass("btn btn-info").text("Add to Cart");
			        
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
			        
			        cartButton.on("click", function() {
			            var productId = productIdInput.val();
			            var productBrand = productBrandInput.val();
			            var productName = productNameInput.val();
			            var productPrice = productPriceInput.val();
			            var stockesAvailable = stockAvailableInput.val();
			            console.log("Clicked Add to Cart for productId: " + productId);
			            
			            $.ajax({
			                type: 'POST',
			                url: '/addToCart',
			                data: { productId: productId ,
			                		productBrand: productBrand,
			                		productName: productName,
			                		productPrice: productPrice,
			                		stockesAvailable: stockesAvailable}, // Send productId in the request
			                success: function(response) {
			                    // Handle the success response if needed
			                    console.log(productId + " " + productBrand + " " + productName + " " + productPrice);
			                    window.alert("Added Successfully! Redirecting to your cart");
			                    window.location.href = '/cart';
			                },
			                error: function(error) {
			                	window.alert("There is an error on adding product to cart");
			                    console.error('Error Details:', error);
			                }
			            });
			        });
					
			        
			        productContainer.append(image, details, type, price, productIdInput, productBrandInput, productNameInput, productPriceInput, cartButton);

			        var styleContainer = $("<div class='mail-card'>").append(productContainer);
			        container.append(styleContainer);
			    });
			}	
			fetchProducts();
		})
	</script>
	
	<script>
		$(document).ready(function() {
			function fetchProducts() {
				$.ajax({
					type: 'GET',
					url: '/rest/getPhones',
					dataType: 'json',
					success: function(response) {
						displayProducts(response);
					},
					error: function(error) {
						console.error('Error Details:', error);
					}
				});
			}
			
			var productIdInput;

			function displayProducts(products) {
			    var container = $("#phoneContainer");
			    container.empty();
			
			    $.each(products, function(index, product) {
			        var productContainer = $("<div>").addClass("user-dashboard");
			        
			        var imageId = "productImage_" + product.productId;

			        var image = $("<img>")
			        	.attr("src", "")
			        	.attr("id", imageId)
			        	.attr("width", "100%")
			        	.attr("height", "auto")
			        	.attr("alt", "laptop");

			        
			        var details = $("<h3>").text(product.productBrand + " " + product.productName);
			        var type = $("<p>").text(product.productType);
			        var price = $("<p>").text("$" + product.productPrice);

			        // Create a hidden input field for productId
			        productIdInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productId); // Set the value to the productId
			            
			        var productBrandInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productBrand); // Set the value to the productId
			            
			        getImage(product.productId);
			            
			        var productNameInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productName); // Set the value to the productId
			            
			        var productPriceInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productPrice); // Set the value to the productId
			            
			        var stockAvailableInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "stockesAvailable") // Set a name for the input field
			            .val(product.stockesAvailable); // Set the value to the productId 

			        var cartButton = $("<button>").addClass("btn btn-info").text("Add to Cart");
			        
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
			        
			        cartButton.on("click", function() {
			            var productId = productIdInput.val();
			            var productBrand = productBrandInput.val();
			            var productName = productNameInput.val();
			            var productPrice = productPriceInput.val();
			            var stockesAvailable = stockAvailableInput.val();
			            console.log("Clicked Add to Cart for productId: " + productId);
			            
			            $.ajax({
			                type: 'POST',
			                url: '/addToCart',
			                data: { productId: productId ,
			                		productBrand: productBrand,
			                		productName: productName,
			                		productPrice: productPrice,
			                		stockesAvailable: stockesAvailable}, // Send productId in the request
			                success: function(response) {
			                    // Handle the success response if needed
			                    console.log(productId + " " + productBrand + " " + productName + " " + productPrice);
			                    window.alert("Added Successfully! Redirecting to your cart");
			                    window.location.href = '/cart';
			                },
			                error: function(error) {
			                	window.alert("There is an error on adding product to cart");
			                    console.error('Error Details:', error);
			                }
			            });
			        });
					
			        
			        productContainer.append(image, details, type, price, productIdInput, productBrandInput, productNameInput, productPriceInput, cartButton);

			        var styleContainer = $("<div class='mail-card'>").append(productContainer);
			        container.append(styleContainer);
			    });
			}
			fetchProducts();
		})
	</script>
	
	<script>
		$(document).ready(function() {
			function fetchProducts() {
				$.ajax({
					type: 'GET',
					url: '/rest/getOthers',
					dataType: 'json',
					success: function(response) {
						displayProducts(response);
					},
					error: function(error) {
						console.error('Error Details:', error);
					}
				});
			}
			
			var productIdInput;

			function displayProducts(products) {
			    var container = $("#otherContainer");
			    container.empty();
			
			    $.each(products, function(index, product) {
			        var productContainer = $("<div>").addClass("user-dashboard");
			        
			        var imageId = "productImage_" + product.productId;

			        var image = $("<img>")
			        	.attr("src", "")
			        	.attr("id", imageId)
			        	.attr("width", "100%")
			        	.attr("height", "auto")
			        	.attr("alt", "laptop");

			        
			        var details = $("<h3>").text(product.productBrand + " " + product.productName);
			        var type = $("<p>").text(product.productType);
			        var price = $("<p>").text("$" + product.productPrice);

			        // Create a hidden input field for productId
			        productIdInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productId); // Set the value to the productId
			            
			        var productBrandInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productBrand); // Set the value to the productId
			            
			        getImage(product.productId);
			            
			        var productNameInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productName); // Set the value to the productId
			            
			        var productPriceInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "productId") // Set a name for the input field
			            .val(product.productPrice); // Set the value to the productId
			            
			        var stockAvailableInput = $("<input>")
			            .attr("type", "hidden")
			            .attr("name", "stockesAvailable") // Set a name for the input field
			            .val(product.stockesAvailable); // Set the value to the productId 

			        var cartButton = $("<button>").addClass("btn btn-info").text("Add to Cart");
			        
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
			        
			        cartButton.on("click", function() {
			            var productId = productIdInput.val();
			            var productBrand = productBrandInput.val();
			            var productName = productNameInput.val();
			            var productPrice = productPriceInput.val();
			            var stockesAvailable = stockAvailableInput.val();
			            console.log("Clicked Add to Cart for productId: " + productId);
			            
			            $.ajax({
			                type: 'POST',
			                url: '/addToCart',
			                data: { productId: productId ,
			                		productBrand: productBrand,
			                		productName: productName,
			                		productPrice: productPrice,
			                		stockesAvailable: stockesAvailable}, // Send productId in the request
			                success: function(response) {
			                    // Handle the success response if needed
			                    console.log(productId + " " + productBrand + " " + productName + " " + productPrice);
			                    window.alert("Added Successfully! Redirecting to your cart");
			                    window.location.href = '/cart';
			                },
			                error: function(error) {
			                	window.alert("There is an error on adding product to cart");
			                    console.error('Error Details:', error);
			                }
			            });
			        });
					
			        
			        productContainer.append(image, details, type, price, productIdInput, productBrandInput, productNameInput, productPriceInput, cartButton);

			        var styleContainer = $("<div class='mail-card'>").append(productContainer);
			        container.append(styleContainer);
			    });
			}	
			fetchProducts();
		})
	</script>
	
	
	
</head>
<body>
<%@ include file="header.jsp" %>
<div class="bg-dark">
	<div class="container">
		
		
		<!-- Button with a search icon to trigger the modal -->
		<div class="white-font mb-3">
			<a type="button" class="pt-3 nav-link " data-bs-toggle="modal" data-bs-target="#searchModal">
			    <i class="fas fa-search"></i>   Search Products
			</a>
		</div>
		
		
		<!-- Search Modal -->
		<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="searchModalLabel">Search Products</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body" id="productModalBody">
		                <!-- Include your search content here -->
		                <%@ include file="search.jsp" %>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="row">
			<div class="col-md-4 col-sm-12">
				<div id="laptopContainer"></div>
			</div>
			<div class="col-md-4 col-sm-12">
				<div id="phoneContainer"></div>
			</div>
			<div class="col-md-4 col-sm-12">
				<div id="otherContainer"></div>
			</div>
		</div>
		
		
	</div>
</div>
</body>
</html>