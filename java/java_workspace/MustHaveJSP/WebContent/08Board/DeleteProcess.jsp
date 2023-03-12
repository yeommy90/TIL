<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
String num = request.getParameter("num");
String sessionId = session.getAttribute("UserId").toString();

BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO(application);
dto = dao.selectView(num);

int result = 0;

if (sessionId.equals(dto.getId())) { // 작성자 본인이 맞으면
	result = dao.deletePost(num);
	dao.close();
	
	if (result == 1) {
		JSFunction.alertLocation("삭제 성공", "List.jsp", out);
	} else {
		JSFunction.alertBack("삭제 실패", out);
	}
} else { // 작성자 본인이 아니면
	JSFunction.alertBack("본인만 삭제 가넝", out);
	return;
}
%>