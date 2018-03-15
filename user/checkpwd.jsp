<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String old = request.getParameter("oldpwd");
		String pwd = request.getParameter("newpwd");
		
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
        
        //查询当前密码合法性
        String sql1 = "SELECT password FROM usertb WHERE userid=?";  
        //预编译SQL，减少sql执行
        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
        //传参
        ptmt1.setString(1, key);
        //执行
        ResultSet rs = ptmt1.executeQuery();
        int flag=0;
        if(rs.next()){
        	if(rs.getString(1).equals(old)){
                //修改用户密码
                String sql2 = "UPDATE usertb SET password=? WHERE userid=?";
                //预编译SQL，减少sql执行
                PreparedStatement ptmt2 = connection.prepareStatement(sql2);
                //传参
                ptmt2.setString(1, pwd);
                ptmt2.setString(2, key);
                //执行
                ptmt2.execute();
                //修改成功
                response.sendRedirect("password.jsp?error=0");
                ptmt2.close();
                }
        }else{
        	response.sendRedirect("password.jsp?error=1");
        }
        
        rs.close();
        ptmt1.close();
        connection.close();
	%>
	</body>
</html>