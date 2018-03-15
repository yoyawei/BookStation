<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>作者名-读书小站</title>
	<link rel="stylesheet" type="text/css" href="../reset.css">
	<link rel="stylesheet" type="text/css" href="../style.css">
	<link rel="stylesheet" type="text/css" href="book.css">
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
        
        //需要获得作者
        request.setCharacterEncoding("UTF-8");
        String key=request.getParameter("key");
    %>  
	<header>
		<h2>📖</h2>
		<h3><a href="../home.jsp">读书小站</a></h3>
		<h4><a href="book.jsp">图书</a></h4>
		<h4><a href="../list/list.jsp">书单</a></h4>
		<form name="searchForm" action="../result.jsp" onsubmit="return validateForm()" method="post">
        	<input type="search" name="q" placeholder="请输入书名">
        	<input type="submit" value="搜索">
       </form>
       <% if((String)session.getAttribute("Login")=="OK"){%>
       <h4 id="topR"><a href="user/user.jsp">个人中心</a></h4>
       <% }else{%>
       <h4 id="topR"><a href="user/login.jsp">登 录</a></h4>
       <% }%>
	</header>
	<main>
		<article>
			<section class="book-detail">
			<%
				String sql1="SELECT author,authorprofile "
						+"FROM authortb "
						+"WHERE authortb.authorid=?";
		        //预编译SQL，减少sql执行
		        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
		        //传参
		        ptmt1.setString(1, key);
		        //执行
		        ResultSet author = ptmt1.executeQuery();
			%>
			<% while (author.next()) {%>
				<h3><% out.print(author.getString(1));%></h3>
				<h4>简  介</h4>
				<hr class="line">
				<span><% out.print(author.getString(2));%></span>
			<% }author.close();%>
			</section>
			<section>
				<h4>作 品</h4>
				<hr class="line">
				<div class="book">
				<%
					String sql2="SELECT bookname,author,booktb.bookid,bookimg "
							+"FROM booktb,authortb,book2author "
							+"WHERE booktb.bookid=book2author.bookid "
							+"and authortb.authorid=book2author.authorid "
							+"and authortb.authorid=?";
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
			        //传参
			        ptmt2.setString(1, key);
			        //执行
			        ResultSet books = ptmt2.executeQuery();
				%>
				<% while (books.next()) {%>
					<div class="book-item">
						<a href="book-item.jsp?key=<%=books.getString(3)%>">
							<img src="../<%=books.getString(4)%>" alt="图书封面">
						</a>
						<p><a href="book-item.jsp?key=<%=books.getString(3)%>"><% out.print(books.getString(1));%></a></p>
						<p><% out.print(books.getString(2));%></p>
					</div>
				<% }books.close();%>
				</div>
			</section>
		</article>
	</main>
	<footer>
		<p>©Copyright 6666 by yawei. All rights reversed.</p>
<<<<<<< b9b9ea8b6295190ebff75b1d2fdb1289b3866dc6
		<p>联系我们：***@qq.com</p>
=======
		<p>联系我们：******@qq.com</p>
>>>>>>> The privacy information was removed.
	</footer>
	<% 
		ptmt1.close();
		ptmt2.close();
		connection.close();
	%>
</body>
</html>
