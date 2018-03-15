<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String book = request.getParameter("bookid");
		String list = request.getParameter("listid");
		int bookid=Integer.parseInt(book);
		int listid=Integer.parseInt(list);

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
		     
        //删除书目
        String sql = "DELETE FROM book2list WHERE bookid=? and listid=?";
        //预编译SQL，减少sql执行
        PreparedStatement ptmt = connection.prepareStatement(sql);
        //传参
        ptmt.setInt(1,bookid);
        ptmt.setInt(2,listid);
        //执行
        ptmt.execute();
        String u="editlist.jsp?key="+listid;
        response.sendRedirect(u);
        
        ptmt.close();
        connection.close();
	%>
	</body>
</html>