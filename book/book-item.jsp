<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">

	<link rel="shortcut icon" href="../images/logo.ico"/>
	<title>书名-读书小站</title>
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
		function validate1(){
			var tolist = document.forms["tolistform"]["tolist"].value;

			if(tolist=="-1") {
				return false;
			}
			return true;
		}		
		function validate2(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var tag = document.forms["tagform"]["tag"].value;

			if(tag=="") {
				alert("标签不能为空！");
				return false;
			}
			if(tag.length > 15){
				alert("标签过长！");
				return false;
			}
			if ( re.test(tag) )
			{
				alert("请您不要输入特殊字符和SQL关键字！");
				return false;
			}
			return true;
		}
		function validate3(){
			re=  /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
			var comment = document.forms["commentform"]["commentcontent"].value;

			if(comment=="") {
				alert("评论不能为空！");
				return false;
			}
			if(comment.length > 500){
				alert("评论过长！");
				return false;
			}
			if ( re.test(comment) )
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
        
        //需要获得书号
        request.setCharacterEncoding("UTF-8");
        String key=request.getParameter("key");
        //需要获得当前用户id
        String userid = (String)session.getAttribute("userid");
        
        int count;
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
       <h4 id="topR"><a href="../user/user.jsp">个人中心</a></h4>
       <% }else{%>
       <h4 id="topR"><a href="../user/login.jsp">登 录</a></h4>
       <% }%>
	</header>
	<main>
		<article>
			<section class="book-detail">
			<%
				String sql1 ="SELECT bookname,author,authortb.authorid,bookimg "
						+"FROM booktb,authortb,book2author "
						+"WHERE booktb.bookid=book2author.bookid "
						+"and authortb.authorid=book2author.authorid "
						+"and booktb.bookid=?"; 
		        //预编译SQL，减少sql执行
		        PreparedStatement ptmt1 = connection.prepareStatement(sql1);
		        //传参
		        ptmt1.setString(1, key);
		        //执行
		        ResultSet book1 = ptmt1.executeQuery();
			%>
			<% while (book1.next()) {%>  
				<img src="../<%=book1.getString(4)%>" alt="图书封面">
				<h2><% out.print(book1.getString(1));%></h2>
				<a href="author.jsp?key=<%=book1.getString(3)%>"><p><% out.print(book1.getString(2));%></p></a>
			<% }book1.close();%>
				<div class="tag">
				<%
					String sql2 ="SELECT tag,tagtb.tagid "
							+"FROM booktb,tagtb,book2tag "
							+"WHERE booktb.bookid=book2tag.bookid "
							+"and tagtb.tagid=book2tag.tagid "
							+"and booktb.bookid=?"; 
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt2 = connection.prepareStatement(sql2);
			        //传参
			        ptmt2.setString(1, key);
			        //执行
			        ResultSet tag = ptmt2.executeQuery();
				%>
				<% while (tag.next()) {%>
					<a href="tagresult.jsp?q=<%=tag.getString(2)%>">
						<div class="tagstyle"><% out.print(tag.getString(1));%></div>
					</a>
				<% }tag.close();%>
				</div>
				<% 
					String sql3 ="SELECT bookprofile "
							+"FROM booktb,authortb,book2author "
							+"WHERE booktb.bookid=book2author.bookid "
							+"and authortb.authorid=book2author.authorid "
							+"and booktb.bookid=?"; 
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt3 = connection.prepareStatement(sql3);
			        //传参
			        ptmt3.setString(1, key);
			        //执行
			        ResultSet book2 = ptmt3.executeQuery();
				%>
				<% while (book2.next()) {%>
				<span><% out.print(book2.getString(1));%></span>
				<% }book2.close();%>
			</section>
			<section class="addcontent">
			<% if((String)session.getAttribute("Login")=="OK"){%>
				<form id="tolistform" action="checklist.jsp" method="post" onsubmit="return validate1()">
					<p>
					<%
				        String sql6 = "SELECT listtb.listid,listtitle "
				        		+"FROM listtb "
				        		+"WHERE userid=?";  
				        //预编译SQL，减少sql执行
				        PreparedStatement ptmt6 = connection.prepareStatement(sql6);
				        //传参
				        ptmt6.setString(1, userid);
				        //执行
				        ResultSet mylist = ptmt6.executeQuery();
				        
				        count=0;
					%>
						<select class="selectlist" name="tolist">
							<option selected value="-1">=请选择书单=</option>
							<% while (mylist.next()) {%>
							<option value="<%=mylist.getString(1)%>">
								<%out.print(++count);%>.
								<%out.print(mylist.getString(2));%>
							</option>
							<% }		
								mylist.close();
								ptmt6.close();
							%>
						</select>
						<input hidden type="text" name="bookid" value=<%=key%>>
						<input type="submit" name="addtolist" class="addbtn" value="添加到书单" style="width:100px">						
					</p>
				</form>
				<form id="tagform" action="checktag.jsp" method="post" onsubmit="return validate2()">
					<p>
						<input type="text" name="tag" placeholder="标签名">
						<input hidden type="text" name="bookid" value="<%=key%>">
						<input type="submit" name="addtag" class="addbtn" value="添 加">						
					</p>
				</form>
				<form id="commentform" action="checkcomment.jsp" method="post" onsubmit="return validate3()">
					<p>
						<textarea name="commentcontent" placeholder="评论内容" rows="5" cols="125"></textarea>
					</p>
					<input hidden type="text" name="bookid" value=<%=key%>>
					<p>
						<input type="submit" name="addcomment" class="addbtn" value="发 表">
					</p>
				</form>
			<% }else{%>
			<p>用户未登录...</p>
			<p>登录后可对书籍添加标签、发表评论</p>
			<% }%>
			</section>
			<section>
				<h4>相关评论</h4>
				<hr class="line">
				<div class="comment">
				<% 
					String sql4 ="SELECT nickname,comment "
							+"FROM usertb,booktb,user2book "
							+"WHERE usertb.userid=user2book.userid "
							+"and booktb.bookid=user2book.bookid "
							+"and booktb.bookid=?"; 
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt4 = connection.prepareStatement(sql4);
			        //传参
			        ptmt4.setString(1, key);
			        //执行
			        ResultSet comments = ptmt4.executeQuery();
			        
			        count=0;
				%>
				<% while (comments.next()) {%>
					<div class="comment-item">
						<span class="username"><% out.print(comments.getString(1));%> ：</span>
						<p><% out.print(comments.getString(2));%></p>
					</div>
					<hr class="dash">
				<% count++; }comments.close();%>
				</div>
				<% if(count==0){%>
				<p>暂无书评...</p>
				<% }%>
			</section>
			<section>
				<h4>所在书单</h4>
				<hr class="line">
				<div class="list">
				<% 
					String sql5 ="SELECT distinct nickname,listtitle,listprofile,listtb.listid "
							+"FROM usertb,booktb,listtb,book2list "
							+"WHERE usertb.userid=listtb.userid "
							+"and booktb.bookid=book2list.bookid "
							+"and listtb.listid=book2list.listid "
							+"and booktb.bookid=?"; 
			        //预编译SQL，减少sql执行
			        PreparedStatement ptmt5 = connection.prepareStatement(sql5);
			        //传参
			        ptmt5.setString(1, key);
			        //执行
			        ResultSet lists = ptmt5.executeQuery(); 
			        
			        count=0;
				%>
				<% while (lists.next()) {%>
					<div class="list-item">
						<span class="username"><% out.print(lists.getString(1));%></span>
						&nbsp&nbsp&nbsp-
						<a href="../list/list-item.jsp?key=<%=lists.getString(4)%>">
							<span class="listname"><% out.print(lists.getString(2));%></span>
						</a>
						<p><% out.print(lists.getString(3));%>
					<hr class="dash">
				<% count++; }lists.close();%>
				</div>
				<% if(count==0){%>
				<p>暂无书单...</p>
				<% }%>
			</section>
		</article>
	</main>
	<footer>
		<p>©Copyright 6666 by yawei. All rights reversed.</p>
		<p>联系我们：******@qq.com</p>
	</footer>
	<% 
		ptmt1.close();
		ptmt2.close();
		ptmt3.close();
		ptmt4.close();
		ptmt5.close();
		connection.close();
	%>
</body>
</html>
<script> 
//取出传回来的参数error并与yes比较
  var errorid ='<%=request.getParameter("error")%>';
  if(errorid=='0'){
	alert("成功！");
  }
  if(errorid=='1'){
	alert("该图书已存在!");
  }
  if(errorid=='2'){
	alert("标签已存在！");
  }
</script>