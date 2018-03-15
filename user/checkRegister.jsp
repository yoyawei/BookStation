<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		  
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
		      
        //查询用户是否已存在
        String sql1 = "SELECT userid,password FROM usertb "
        		+"WHERE userid=?";  
        //预编译SQL，减少sql执行
        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
        //传参
        ptmt1.setString(1, id);
        //执行
        ResultSet rs = ptmt1.executeQuery();
        if(rs.next()){
    		response.sendRedirect("register.jsp?error=1");
        }
        
        //创建用户信息
        String sql2 = "INSERT INTO usertb (userid,password) VALUES (?,?)";
        //预编译SQL，减少sql执行
        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
        //传参
        ptmt2.setString(1, id);
        ptmt2.setString(2, pwd);
        //执行
        ptmt2.execute();
        //注册成功
        response.sendRedirect("login.jsp?error=0");
        
        rs.close();
        ptmt1.close();
        ptmt2.close();
        connection.close();
	%>
	</body>
</html>