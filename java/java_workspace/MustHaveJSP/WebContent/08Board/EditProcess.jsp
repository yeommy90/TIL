<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

BoardDTO dto = new BoardDTO();
dto.setNum(request.getParameter("num"));
dto.setTitle(request.getParameter("title"));
dto.setContent(request.getParameter("content"));

BoardDAO dao = new BoardDAO(application);
int result = dao.updateEdit(dto);
dao.close();

if (result == 1) {
	response.sendRedirect("View.jsp?num=" + dto.getNum());
} else {
	JSFunction.alertBack("수정 실패!", out);
}
%>