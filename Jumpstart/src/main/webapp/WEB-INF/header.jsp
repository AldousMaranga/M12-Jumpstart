<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
		   uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    
    <!-- Core theme CSS (includes Bootstrap)-->

	
	<style>
		body {
			font-family: 'oswald';
		}

		
		.blue-nav{
			background-color: #01306D;
		} 
		
		.light-font{
			color: #FFFFFF;
		}
		
		.vertical-align {
		    display: flex; /* Use flexbox */
		    align-items: center; /* Vertically center align items */
		}
		
		.navbar-color {
			background-color: white;
		}
	</style>

</head>
<body>
	

	<nav class="navbar navbar-expand-lg blue-nav">
	    <div class="container">
	    	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"  id="navbarToggle">
			    <i class="fa-solid fa-bars fa-lg" style="color: #fafafa;" ></i>
			</button>
	    	
	    	<div class="collapse navbar-collapse" id="navbarNav">
	    		<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
		            <sec:authorize access="isAnonymous()">
		                <!-- Show login and register links for unauthenticated users -->
		                <li class="nav-item"><a class="nav-link light-font" href="login">Login</a></li>
		                <li class="nav-item"><a class="nav-link light-font" href="register_page">Register</a></li>
		            </sec:authorize>
		            
		            <sec:authorize access="isAuthenticated()">

		                <!-- Show logout button for authenticated users -->
		                <li class="nav-item"><a class="nav-link light-font" href="dashboard"><i class="fa-solid fa-house" style="font-size: 30px;"></i></a></li>
		                <li class="nav-item"><a class="nav-link light-font" href="cart"><i class="fa-solid fa-cart-shopping" style="font-size: 30px;"></i></a></li>
		                <li class="nav-item"><a class="nav-link light-font" href="contactUs"><i class="fa-solid fa-phone" style="font-size: 30px;"></i></a></li>
		                <li class="nav-item"><a class="nav-link light-font" href="logout"><i class="fa-solid fa-right-from-bracket" style="color: #d71414; font-size: 30px;"></i></a></li>
		                
		            </sec:authorize>
		        </ul>
	    	</div>
	        
	    </div>
	</nav>
	
	<script>
    // Add a click event listener to the toggle button
	    document.getElementById('navbarToggle').addEventListener('click', function () {
	        // Get the target menu by ID
	        const targetMenu = document.getElementById('navbarNav');
	
	        // Toggle the collapse state of the menu
	        if (targetMenu.classList.contains('show')) {
	            // If the menu is currently open, close it
	            targetMenu.classList.remove('show');
	        } 
	    });
	</script>

</body>
</html>