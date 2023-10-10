<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message Us!</title>
</head>

<script>
    function showAlert() {
        try {
            // You can perform form validation here if needed

            // Display a success alert
            alert("Thank you for you Feedback!");
            return true; // Allow the form to be submitted
        } catch (error) {
            // Display an error alert
            alert("Form submission failed: " + error.message);
            return false; // Prevent the form from being submitted
        }
    }
</script>

<body>
<%@ include file="header.jsp" %>
	<div class="align-items-center position-relative" >
			<div class="container mt-5">
			    <div class="row align-items-center">
			        
			        <div class="col-md-6">
			            <form action="/addFeedback" method="post" onsubmit="return showAlert()" class="was-validated">
				            <div class="d-flex flex-column">
				            	<h2>Send a Message</h2>
				            	<input type="text" class="form-control mb-3" id="name" name="name" placeholder="Full Name (Auto Filled)" readonly/>
								<input type="email" class="form-control mb-3" id="email" name="email" placeholder="Email (Auto Filled)" readonly/>				
								<textarea class="form-control mb-3" id="feedbackBody" name="feedbackBody" placeholder="Message"></textarea>
								<button type="submit" class="btn btn-primary">Submit</button>
							</div>
						</form>
			        </div>
			        <div class="col-md-6">
			            <img src="https://i.imgur.com/qLx6e3u.png" width="100%" alt="img">
			        </div>
			        
			    </div>
			</div>
		</div>
</body>
</html>