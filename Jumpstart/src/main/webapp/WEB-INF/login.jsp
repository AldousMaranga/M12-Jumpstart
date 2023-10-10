<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
	
</head>
<body>
<%@ include file="header.jsp" %>


	<div class="align-items-center position-relative" >
		<div class="container mt-5">
		    <div class="row align-items-center">
		        <div class="col-md-6">
		            <img src="https://i.imgur.com/0jJX2eC.png" width="80%" height="auto" alt="img">
		            <div class="row">
		            	<div class="col-md-3"></div>
			        	<div class="col-md-9">
			            	<h1>Join Us</h1>
			            	<p>Become a member to the community!</p>
			            </div>
		            </div>
		        </div>
		        <div class="col-md-6">
		            <form action="/login" method="post" class="was-validated">
		                <div class="d-flex flex-column">
		                	<h2 class="mb-5">Login Now!</h2>
		                	
		                	<% if (request.getAttribute("loginError") != null) { %>
	                            <div class="alert alert-danger">
	                                Login failed. Please check your credentials and try again.
	                            </div>
	                        <% } %>
		                	
		                    <input type="text" class="form-control mb-3" id="username" name="username" placeholder="Username" required>
		                    <input type="password" class="form-control mb-3" id="password" name="password" placeholder="Password" required>
		                    <button type="submit" class="btn btn-primary">Login</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
	</div>


</body>
</html>