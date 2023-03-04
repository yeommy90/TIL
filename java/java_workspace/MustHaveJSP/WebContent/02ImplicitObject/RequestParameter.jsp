<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String sex = request.getParameter("sex");
String[] favo = request.getParameterValues("favo");
String favoStr = "";

if(favo != null) {
	for (int i=0; i<favo.length; i++) {
		favoStr += favo[i] + " ";
	}
}
%>

<ul>
	<li>아이디:<%= id %></li>
	<li>성별:<%= sex %></li>
	<li>관심사항:<%= favoStr %></li>
</ul>
</body>
</html>