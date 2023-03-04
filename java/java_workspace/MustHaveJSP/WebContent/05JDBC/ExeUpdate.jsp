<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBCConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 추가 테스트(executeUpdate() 사용)</h2>
	<%
	JDBCConnect jdbc = new JDBCConnect();
	
	String id = "test1";
	String pass = "1111";
	String name = "회원1";
	
	String sql = "INSERT INTO member VALUES(?, ?, ?, sysdate)";
	PreparedStatement psmt = jdbc.con.prepareStatement(sql);
	psmt.setString(1, id);
	psmt.setString(2, pass);
	psmt.setString(3, name);
	
	int inResult = psmt.executeUpdate();
	out.println(inResult + "행이 입력되었따.");
	
	jdbc.close();
	%>
</body>
</html>