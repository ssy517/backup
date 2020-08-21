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


 <H1>my page : 회원탈퇴 페이지 </H1>  
<br>
<form>
<table>
<col><col><col>
	<tr>
		<th><h2>회원탈퇴안내</h2></th>
	</tr>
	<tr>
		<td><%=mem.getName()%>님 안녕하세요! 회원탈퇴를 하기 전 안내사항을 꼭 확인 해 주세요.</td>
	</tr>
	<tr>
	<td>
		<textarea rows="10px" cols="100px" >
		
● 사용하고 계신 아이디: "<%=mem.getId() %>"는 탈퇴 할 경우 아이디 재사용 및 복구가 불가능 합니다.

● 탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제 됩니다.

● 내정보 및 개인형 서비스 이용기록이 모두 삭제되며,삭제된 데이터는 복구되지 않습니다.
    삭제되는 서비스를 확인하시고, 필요한 데이터는 미리 백업을 해주세요.

● 그동안 저희 h&H홈페이지를 이용해주셔서 감사합니다.

</textarea>
</td>
	</tr>	
	<tr>
		<th><input type="checkbox" id="chk" name="chk">회원탈퇴 안내 사항을 모두 확인하였으며, 이에 동의합니다</th>
	</tr>
	<tr>
		<th><input oninput="allcheck()" type="button" id="xxbtn" name="xxbtn" value="H&H 회원탈퇴" ></th>
	</tr>
</table>
</form>
<br><br>
</div>
<%
String id = mem.getId();
System.out.println(id);
%>
<script type="text/javascript">

$(function() {
	$("#xxbtn").click(function() {
		// checkbox는 attr로 사용하면 잘 안되니까 prop으로 사용해주어야 합니다!
		let ischk = $("#chk").prop("checked");
		//console.log(ischk);
		if(ischk){
			 $.ajax({
				type:"post",
				url:'member',
				data: "action=pdel&id=<%=id%>",
				success:function( data ){
					alert('탈퇴되었습니다!');
					location.href='main.jsp';
				},
				error:function(){
					alert("error");
				}
			});//ajax 
		}else{
			alert("안내 사항을 확인하신 후 체크해주시기 바랍니다");
		}
	});
}); 
</script>

    
<!-- footer--------------------------------------------------------------------------------------- -->
<%@ include file="parts/footer.jsp" %>  
</body>
</html>