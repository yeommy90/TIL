<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>물리적 경로</h2>
	application 내장 객체 : <%= application.getRealPath("/02ImplicitObject") %>
	
	<h2>선언부 내장 객체</h2>
	<%!
	public String useImplicitObject() {
		return this.getServletContext().getRealPath("/02ImplicitObject");
	}
	
	public String useImplicitObject(ServletContext app) {
		return app.getRealPath("/02ImplicitObject");
	}
	%>
	
	<ul>
		<li>this 사용 : <%= useImplicitObject() %></li>
		<li>내장 객체를 인수로 전달 : <%= useImplicitObject(application) %></li>
	</ul>
</body>
</html>