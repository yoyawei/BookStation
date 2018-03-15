<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>编辑书单-读书小站</title>
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
		function validate1(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var title = document.forms["editform"]["title"].value;
			var des = document.forms["editform"]["describe"].value;

			if(title=="" || des=="") {
				alert("主题、描述不能为空！");
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
		function validate2(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var title = document.forms["deleteform"]["dtitle"].value;

			if(title=="") {
				alert("主题不能为空！");
				return false;
			}
			if ( re.test(title) )
			{
				alert("请您不要输入特殊字符和SQL关键字！");
				return false;
			}
			return true;
		}	
		deleteform
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
        
        //需要获得书单号
        request.setCharacterEncoding("UTF-8");
        String key=request.getParameter("key");
        //需要获得当前用户id
        String userid = (String)session.getAttribute("userid");

    %>
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
				<h3>编辑书单</h3>
				<form id="editform" action="checkedit.jsp" method="post" onsubmit="return validate1()">
				<%
			        String sql1 = "SELECT listtitle,listprofile,listshare "
			        		+"FROM listtb "
			        		+"WHERE userid=? and listid=?";  
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
			        //传参
			        ptmt1.setString(1, userid);
			        ptmt1.setString(2, key);
			        //执行
			        ResultSet list = ptmt1.executeQuery();	
				%>
				<% if (list.next()) {%>
					<p>
						<label for="title">主&nbsp&nbsp题 <span style="color:red">*</span></label>
						<input type="text" name="title" value="<%=list.getString(1)%>">
					</p>
					<p>
						<label for="describe">描&nbsp&nbsp述 <span style="color:red">*</span></label>
						<textarea name="describe" rows="4" cols="40"><%=list.getString(2)%></textarea>
					</p>
					<p>
						<label for="share">分&nbsp&nbsp享</label>
						<% String share=list.getString(3);%>
						<% if(share.equals("1")){%>
						<input type="checkbox" name="share" checked="">
						<% }else{%>
						<input type="checkbox" name="share">
						<% }%>
					</p>
					<p>
					<%
						String sql2 = "SELECT distinct bookname,author,booktb.bookid "
								+"FROM booktb,authortb,book2author,listtb,book2list "
								+"WHERE booktb.bookid=book2author.bookid "
								+"and authortb.authorid=book2author.authorid "
								+"and booktb.bookid=book2list.bookid "
								+"and listtb.listid=book2list.listid "
								+"and listtb.listid=?";  
				        //预编译SQL，减少sql执行
				        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
				        //传参
				        ptmt2.setString(1, key);
				        //执行
				        ResultSet book = ptmt2.executeQuery();
					%> 
						<label for="books">书&nbsp&nbsp目：</label>
					<% while (book.next()) {%>
						<span>
							<br>&nbsp&nbsp&nbsp&nbsp
							《<% out.print(book.getString(1));%>》 by 
							<% out.print(book.getString(2));%>
							<a href="checkbookdel.jsp?bookid=<%=book.getString(3)%>&listid=<%=key%>">删除</a>
						</span>
					<% }
						book.close();
						ptmt2.close();
					%>
						<p class="tip">图书详情页面可将图书添加到书单</p>
					</p>
					<p>
						<input hidden type="text" name="listid" value=<%=key%>>
						<input type="submit" name="create" value="保 存" class="savebtn">
					</p>
				<% }%>
				</form>
			</section>
		</article>
		<aside>
			<section class="formcontent">
				<h3>删除书单</h3>
				<span class="tip" style="color:red"><br>注意： 删除操作不可恢复，请谨慎使用！<br></span>
				<form id="deleteform" action="checkdelete.jsp" method="get" onsubmit="return validate2()">
					<p>
						<label for="dtitle">确认主题</label>
						<input type="text" name="dtitle">
					</p>
					<p>
						<input hidden type="text" name="listid" value=<%=key%>>
						<input hidden type="text" name="userid" value=<%=userid%>>
						<input type="submit" name="delete" value="删 除" class="savebtn">
					</p>
				</form>
			</section>
		</aside>
	</main>
	<footer>
		<p>©Copyright 6666 by yawei. All rights reversed.</p>
		<p>联系我们：******@qq.com</p>
	</footer>
	<% 
		list.close();
		ptmt1.close();
		connection.close();
	%>
</body>
</html>
<script>
//取出传回来的参数error并与yes比较
  var errorid ='<%=request.getParameter("error")%>';
  if(errorid=='1'){
	alert("删除失败!");
  }
</script>