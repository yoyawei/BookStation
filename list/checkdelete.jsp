<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("dtitle");
		String list = request.getParameter("listid");
		int listid=Integer.parseInt(list);

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
		
        //验证删除主题
        String sql1 = "SELECT listtitle FROM listtb WHERE userid=? and listid=?";  
        //预编译SQL，减少sql执行
        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
        //传参
        ptmt1.setString(1, userid);
        ptmt1.setInt(2, listid);
        //执行
        ResultSet rs = ptmt1.executeQuery();
        if(rs.next()){
    		if(rs.getString(1).equals(title)){
    	        //删除书单
    	        String sql2 = "DELETE FROM listtb WHERE userid=? and listid=?";
    	        //预编译SQL，减少sql执行
    	        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
    	        //传参
		        ptmt2.setString(1, userid);
		        ptmt2.setInt(2, listid);
    	        //执行
    	        ptmt2.execute();
    	        response.sendRedirect("list.jsp");
    	        ptmt1.close();
    		} else {
    	        String u="editlist.jsp?key="+listid+"&error=1";
    	        response.sendRedirect(u);
    		}
        }        
        
        rs.close();
        ptmt1.close();
        connection.close();
	%>
	</body>
</html>