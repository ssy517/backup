<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- CSS -->
<style>

.log{
border: 1px solid green;
width:500 ;
height:200;
border-style: outset;
}
.ta{
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }


</style>

<head>
<meta charset="utf-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<script src="jquery.cookie.js"></script>  

</head>
<body>

<!-- body--------------------------------------------------------------------------------------- -->
<div class="container" align="center">

<br><br>

<h1>로그인</h1>

<div class="log">

<br><br>

<form action="member?action=login" method="post" name="frm" id="frm">
<table class="ta">
<col><col><col>
<div class="div">
	<tr >
		<th>아이디</th><th><input id="id" name="id" type="text" placeholder="ID를 입력하세요" ></th>
	</tr>
	<tr>
		<th>비밀번호</th><th><input id="pwd" name="pwd" " type="password" placeholder="비밀번호를 입력하세요"></th>
	</tr>
		<th colspan="3" align="center"><input class="but" type="button" id="loginbtn" style="cursor:pointer;" value="로그인"></th>
	<tr>
		<td><input type="checkbox" id="idck" name="idck" >아이디 저장</td> <td> 
		<a href='Yhidpwd.jsp'>아이디, 비밀번호 찾기</a></td>
	</tr>
	<tr>
		<td>아직 H&H 회원이 아니신가요?</td>
</div>
		<td onclick="location.href='Yhregi.jsp'" style="cursor:pointer;" align="right">회원가입</td>
		<td></td>
	</tr>

</table>
</form>

</div>

</div>   
 <script type="text/javascript">
 
/* 로그인 빈칸체크 */
 $("#loginbtn").click(function() {
	if($("#id").val().trim() == "" ){
		alert('아이디를 입력하세요!');
		$("#id").focus();
	}else if($("#pwd").val().trim() == ""){
		alert('비밀번호를 입력하세요!');
		$("#pwd").focus();
	}else{
		$("#frm").submit();
	}
 });

/* id체크 */
 
let user_id = $.cookie("user_id");	// cookie를 산출
if(user_id != null){			
	$("#id").val( user_id );
	$("#idck").attr("checked", "checked");
}

$("#idck").click(function () {	
	if( $("#idck").is(":checked") ){	// 첵크되었을 때 on
		if( $("#id").val().trim() == "" ){
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'/' } );
		}
	}
	else{

		$.removeCookie("user_id", { path:'/' });
	}
});
</script>
   
    
<!-- footer--------------------------------------------------------------------------------------- -->
 
<!-- --------------------------------------------- -->
</body>
</html>

    