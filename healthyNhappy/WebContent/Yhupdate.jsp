<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>회원정보수정</title>
<%@ include file="parts/header.jsp" %> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

<!-- body--------------------------------------------------------------------------------------- -->
<div class="container" align="center">
<H1>회원정보수정</H1>
<div class="di">
<form action="member?action=update" method="post" ><!-- onsubmit="return checkAll()" -->
<input type="hidden" name="work" value="dataSave">

<table class="font">
<col><col><col>
	 <tr>
 		<th>아이디</th><td><input readonly="readonly" class="input" type="text" id="id" name="id" value="<%=mem.getId() %>"></td>
 	</tr>
 	<tr>
 		 <td></td><td><div class="div" id="idcheck"></div></td>
 	</tr>
	<tr>
 		<th>비밀번호</th><td><input class="input" oninput="pwdcheck1()" type="password" id="pwd1" name="pwd1" placeholder="비밀번호 입력"></td>
	</tr>
 	<tr>
 		<th>비밀번호 확인</th><td><input oninput="pwdcheck2()" class="input" type="password" id="pwd2" name="pwd2" placeholder="비밀번호 확인"></td>
	</tr>
	<tr>
 		 <td></td><td><div id="pwdcheck" class="div"></div></td>
 	</tr>
	<tr>
 		<th>이름</th><td><input value="<%=mem.getName() %>" readonly="readonly" class="input" type="text" id="name1" name="name1" ></td>
					<td><div class="div" id="namecheck"></div>
	</tr>
	<tr>
 		<th>주소</th><td><input value="<%=mem.getAddress() %>" oninput="addcheck()" type="text" readonly="readonly" id="add1" name="add1"></td>
 					<td><button type="button" id="addbtn" class="btn" >주소 검색</button></td>
	</tr>
 	<tr>				
 		<th>상세주소</th><td><input class="input" type="text" id="add2" name="add2" placeholder="상세주소를 입력하세요"></td>
 	</tr>
 	<tr>
 		<th>휴대폰 번호</th><td><input value="<%=mem.getPhone() %>" class="input" type="text" id="num" name="num" placeholder="-빼고 입력하세요."></td>
 	</tr>
 	<tr>
 		<th>이메일</th><td><input value="<%=mem.getEmail() %>" class="input" type="text" id="email" name="email" placeholder="이메일을 입력하세요."></td>
 					<td><div class="div" id="emailcheck"></div></td>
 	</tr>
 	
</table>
<input class="but" type="submit" value="&emsp;수-정(크리스탈)&emsp;">
</form>

</div>  
</div>    


<script type="text/javascript">

function pwdcheck1() {	/* 비밀번호 설정 */
	
	let ipCheck = /^[a-zA-Z0-9]{4,12}$/;
	
	 if (pwd1.value == ""){
		 $("#pwdcheck").css("color", "#ff0000");
		 $("#pwdcheck").text('비밀번호를 입력해 주세요!');	
		pwd1.focus();
	 }else if(!ipCheck.test(pwd1.value)){
		 $("#pwdcheck").css("color", "#ff0000");
		 $("#pwdcheck").text('비밀번호는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!');	
		 pwd1.focus();
	 }else if(pwd1.value == id.value){
			$("#pwdcheck").css("color", "#0000ff");
			$("#pwdcheck").text('아이디와 같은 비밀번호는 사용불가능 합니다.'); 
			$("#pwd1").val("");
			pwd1.focus();
	 }else{
		 $("#pwdcheck").css("color", "#ff0000");
		 $("#pwdcheck").text('사용 가능한 비밀번호 입니다!');	 
	 }
}

function pwdcheck2(){	/* 비밀번호 확인 */
	
	if(pwd1.value != pwd2.value){
	//alert('비밀번호가 일치하지 않습니다!');
	$("#pwdcheck").css("color", "#ff0000");
	$("#pwdcheck").text('비밀번호가 일치하지 않습니다');	
}else if(pwd1.value == pwd2.value){
	$("#pwdcheck").css("color", "#0000ff");
	$("#pwdcheck").text('비밀번호가 일치합니다');
 }else{
	 $("#pwdcheck").val("");
 }
}

 function namecheck() {
	
	let namecheck= /^[가-힣]{2,5}$/;
	
	if(!namecheck.test(name1.value)){
		//alert('이름형식에 맞지 않습니다. 다시 입력해 주세요');
		$("#namecheck").css("color", "#0000ff");
		$("#namecheck").text('이름형식에 맞지 않습니다. 다시 입력해 주세요'); 
		 name1.focus();
	}else{
		$("#namecheck").css("color", "#0000ff");
		$("#namecheck").text('가능'); 
	}
} 
function emailcheck() {
	
	let emailcheck = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(!emailcheck.test(email.value)){ 
		$("#emailcheck").css("color", "#0000ff");
		$("#emailcheck").text('메일형식에 맞지 않습니다. 다시 입력해 주세요'); 
		 email.focus();
	}else{
		$("#namecheck").css("color", "#0000ff");
		$("#emailcheck").text('가능'); 
		}
}

function checkAll() { //회원가입으로 넘기기전에 마지막으로 검사하는 함수

	if ($("#id").val() == ""){
		 alert("아이디 입력하세요!");
		 id.focus();
		 return false
	}else if ($("#pwd1").val() == ""){
		 alert("비밀번호를 입력하세요!");
		 pwd1.focus();	 
		 return false
	}else if ($("#pwd2").val() == ""){
		 alert("비밀번호 확인하세요!");
		 pwd2.focus();
		 return false
	}else if ($("#name1").val() == ""){
		 alert("이름을 입력하세요!");
		 name1.focus();	
		 return false
	}else if ($("#add1").val() == ""){
		 alert("주소를 검색해서 입력하세요!");
		 add1.focus();	
		 return false
	}else if ($("#add2").val() == ""){
		 alert("상세주소를 입력하세요!");
		 add2.focus();	
		 return false
	}else if ($("#num").val() == ""){
		 alert("휴대폰 번호를 입력하세요!");
		 num.focus();
		 return false
	}else if ($("#email").val() == ""){
		 alert("메일을 입력하세요!");
		 email.focus();
		 return false
	}
}
	
</script>

<script>
$("#addbtn").click(function(addSearch) { /* 주소검색 */
    new daum.Postcode({
        oncomplete: function(data) {
            $("#add1").val(data.address);
        }
    }).open();
});
</script>

<!-- footer--------------------------------------------------------------------------------------- -->
 <%@ include file="parts/footer.jsp" %> 
<!-- --------------------------------------------- -->
</body>
</html>