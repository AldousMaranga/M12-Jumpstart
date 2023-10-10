<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
	
	<style>
		.product-container {
		    /* Add your desired styles here */
		    /* For example, you can set width, margin, padding, etc. */
		    margin-bottom: 25px;
		    padding: 20px;
		    border: 1px solid #54566A;
		    background-color: #54566A;
		    border-radius: 20px;
		    text-align: center;
		    color: white;
		    /* You can add more styles to customize the appearance */
		}
	</style>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		$(document).ready(function () {
		  // Reference to search input and results container
		  var $searchInput = $("#searchInput");
		  var $searchResults = $("#searchResults");

		  // Attach an event listener to the search input field
		  $searchInput.on("input", function () {
		    // Get the search query entered by the user
		    var key = $searchInput.val();

		    // Make an Ajax request to the server to fetch search results
		    $.ajax({
		      type: "GET", // Use GET or POST based on your server-side implementation
		      url: "/search", // Replace with the actual URL for your search endpoint
		      data: { key: key }, // Send the search query as a parameter
		      dataType: "json", // Expected data type (json in this case)
		      success: function (data) {
		        // Clear previous results
		        $searchResults.empty();

		        // Process the received data (assuming data is an array of search results)
		        data.forEach(function (product) {
		          // Create and append a result item to the results container
		          var productContainer = $("<div>").addClass("product-container");
		          
		          var image = $("<img>")
		        	.attr("src", "https://www.asus.com/media/Odin/Websites/global/Series/12.png")
		        	.attr("width", "100%")
		        	.attr("alt", "laptop");
		          
		          var details = $("<h3>").text(product.productBrand + " " + product.productName);
		          var type = $("<p>").text(product.productType);
		          var price = $("<p>").text("$" + product.productPrice);
		          
		          var productIdInput = $("<input>")
		            .attr("type", "hidden")
		            .attr("name", "productId") // Set a name for the input field
		            .val(product.productId); // Set the value to the productId
		            
		        var productBrandInput = $("<input>")
		            .attr("type", "hidden")
		            .attr("name", "productId") // Set a name for the input field
		            .val(product.productBrand); // Set the value to the productId
		            
		        var productNameInput = $("<input>")
		            .attr("type", "hidden")
		            .attr("name", "productId") // Set a name for the input field
		            .val(product.productName); // Set the value to the productId
		            
		        var productPriceInput = $("<input>")
		            .attr("type", "hidden")
		            .attr("name", "productId") // Set a name for the input field
		            .val(product.productPrice); // Set the value to the productId

		        var cartButton = $("<button>").addClass("btn btn-info").text("Add to Cart");

		        cartButton.on("click", function() {
		            var productId = productIdInput.val();
		            var productBrand = productBrandInput.val();
		            var productName = productNameInput.val();
		            var productPrice = productPriceInput.val();
		            console.log("Clicked Add to Cart for productId: " + productId);
		            
		            $.ajax({
		                type: 'POST',
		                url: '/addToCart',
		                data: { productId: productId ,
		                		productBrand: productBrand,
		                		productName: productName,
		                		productPrice: productPrice}, // Send productId in the request
		                success: function(response) {
		                    // Handle the success response if needed
		                    console.log(productId + " " + productBrand + " " + productName + " " + productPrice);
		                    window.location.href = '/cart';
		                },
		                error: function(error) {
		                    console.error('Error Details:', error);
		                }
		            });
		        });
				
		        
		        productContainer.append(image, details, type, price, productIdInput, productBrandInput, productNameInput, productPriceInput, cartButton)
		          
		          $searchResults.append(productContainer);
		        });
		      },
		      error: function (error) {
		        console.error("Error fetching search results: ", error);
		      },
		    });
		  });
		});

	</script>
</head>
<body>

	<div class="container">
		<input type="text" id="searchInput" placeholder="Search..." class="form-control">
		<div id="searchResults" class="mt-3"></div>
	</div>
</body>
</html>