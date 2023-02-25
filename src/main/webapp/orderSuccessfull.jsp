<%-- 
    Document   : orderSuccessfull
    Created on : Feb 25, 2023, 9:48:44 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script type="text/javascript">
	var count = 5;
	var redirect = "<%= request.getAttribute("mess") %>";
	function countDown(){
		var timer = document.getElementById("timer");
		if(count > 0){
			count--;
			timer.innerHTML = "Trang web bạn muốn đến sẽ tự động chuyển tới trong <b>"+count+"</b> giây.";
			setTimeout("countDown()", 1000);
		}else{
			window.location.href = redirect;
		}
	}
	</script>
	<style>
	.wrap {
		width: 600px;
		margin: 250px auto;
		padding: 20px;
		border-radius: 10px;
		border: 1px solid #ddd;
		font-size: 20px;
		line-height: 1.3em;
		text-align: center;
	}
	</style>
    <div class="wrap">
        <p id="timer"><script type="text/javascript">countDown();</script></p>
	</div>
    </body>
</html>
