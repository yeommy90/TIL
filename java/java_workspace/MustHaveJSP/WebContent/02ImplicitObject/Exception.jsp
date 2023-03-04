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
int status = response.getStatus(); // response 객체로부터 에러코드 확인

if (status == 404) {
	out.print("404에러발생");
} else if (status == 405) {
	out.print("405에러발생");
} else if (status == 500) {
	out.print("500에러발생");
}
%>

</body>
</html>