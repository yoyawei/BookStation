<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String book = request.getParameter("bookid");
		String comment = request.getParameter("commentcontent");
        int bookid=Integer.parseInt(book);

        String userid = (String)session.getAttribute("userid");

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
		       
        //添加
        String sql = "INSERT INTO user2book (userid,bookid,comment) VALUES (?,?,?)"; 
        //预编译SQL，减少sql执行
        PreparedStatement ptmt = connection.prepareStatement(sql);
        //传参
        ptmt.setString(1, userid);
        ptmt.setInt(2, bookid);
        ptmt.setString(3,comment);
        //执行
        ptmt.execute();
        String u2="book-item.jsp?key="+book+"&error=0";
        response.sendRedirect(u2);
        
        ptmt.close();
        connection.close();
	%>
	</body>
</html>