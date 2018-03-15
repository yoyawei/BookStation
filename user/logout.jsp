<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
		<%
		 response.setHeader("refresh","0;url=../home.jsp");//定时跳转
		 session.invalidate();//注销
		%>
	</body>
</html>