<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>创建书单-读书小站</title>
	<link rel="stylesheet" type="text/css" href="../reset.css">
	<link rel="stylesheet" type="text/css" href="../style.css">
	<link rel="stylesheet" type="text/css" href="../user/user.css">
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
		function validate(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var title = document.forms["createform"]["title"].value;
			var des = document.forms["createform"]["describe"].value;

			if(title=="") {
				alert("主题不能为空！");
				return false;
			}
			if(title.length>50 || des.length>300) {
				alert("长度过长！");
				return false;
			}
			if ( re.test(title) || re.test(des))
			{
				alert("请您不要输入特殊字符和SQL关键字！");
				return false;
			}
			return true;
		}	
	</script>
</head>
<body>
	<header>
		<h2>📖</h2>
		<h3><a href="../home.jsp">读书小站</a></h3>
		<h4><a href="../book/book.jsp">图书</a></h4>
		<h4><a href="list.jsp">书单</a></h4>
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
			<section class="formcontent">
				<h3>创建书单</h3>
				<form id="createform" action="checkcreate.jsp" method="get" onsubmit="return validate()">
					<p>
						<label for="title">主&nbsp&nbsp题 <span style="color:red">*</span></label>
						<input type="text" name="title">
					</p>
					<p>
						<label for="describe">描&nbsp&nbsp述</label>
						<textarea name="describe" rows="4" cols="40"></textarea>
					</p>
					<p>
						<label for="share">分&nbsp&nbsp享</label>
						<input type="checkbox" name="share">
					</p>
					<p>
						<label for="books">书&nbsp&nbsp目</label>
						<p class="tip">图书详情页面可将图书添加到书单</p>
					</p>
					<p>
						<input type="submit" name="create" value="创 建" class="savebtn">
					</p>
				</form>
			</section>
		</article>
	</main>
	<footer>
		<p>©Copyright 6666 by yawei. All rights reversed.</p>
		<p>联系我们：******@qq.com</p>
	</footer>
</body>
</html>