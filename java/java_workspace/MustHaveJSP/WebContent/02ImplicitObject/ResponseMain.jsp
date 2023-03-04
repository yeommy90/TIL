<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그인 폼</h2>
	<%
	String loginErr = request.getParameter("loginErr");
	if (loginErr != null) out.print("로그인 실패...");
	%>
	
	<form action="ResponseLogin.jsp" method="post">
		<input type="text" name="user_id" /><br>
		<input type="text" name="user_pw" /><br>
		<input type="submit" value="로그인" />
	</form>
	
	<h2>HTTP 응답 헤더 설정</h2>
	<form action="ResponseHeader.jsp">
		<input type="text" name="add_date" value="2023-02-27 21:00" /><br>
		<input type="text" name="add_str" value="서여미" /><br>
		<input type="submit" value="응답 헤더"/>
	</form>
</body>
</html>