<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
// 폼값을 DTO 객체에 저장
BoardDTO dto = new BoardDTO();
dto.setTitle(request.getParameter("title"));
dto.setContent(request.getParameter("content"));
dto.setId(session.getAttribute("UserId").toString());

// DAO 객체를 통해 DB에 저장
BoardDAO dao = new BoardDAO(application);
int result = dao.insertWrite(dto);
dao.close();

if (result == 1) {
	response.sendRedirect("List.jsp");
} else {
	JSFunction.alertBack("글쓰기 실패", out);
}
%>