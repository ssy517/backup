<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="../parts/header.jsp" %>  
<style type="text/css">
.container{
	padding-top: 140px;
}
.menu {
	float: left;
	margin-left: 250px;
	margin-top: 50px;
}
.menu table{
	width: 200px;
	height: 250px;
	font-size: 16px;
}
.menu tr{
	border-bottom: 1px solid lightgrey;
}
.menu tr:hover{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.menu a{
	text-decoration: none;
	color: black;
}
.menu .active{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.list table{
	margin-top: 50px;
	width: 600px;
    margin-right: 300px;
}
.list table input{
	width: 100%;
}
.list table textarea{
	width: 100%;
    margin-top: 5px;
}
.list table tr{
	border-bottom: 1px solid lightgrey;
	height: 50px;
}
.list table hr{
	border-top: 2px solid #0D6400;
}
.list table th{
	text-align: center;
}
.list table img{
	margin: 5px 0;
}
.container .btn{
   	font-weight: bold;
	background: #0D6400;
	color: #fff;
	border-color: #0D6400;
	min-width: 100px;
	margin: 0 5px;
	margin-bottom: 30px;
}
</style>

</head>


<body>
<%
//가격 표기 함수
DecimalFormat formatter = new DecimalFormat("###,###");
%>
<br><br><br>
<div class="container">
	
	<div class="menu">
		<table>
			<tr><td><a href="authProduct?work=chart">제품차트</a></td></tr>
			<tr class="active"><td><a href="authProduct?work=list">제품관리</a></td></tr>
			<tr><td><a href="">주문관리</a></td></tr>
			<tr><td><a href="Manager?action=list">회원정보관리</a></td></tr>
		</table>
	</div>

	<div class="list" align="center">
		<form action="authProduct?work=update&prd_num=${dto.prd_num}" method="post">
		<table>
			<tr>
				<td colspan="4"><hr style="margin:0;"></td>
			</tr>
			<tr>
				<th>제품번호</th><td>${dto.prd_num}</td>
				<th>제품명</th><td><input type="text" name="name" value="${dto.name}"></td>
			</tr>
			<tr>
				<th>제품이미지</th>
				<td colspan="3">
				<img src="img/prdimg/${dto.img_name}" width="300px">
				</td>
			</tr>
			<tr>
				<th>재고</th><td><input type="text" name="amount" value="${dto.amount}"></td>
				<th>판매량</th><td><input type="text" name="sell" value="${dto.sell}"></td>
			</tr>
			<tr>
				<th>가격</th><td><input type="text" name="price" value="${dto.price}"></td>
				<th>배송비</th><td>${dto.deli_charge}</td>
			</tr>
			<tr>
				<th>규격</th><td><input type="text" name="size" value="${dto.size}"></td>
				<th>원산지</th><td><input type="text" name="origin" value="${dto.origin}"></td>
			</tr>
			<tr>
				<th>보관</th><td><input type="text" name="keep" value="${dto.keep}"></td>
				<th>포장</th><td><input type="text" name="pack" value="${dto.pack}"></td>
			</tr>
			<tr>
				<th>유통기한</th>
				<td colspan="3">
					<textarea name="expdate" rows="4" cols="50">${dto.expdate}</textarea> 
				</td>
			</tr>
			<tr>
				<th>제품설명</th>
				<td colspan="3">
					<textarea  name="info" rows="4" cols="50">${dto.info}</textarea> 
				</td>
			</tr>
			<tr style="border-bottom: 0px solid black">
				<td colspan="4"><hr style="margin:0;"></td>
			</tr>
		</table><br>
		<input class="btn" type="submit" value="수정" style="margin-left: 210px">
		<input class="btn" type="button" onclick="goDelete()" value="삭제">
		</form>
	</div>
	
	
</div>

<script type="text/javascript">
	function goDelete() {
		if (confirm("정말 삭제하시겠습니까??") == true){
			location.href="authProduct?work=delete&prd_num=${dto.prd_num}"
		} else{
			return false;
		}
	}
</script>	
<%@ include file="../parts/footer.jsp" %>  
</body>
</html>