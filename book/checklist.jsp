<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String book = request.getParameter("bookid");
		String list = request.getParameter("tolist");
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
		
        //查询是否已存在
        String sql1 = "SELECT bookid,listid FROM book2list WHERE bookid=? and listid=?"; 
        //预编译SQL，减少sql执行
        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
        //传参
        ptmt1.setInt(1, bookid);
        ptmt1.setInt(2, listid);
        //执行
        ResultSet rs = ptmt1.executeQuery();   
        if(rs.next()){
        	String u1="book-item.jsp?key="+book+"&error=1";
        	response.sendRedirect(u1);
        }else{
        
        //添加
        String sql2 = "INSERT INTO book2list (bookid,listid) VALUES (?,?)"; 
        //预编译SQL，减少sql执行
        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
        //传参
        ptmt2.setInt(1, bookid);
        ptmt2.setInt(2, listid);
        //执行
        ptmt2.execute();
        String u2="book-item.jsp?key="+book+"&error=0";
        response.sendRedirect(u2);
        ptmt2.close();
        }
        
        rs.close();
        ptmt1.close();
        connection.close();
	%>
	</body>
</html>