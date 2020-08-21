<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

 <%
 String id = (String)request.getAttribute("id");
 System.out.println("가져온 아이디:"+id);

 String pwd = (String)request.getAttribute("pwd");
 System.out.println("가져온 비밀번호:"+pwd);
 %>

<!-- body--------------------------------------------------------------------------------------- -->
<div class="container">

<%
if(pwd == null){
%>
<table>
<col><col>
	<tr>
		<th colspan="2">아이디를 찾았습니다!</th>
	</tr>
	<tr>
		<th>아이디:</th><th>[ <%=id %> ]</th>
	</tr>
	<tr>
		<th onclick="location.href='Yhidpwd.jsp'">비밀번호 찾기</th>
		<th onclick="location.href='Yhlogin.jsp'">로그인 하러 가기!</th>
	</tr>
</table>
<%}else{%>
<table>
<col><col>
	<tr>
		<th colspan="2">비밀번호를 찾았습니다!</th>
	</tr>
	<tr>
		<th>비밀번호:</th><th>[ <%=pwd %> ]</th>
	</tr>
	<tr>
		<th onclick="location.href='Yhlogin.jsp'"><input>로그인 하러 가기!</th>
	</tr>
</table>
<%	
}
%>



</div>    
<!-- footer--------------------------------------------------------------------------------------- -->
<%@ include file="parts/footer.jsp" %>
<!-- ----------------------------------------------->
</body>
</html>