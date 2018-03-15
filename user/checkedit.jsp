<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("nickname");
		
		String key = (String)session.getAttribute("userid");
		  
        //驱动程序名   
        String driverName = "com.mysql.jdbc.Driver";  
        //数据库用户名   
        String userName = "******";  
        //密码   
        String userPasswd = "******";  
        //数据库名   
        String dbName = "book";  
 
        //联结字符串   
        String url = "jdbc:mysql://localhost:3306/" + dbName + "?user="  
                + userName + "&password=" + userPasswd;  
  
        Class.forName("com.mysql.jdbc.Driver").newInstance();  
        Connection connection = DriverManager.getConnection(url);  
        Statement statement = connection.createStatement();  
		      
        //修改用户昵称
        String sql = "UPDATE usertb SET nickname=? WHERE userid=?";
        //预编译SQL，减少sql执行
        PreparedStatement ptmt = connection.prepareStatement(sql);
        //传参
        ptmt.setString(1, name);
        ptmt.setString(2, key);
        //执行
        ptmt.execute();
        //注册成功
        response.sendRedirect("user.jsp");
        
        ptmt.close();
        connection.close();
	%>
	</body>
</html>