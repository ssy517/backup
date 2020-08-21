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
<body>
<div class="container">


 <H1>my page : 내 정보</H1>  
 <br>
 아이디:<%=mem.getId()%><br>
이름:<%=mem.getName()%><br>
주소:<%=mem.getAddress()%><br>
휴대폰번호:<%=mem.getId()%><br>
이메일:<%=mem.getEmail() %><br>
 
 
<br><br>
<a href="Yhupdate.jsp" >횐 정보수정</a>
<br>
<a href="Yhdelete.jsp" >회원탈퇴</a>

</div>    
<!-- footer--------------------------------------------------------------------------------------- -->
<%@ include file="parts/footer.jsp" %>     
<!-- ----------------------------------------------->
</body>
</html>