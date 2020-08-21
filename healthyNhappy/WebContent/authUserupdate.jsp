<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>회원정보수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
/* 헤더 푸터 ------------------------------------------------------------------------ */

   /* Add some padding on document's body to prevent the content
    to go underneath the header and footer */
    body{        
        padding-top: 60px;
        padding-bottom: 40px;
    }
    .container{
        width: 80%;
        margin: 0 auto; /* Center the DIV horizontally */
    }
    .fixed-header, .fixed-footer{
        width: 100%;
        position: fixed;        
        background: #fff;
        padding: 10px 0; 
        margin-right: 20px;
        color: black;
    }
    .fixed-header{
        top: 0;
    }
    .fixed-footer{
        bottom: 0;
        background: #8AC47A;
        font-size: 12px;
    }    
    /* Some more styles to beutify this example */
    nav a{
        color: #fff;
        text-decoration: none;
        padding: 7px 25px;
        display: inline-block;
    }
    .container p{
        line-height: 200px; /* Create scrollbar to test positioning */
    }
/* --------------------------------------------------------------------------------- */
/* 여기부터 사용하세요 */

.di{
cborder-style: double;
border-color: white;
border: "2";
background-color: #8AC47A;
border-radius: 30%;
border-radius: 5px;
width: 600px; 
height: 600px;
}
.font{
color: #ffffff;
}
.div{
font-size: 8px;
color: white;
}

/* --------------------------------------------------------------------------------- */
/* 여기부터 사용하세요 */

</style>
</head>
<body>

<%
MemberDto dto = (MemberDto)request.getAttribute("dto1");
System.out.println("....너 뭐야"+dto);
%>
  
<!-- header--------------------------------------------------------------------------------------- -->
  
    <div class="fixed-header">
     <header>
    <div align="right">
	    <table style="margin-right: 20px; color: #0B6138" >
	    <tr>
	    	<td onclick="location.href='login.jsp'" style="cursor:pointer;">로그인</td>
	    	<td onclick="location.href='regi.jsp'" style="cursor:pointer;">회원가입</td>
	    	<td>장바구니</td>
	    	<td>마이페이지</td>
	    </tr>
	    </table>
	</div>
    </header>
    <div align="center" style="height: 70px; margin: 50px auto;">
    	<img alt="" src="./logo/HEALTHYNHAPPY.png" height="50px" align="center"><br>
    	<img alt="" src="./logo/HEALTHYNHAPPY_1.png" height="30px" align="center">
    </div>
        <div class="container" align="center" style="background-color: #8AC47A">
            <nav>
                <a href="#">회사소개</a>
                <a href="#">제품보기</a>
                <a href="#">배송안내</a>
                <a href="#">웰빙스토리</a>
                <a href="#">Q&A</a>
            </nav>
        </div>
    </div>
       
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    

<!-- body--------------------------------------------------------------------------------------- -->
<div class="container" align="center">
<H1>회원정보수정</H1>
<div class="di">
<form action="Manager?action=userupdate" method="post" ><!-- onsubmit="return checkAll()" -->
<table class="font">
<col><col><col>
	 <tr>
 		<th>아이디</th><td><input readonly="readonly" class="input" type="text" id="id" name="id" value="<%=dto.getId() %>"></td>
 	</tr>
	<tr>
 		<th>이름</th><td><input value="<%=dto.getName() %>" readonly="readonly" class="input" type="text" id="name1" name="name1" ></td>
					<td><div class="div" id="namecheck"></div>
	</tr>
	<tr>
 		<th>주소</th><td><input value="<%=dto.getAddress() %>" oninput="addcheck()" type="text" readonly="readonly" id="add1" name="add1"></td>
 					<td><button type="button" id="addbtn" class="btn" >주소 검색</button></td>
	</tr>
 	<tr>				
 		<th>상세주소</th><td><input class="input" type="text" id="add2" name="add2" placeholder="상세주소를 입력하세요"></td>
 	</tr>
 	<tr>
 		<th>휴대폰 번호</th><td><input value="<%=dto.getPhone() %>" class="input" type="text" id="num" name="num" placeholder="-빼고 입력하세요."></td>
 	</tr>
 	<tr>
 		<th>이메일</th><td><input value="<%=dto.getEmail() %>" class="input" type="text" id="email" name="email" placeholder="이메일을 입력하세요."></td>
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
    <div class="fixed-footer">
        <div class="container" align="center">
        	<table>
        		<tr>
        			<td>Copyright &copy; 2020 HEALTHY&HAPPY All rights reserved </td>
        			<td>대표번호: 02-3453-5404</td>
        			<td>서울시 강남구 테헤란로5길 11 YBM빌딩 2층</td>
        		</tr>
        	</table>
        </div>        
    </div>
<!-- --------------------------------------------- -->
</body>
</html>