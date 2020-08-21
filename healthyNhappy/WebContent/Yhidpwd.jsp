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


<!-- body--------------------------------------------------------------------------------------- -->
<div class="container">


 <H1>아이디 찾기</H1>  
<form action="member?action=idSearch" method="post">
 이름:<input type="text" id="name" name="name">
 메일:<input type="text" id="email" name="email">
 <input type="submit">
 </form>
 
<br> <br> <br> <br>

<H1>비밀번호 찾기 찾기</H1>  
<form action="member?action=pwdSearch" method="post">
 아이디:<input type="text" id="id" name="id">
 이름:<input id="name" name="name">
 <input type="submit">
 </form>
<br><br>

</div>    
<!-- footer----------------------------------------------------------------------------------------->
<%@ include file="parts/footer.jsp" %>    
<!-- ----------------------------------------------->
</body>
</html>