<%@page import="org.apache.commons.collections.map.HashedMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
</style>
</head>
<body>

<%
HashMap<String, Object> mep = (HashMap<String, Object>)request.getAttribute("map");

List<MemberDto> list = (List<MemberDto>)mep.get("list"); 
int bbsPage = (Integer)mep.get("bbsPage");
int pageNumber = (Integer)mep.get("pageNumber");
String choice = (String)mep.get("choice");
String searchWord = (String)mep.get("searchWord"); 
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

<!-- body--------------------------------------------------------------------------------------- -->
<div class="container" align="center">

<h1>관리자 회원목록 게시판</h1>

 
<table>
<col width="100"><col width="300"><col width="300">
	<tr>
		<td align="right" colspan="6">
			<select id="category">
				<option value="sel">선택</option>
				<option value="NAME">이름</option>
				<option value="ADDRESS">주소</option>
			</select>
			<input type="text" id="txt" placeholder="검색어를 입력해주세요">
			<button class="btn" onclick="searchBbs()">검색</button>
	</tr>
	<tr>
		<td height="2" bgcolor="pink" colspan="6"></td>
	</tr>
	<tr>
		<th>번호</th><th>아이디</th><th>이름</th><th>주소</th><th>전화번호</th><th>이메일</th>
	</tr>
	<tr>
		<td height="2" bgcolor="pink" colspan="6"></td>
	</tr>
<%
if(list.size() == 0 ){
%>
	<tr>
		<th>고객의 정보가 없습니다.</th>
	</tr>
	<tr>
		<td height="2" bgcolor="pink" colspan="6"></td>
	</tr>
<%
}else{
	for(int i = 0; i < list.size(); i++){
		MemberDto dto = list.get(i);
		
		/* if(dto.getAuth() == 3){ */
			
%>	
	<tr>
		<td><%=i+1 %></td>
		<td><%=dto.getId() %> </td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getAddress() %></td>
		<td><%=dto.getPhone() %></td>
		<td><%=dto.getEmail() %></td>	
		<th><input type="submit" name="sjbtn" onclick="upbtn('<%=dto.getId() %>')" value="수정">
			<input type="submit" name="szbtn" onclick="delbtn('<%=dto.getId() %>')" value="삭제"> </th>
	</tr>
	<tr>
		<td height="2" bgcolor="pink" colspan="6"></td>
	</tr>
<%
		/* } */
	}
}
%>
</table>
</form>
 
<!-- 페이징 -->
<%
for(int i = 0; i < bbsPage; i++){
	if(pageNumber == i){ // 1 [2] [3]
	//현재 페이지
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold">
			<%=i+1 %>
		</span>&nbsp;
		<%	
	}else{	//그외 페이지
		%>
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none">
			[<%=i+1 %>]
		</a>&nbsp;
		<%
	}
}
%> 

<script type="text/javascript">

function upbtn(id) {
		location.href="Manager?action=inid&id="+id;
}

function delbtn(id) {
	location.href="Manager?action=authdel&id="+id;
}

function searchBbs() {
	let choice = document.getElementById("category").value;
	let word = document.getElementById("txt").value;
	location.href = "Manager?action=list&searchWord="+ word +"&choice="+choice;
}

function goPage( pageNum ) {
	var choice = document.getElementById("category").value;
	var word = document.getElementById("txt").value;
	location.href = "Manager?action=list&searchWord=" + word + "&choice=" + choice + "&pageNumber=" + pageNum;
}

</script>

<!-- 페이지 번호 -->


   
</div>    
<%@ include file="../parts/footer.jsp" %>
</body>
</html>












