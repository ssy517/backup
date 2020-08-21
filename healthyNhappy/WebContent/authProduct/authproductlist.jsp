<%@page import="java.util.HashMap"%>
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
	width: 800px;
	margin-right: 400px;
	margin-top: 80px;
	margin-bottom: 20px;
}
.list table tr{
	border-bottom: 1px solid lightgrey;
	height: 40px;
}
.list table tr:hover{
	background-color: lightgrey;
}
.list table th{
	text-align: center;
	background-color: #F0F0F0;
}
.list a{
	text-decoration: none;
	color: black;
}
.btn a{
   	text-decoration: none;
   	color: #fff;
}
.container .btn{
   	font-weight: bold;
	background: #0D6400;
	border-color: #0D6400;
	min-width: 150px;
	margin-right: 550px;
	margin-top: 30px;
	float: right;
}
.paging span{
	font-size: 16px;
	font-weight: bold;
}
.paging a{
	text-decoration: none;
	font-size: 14px;
	color: grey;
	font-weight: bold;
}
</style>
</head>


<body>
<%

//가격 표기 함수
DecimalFormat formatter = new DecimalFormat("###,###");

HashMap<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
List<ProductDto> list = (List<ProductDto>)map.get("list");
int bbsPage = (Integer)map.get("bbsPage");
int pageNumber = (Integer)map.get("pageNumber");
String choice = (String)map.get("choice");
String searchWord = (String)map.get("searchWord");
%>

<script type="text/javascript">
$(document).ready(function() {
	let searchWord = "<%=searchWord %>";
	if(searchWord == "") return; 
	
	document.getElementById("category").value = "<%=choice%>";
	document.getElementById("category").setAttribute("selected", "selected");
	document.getElementById("txt").value = "<%=searchWord%>";
	
});


</script>
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
	<div class="btn">
			<a href="authProduct?work=addview">제품추가</a>
		</div>
	<div class="list" align="center">
		<table style="text-align: center">
			<col width="100px"><col width="230px">
			<tr>
				<th>제품번호</th><th>제품명</th><th>가격</th><th>재고</th><th>판매량</th><th>상태</th>
			</tr>
			<%
			for(int i=0; i< list.size(); i++){
			%>
				<tr onclick="goDetail(<%=list.get(i).getPrd_num()%>)">
					<td><%=list.get(i).getPrd_num() %></td>
					<td>
						<%=list.get(i).getName() %></td>
					<td><%=formatter.format(list.get(i).getPrice()) %></td>
					<td><%=list.get(i).getAmount() %></td>
					<td><%=list.get(i).getSell() %></td>
					<%
					if(list.get(i).getDel() == 1){
					%>
						<td>삭제</td>
					<%		
					}else if(list.get(i).getAmount() == 0){
					%>
						<td>품절</td>
					<%		
					}else if(list.get(i).getDel() == 0){
					%>
						<td>판매중</td>
					<%	
					}
					%>
				</tr>
			<%	
			}
			%>
			
		</table>
	</div>
	
	<!-- 페이징 -->
	<div class="paging" align="center">
	<%
	for(int i = 0; i < bbsPage; i++){
		if(pageNumber == i){ // 1 [2] [3]
		//현재 페이지
			%>
			<span>
				<%=i+1 %>
			</span>&nbsp;
			<%	
		}else{	//그외 페이지
			%>
			<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)">
				<%=i+1 %>
			</a>&nbsp;
			<%
		}
	}
	%>
	</div>	
	
	<!-- 검색 -->
	<br>
	<div align="center" style="margin-bottom: 30px;">
		<table style="width: 500px">
			<tr>
				<td colspan="3" align="center">
					<select id="category">
						<option value="sel">선택</option>
						<option value="prd_num">제품번호</option>
						<option value="prd_name">제품명</option>
					</select>
					<input type="text" id="txt" >
					<button onclick="searchBbs()">검색</button>
				</td>
			</tr>
		</table>
	</div>
</div>

<script type="text/javascript">
function goDetail(prd_num) {
	location.href = "authProduct?work=detail&prd_num=" + prd_num;
}

function searchBbs() {
	var choice = document.getElementById("category").value;
	var word = document.getElementById("txt").value;
	location.href = "authProduct?work=list&searchWord=" + word + "&choice=" + choice;
}

function goPage( pageNum ) {
	var choice = document.getElementById("category").value;
	var word = document.getElementById("txt").value;
	location.href = "authProduct?work=list&searchWord=" + word + "&choice=" + choice + "&pageNumber=" + pageNum;
}

</script>

<%@ include file="../parts/footer.jsp" %>  
</body>
</html>