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
		       
        String sql = "SELECT userid,password FROM usertb "
        		+"WHERE userid=?";  
        //预编译SQL，减少sql执行
        PreparedStatement ptmt = connection.prepareStatement(sql);
        //传参
        ptmt.setString(1, id);
        //执行
        ResultSet rs = ptmt.executeQuery();
        
        int count=0;
        if(rs.next()){
        	count++;
    		String rid = (String)rs.getString(1);
    		String rpwd = (String)rs.getString(2);
    		if(id.equals(rid) && pwd.equals(rpwd)){
    			session.setAttribute("Login", "OK");
    			session.setAttribute("userid", id);
    			response.sendRedirect("../home.jsp");
    		}else{
    			response.sendRedirect("login.jsp?error=1");
    		}
        }
        
        if(count==0){
        	response.sendRedirect("login.jsp?error=2");
        }
        
        rs.close();
        ptmt.close();
        connection.close();
	%>
	</body>
</html>