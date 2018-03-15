<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		String des = request.getParameter("describe");
		String s = request.getParameter("share");
		String list = request.getParameter("listid");
		int listid=Integer.parseInt(list);
        int share;
        if(s==null){share=0;}
        else if(s.equals("on")){share=1;}
        else{share=0;}

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
		       
        //更新书单
        String sql = "UPDATE listtb SET listtitle=?,listprofile=?,listshare=? WHERE listid=?";
        //预编译SQL，减少sql执行
        PreparedStatement ptmt = connection.prepareStatement(sql);
        //传参
        ptmt.setString(1, title);
        ptmt.setString(2, des);
        ptmt.setInt(3,share);
        ptmt.setInt(4,listid);
        //执行
        ptmt.execute();
        response.sendRedirect("list.jsp");
        
        ptmt.close();
        connection.close();
	%>
	</body>
</html>