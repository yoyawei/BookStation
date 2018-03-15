<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>书单-读书小站</title>
	<link rel="stylesheet" type="text/css" href="../reset.css">
	<link rel="stylesheet" type="text/css" href="../style.css">
	<link rel="stylesheet" type="text/css" href="list.css">
	<script>
		function validateForm(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var x=document.forms["searchForm"]["q"].value;
			if(x==null || x==""){
				return false;
			}	
			if ( re.test(x) )
			{
				alert("请您不要输入特殊字符和SQL关键字！");
				return false;
			}	
			return true;
		}
	</script>
</head>
<body>
	<%  
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
        
        //需要获得当前用户id
        String key = (String)session.getAttribute("userid");
    %>
	<header>
		<h2>📖</h2>
		<h3><a href="../home.jsp">读书小站</a></h3>
		<h4><a href="../book/book.jsp">图书</a></h4>
		<h4><a href="#">书单</a></h4>
		<form name="searchForm" action="../result.jsp" onsubmit="return validateForm()" method="post">
        	<input type="search" name="q" placeholder="请输入书名">
        	<input type="submit" value="搜索">
       </form>
       <% if((String)session.getAttribute("Login")=="OK"){%>
       <h4 id="topR"><a href="../user/user.jsp">个人中心</a></h4>
       <% }else{%>
       <h4 id="topR"><a href="../user/login.jsp">登 录</a></h4>
       <% }%>
    </header>
	<main>
		<article>
			<section>
				<h4>书单</h4>
				<hr class="line">
				<div class="list">
				<%
			        String sql1 = "SELECT listtitle,nickname,listprofile,listid "
			        		+"FROM usertb,listtb "
			        		+"WHERE usertb.userid=listtb.userid "
			        		+"and listshare = '1'";  
			        ResultSet lists = statement.executeQuery(sql1); 
				%>
				<% while (lists.next()) {%> 
					<div class="list-item">
						<a href="list-item.jsp?key=<%=lists.getString(4)%>">
							<span class="listname"><% out.print(lists.getString(1));%></span>
						</a>
							by <span class="username"><% out.print(lists.getString(2));%></span>
						<p><% out.print(lists.getString(3));%></p>
					</div>
					<hr class="dash">
				<% }lists.close();%>
				</div>
			</section>
		</article>
		<aside>
			<section>
			    <% if((String)session.getAttribute("Login")=="OK"){%>
				<h4>我的书单 <a href="create.jsp">创建</a></h4>
				<hr class="line">
				<div class="list">
				<%
			        String sql2 = "SELECT listtitle,listprofile,listtb.listid "
			        		+"FROM listtb "
			        		+"WHERE userid=?";  
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
			        //传参
			        ptmt2.setString(1, key);
			        //执行
			        ResultSet mylist = ptmt2.executeQuery();
				%>
				<% while (mylist.next()) {%> 
					<div class="list-item">
						<a href="list-item.jsp?key=<%=mylist.getString(3)%>" style="float:none">
						<span class="listname"><% out.print(mylist.getString(1));%></span>
						</a>
						<a href="editlist.jsp?key=<%=mylist.getString(3)%>">删除</a>
						<a href="editlist.jsp?key=<%=mylist.getString(3)%>">编辑</a>
						<p><% out.print(mylist.getString(2));%></p>
					</div>
					<hr class="dash">
				<% } 
					mylist.close();
					ptmt2.close();
				%>
				<% }else{%>
			<h4>我的书单 </h4>
			<br>
			<p>用户未登录...</p>
			<% }%>
			</section>
		</aside>
	</main>
	<footer>
		<p>©Copyright 6666 by yawei. All rights reversed.</p>
		<p>联系我们：******@qq.com</p>
	</footer>
	<% 
		connection.close();
	%>
</body>
</html>