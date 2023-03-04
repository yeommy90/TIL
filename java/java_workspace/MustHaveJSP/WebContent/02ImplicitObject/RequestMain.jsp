<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>클라이언트와 서버의 환경정보 읽기</h2>
	<a href="./RequestWebInfo.jsp?eng=Hello&han=안녕">GET 방식</a>
	
	<form action="RequestWebInfo.jsp" method="get">
		<input type="text" name="eng" value="Bye" />
		<input type="text" name="han" value="잘가" />
		<input type="submit" value="POST 방식" />	
	</form>
	
	<h2>클라이언트의 요청 매개변수 읽기</h2>
	<form method="post" action="RequestParameter.jsp">
		아이디 : <input type="text" name="id" value="" />
		성별 : <input type="radio" name="sex" value="man" />남자
		<input type="radio" name="sex" value="woman" checked="checked"/> 여자
		관심사항 : <input type="checkbox" name="favo" value="eco" /> 경제
		<input type="checkbox" name="favo" value="pol" checked="checked"/> 정치
		<input type="checkbox" name="favo" value="ent" /> 연예
		<input type="submit" value="전송"/>
	</form>
	
	<h2>HTTP 요청 헤더 정보 읽기</h2>
	<a href="RequestHeader.jsp">요청 헤더 정보</a>
</body>
</html>