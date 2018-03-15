<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String book = request.getParameter("bookid");
		String tag = request.getParameter("tag");
        int bookid=Integer.parseInt(book);
        int tagid=-1;
		  
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
		
        //查询标签是否已存在
        String sql1 = "SELECT tagid FROM tagtb WHERE tag=?"; 
        //预编译SQL，减少sql执行
        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
        //传参
        ptmt1.setString(1, tag);
        //执行
        ResultSet rs1 = ptmt1.executeQuery();   
        if(rs1.next()){
        	//获得标签id
        	tagid=rs1.getInt(1);
        }else{
	        //添加标签
	        String sql2 = "INSERT INTO tagtb (tag) VALUES (?)"; 
	        //预编译SQL，减少sql执行
	        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
	        //传参
	        ptmt2.setString(1, tag);
	        //执行
	        ptmt2.execute();
	        
	      	//获得标签id
	        String sql3 = "SELECT tagid FROM tagtb WHERE tag=?"; 
	        //预编译SQL，减少sql执行
	        PreparedStatement ptmt3 = connection.prepareStatement(sql3);
	        //传参
	        ptmt3.setString(1, tag);
	        //执行
	        ResultSet rs2 = ptmt3.executeQuery();  
	        if(rs2.next()){
	        	//获得标签id
	        	tagid=rs2.getInt(1);
	        }
	        ptmt2.close();
	        ptmt3.close();
        }
        	
        if(tagid!=-1){
            //查询关系是否已存在
            String sql5 = "SELECT tagid,bookid FROM book2tag WHERE bookid=? and tagid=?"; 
            //预编译SQL，减少sql执行
            PreparedStatement ptmt5 = connection.prepareStatement(sql5);
            //传参
            ptmt5.setInt(1, bookid);
            ptmt5.setInt(2, tagid);
            //执行
            ResultSet rs2 = ptmt5.executeQuery();   
            if(rs2.next()){
            	String u="book-item.jsp?key="+book+"&error=2";
    		    response.sendRedirect(u);
            }else{
			    //添加关系
			    String sql4 = "INSERT INTO book2tag (bookid,tagid) VALUES (?,?)"; 
			    //预编译SQL，减少sql执行
			    PreparedStatement ptmt4 = connection.prepareStatement(sql4);
			    //传参
			    ptmt4.setInt(1, bookid);
			    ptmt4.setInt(2, tagid);
			    //执行
			    ptmt4.execute();
			    String u="book-item.jsp?key="+book+"&error=0";
			    response.sendRedirect(u);
			    ptmt4.close();   
            }
            rs2.close();
            ptmt5.close();
        }
        rs1.close();
        ptmt1.close();
        connection.close();
	%>
	</body>
</html>