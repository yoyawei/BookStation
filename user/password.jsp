<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>修改密码-读书小站</title>
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
			var oldp = document.forms["passwordform"]["oldpwd"].value;
			var newp = document.forms["passwordform"]["newpwd"].value;
			var rep = document.forms["passwordform"]["repwd"].value;
			
			if(oldp=="" || newp=="" || rep==""){
				alert("密码不能为空！");
				return false;
			}
			if(newp!=rep) {
				alert("密码不相同！");
				return false;
			}
			if ( re.test(oldp) || re.test(newp) || re.test(rep))
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
	<% if((String)session.getAttribute("Login")=="OK"){%>
		<article>
			<section class="formcontent">
			<h3>修改密码</h3>
				<form id="passwordform" action="checkpwd.jsp" method="post" onsubmit="return validate()">
					<p>
						<label for="oldpwd">当前密码</label>
						<input type="password" name="oldpwd" onCopy="return false" onCut="return false" onPaste="return false">
					</p>
					<p>
						<label for="newpwd">新密码</label>
						<input type="password" name="newpwd" onCopy="return false" onCut="return false" onPaste="return false">
					</p>
					<p>
						<label for="repwd">确认密码</label>
						<input type="password" name="repwd" onCopy="return false" onCut="return false" onPaste="return false">
					</p>
					<p>
						<input type="submit" name="change" value="修 改" class="subbtn">
					</p>
				</form>
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
</body>
</html>
<script> 
//取出传回来的参数error并与yes比较
  var errorid ='<%=request.getParameter("error")%>';
  if(errorid=='0'){
		alert("修改成功！");
  }
  if(errorid=='1'){
	alert("当前密码错误!");
  }
</script>