<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>个人中心-读书小站</title>
	<link rel="stylesheet" type="text/css" href="../reset.css">
	<link rel="stylesheet" type="text/css" href="../style.css">
	<link rel="stylesheet" type="text/css" href="../book/book.css">
	<link rel="stylesheet" type="text/css" href="user.css">
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
		function validate(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var name = document.forms["edituserform"]["nickname"].value;
			
			if(name=="") {
				alert("昵称不能为空！");
				return false;
			}
			if(name.length > 16){
				alert("昵称过长！");
				return false;
			}
			if ( re.test(name) )
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
        
        //需要获得用户id
        String key = (String)session.getAttribute("userid");
    %>  
	<header>
		<h2>📖</h2>
		<h3><a href="../home.jsp">读书小站</a></h3>
		<h4><a href="../book/book.jsp">图书</a></h4>
		<h4><a href="../list/list.jsp">书单</a></h4>
		<form name="searchForm" action="../result.jsp" onsubmit="return validateForm()" method="post">
        	<input type="search" name="q" placeholder="请输入书名">
        	<input type="submit" value="搜索">
       </form>
       <% if((String)session.getAttribute("Login")=="OK"){%>
       <h4 id="topR"><a href="logout.jsp">退 出</a></h4>
       <% }else{%>
       <h4 id="topR"><a href="login.jsp">登 录</a></h4>
       <% }%>
	</header>
	<main>
	<% if((String)session.getAttribute("Login")=="OK"){%>
		<article>
			<section class="user-info">
				<h4>基本信息</h4>
				<hr class="line">
				<%
			        String sql1 = "SELECT userid,nickname "
			        		+"FROM usertb "
			        		+"WHERE userid=?";  
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
			        //传参
			        ptmt1.setString(1, key);
			        //执行
			        ResultSet info = ptmt1.executeQuery(); 
				%>
				<% if (info.next()) {%>
				<form id="edituserform" class="formcontent" action="checkedit.jsp" method="post" onsubmit="return validate()">
					<p>
						<label> 账号： </label>
						<span><% out.print(info.getString(1));%></span>
					</p>
					<p>
						<label for="nickname"> 昵称：</label>
						<input type="text" name="nickname" value="<% out.print(info.getString(2));%>">
					</p>
					<p>
						<label> 密码：</label>
						<span>******</span>
						<span class="tip"><a href="password.jsp">修改密码</a></span>
					</p>
					<p>
						<input type="submit" name="save" value="保存" class="savebtn">
						<input type="button" name="cancel" value="取消" class="cancelbtn" onclick="window.location.reload()">
					</p>
				</form>		
				<% }%>
			</section>
			<section>
				<h4>我的书单</h4>
				<hr class="line">
				<div class="list">
				<%
			        String sql2 = "SELECT listtitle,listprofile,listid "
			        		+"FROM listtb "
			        		+"WHERE userid=?";  
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
			        //传参
			        ptmt2.setString(1, key);
			        //执行
			        ResultSet lists = ptmt2.executeQuery();  
				%>
				<% while (lists.next()) {%>				
					<div class="list-item">
						<a href="../list/list-item.jsp?key=<%=lists.getString(3)%>">
						<span class="listname"><% out.print(lists.getString(1));%></span>
						</a>
						<p><% out.print(lists.getString(2));%></p>
					</div>
					<hr class="dash">
				</div>
				<% }%>
			</section>
			<section>
				<h4>我的书评</h4>
				<hr class="line">
				<div class="comment">
				<%
			        String sql3 = "SELECT bookname,comment,booktb.bookid "
			        		+"FROM usertb,booktb,user2book "
			        		+"where usertb.userid=user2book.userid "
			        		+"and booktb.bookid=user2book.bookid "
			        		+"and usertb.userid=?";  
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt3 = connection.prepareStatement(sql3);
			        //传参
			        ptmt3.setString(1, key);
			        //执行
			        ResultSet comments = ptmt3.executeQuery(); 
				%>
				<% while (comments.next()) {%>		
					<div class="comment-item">
						<a href="../book/book-item.jsp?key=<%=comments.getString(3)%>">
						<span class="username">评《
							<% out.print(comments.getString(1));%>
						》</span>
						</a>
						<p><% out.print(comments.getString(2));%></p>
					</div>
					<hr class="dash">
				<% }	
					info.close();
					lists.close();
					comments.close();
					ptmt1.close();
					ptmt2.close();
					ptmt3.close();
				%>
				</div>
			</section>
		</article>
	<% }else{%>
       <p>用户尚未登录...</p>
    <% }%>
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