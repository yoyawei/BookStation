<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>注册-读书小站</title>
	<link rel="stylesheet" type="text/css" href="../reset.css">
	<link rel="stylesheet" type="text/css" href="../style.css">
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
			var user = document.forms["registerform"]["id"].value;
			var pwd = document.forms["registerform"]["pwd"].value;
			var repwd = document.forms["registerform"]["repwd"].value;
			var reg = new RegExp("^[0-9]*$");

			if(user=="") {
				alert("账号不能为空！");
				return false;
			}
			if(!reg.test(user)){
				alert("账号格式错误！请输入数字！");
				return false;
			}
			if(user.length != 11){
				alert("账号长度错误！");
				return false;
			} 
			if(pwd=="" || repwd==""){
				alert("密码不能为空！");
				return false;
			}
			if(pwd!=repwd){
				alert("密码不相同！");
				return false;
			}
			if ( re.test(user) || re.test(pwd) || re.test(repwd))
			{
				alert("请您不要输入特殊字符和SQL关键字！");
				return false;
			}
			if(user!="" && pwd!="" && repwd!=""){
				return true;
			}
		}
	</script>
</head>
<body>
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
       <h4 id="topR"><a href="user.jsp">个人中心</a></h4>
       <% }else{%>
       <h4 id="topR"><a href="login.jsp">登 录</a></h4>
       <% }%>
	</header>
	<main>
		<article>
			<section class="formcontent">
			<h3>注册</h3>
				<form id="registerform" action="checkRegister.jsp" method="post" onsubmit="return validate()">
					<p>
						<label for="id">手机号</label>
						<input type="text" name="id">
					</p>
					<p>
						<label for="pwd">密码</label>
						<input type="password" name="pwd" onCopy="return false" onCut="return false" onPaste="return false">
					</p>
					<p>
						<label for="repwd">确认密码</label>
						<input type="password" name="repwd" onCopy="return false" onCut="return false" onPaste="return false">
					</p>
					<p>
						<input type="submit" name="register" value="注 册" class="subbtn">
					</p>
					<p class="tip">
						<span>已有账号，请点击这里<a href="login.jsp">登录</a></span>
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
<script> 
//取出传回来的参数error并与yes比较
  var errorid ='<%=request.getParameter("error")%>';
  if(errorid=='1'){
   alert("用户已注册！");
  }
</script>