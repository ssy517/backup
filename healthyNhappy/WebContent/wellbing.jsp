<!DOCTYPE html>
<%@page import="dto.WbBbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	List<WbBbsDto> list = (List<WbBbsDto>) request.getAttribute("searchlist");
	String searchWord = (String)request.getAttribute("searchWord");
	String choice = (String)request.getAttribute("choice");
	int pageNumber = (int)(request.getAttribute("pageNumber"));// 현재 페이지
	int wbBbsPage = (int)(request.getAttribute("wbBbsPage")); // 페이지 번호
	int auth = 1;

%>

<html>
<head>
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp"%>
<style type="text/css">
.fixed-footer{
    	width: 100%;
    	height: 200px;
        padding: 60px 0; 
        color: white;
        background: #0D6400;
        font-size: 12px;
        font-family: 'Open Sans', 'Nanum Gothic', sans-serif;
    }
    
    .fixed-footer td{
    	padding-bottom: 5px;
    }
    .left1{
    	float: left;
    	padding-left: 100px;
    } 
    .right1{
    	float: left;
    	margin-left: 200px;
    } 
</style>

</head>
<body>


<div class="container">



	<div class="content" id="opinioncontent">
		<h2 class="tit-content" align="center" > 웰빙 스토리 게시판
		</h2>


		<%--<input type="hidden" name="tail" value="detailView"> --%>
		<table  border="1"  class="table">
			<col width="100"> <col width="600"><col width="130"> <col width="155">

			<tr>
				<th>번호</th><th>제목</th><th>작성자</th><th>작성일</th>
			</tr>
			<%
				if(list== null || list.size() == 0){
			%>
			<tr>
				<td colspan="4" align="center"> 작성된 글이 없습니다.</td>
			</tr>
			<%
			}else{

				for (int i = 0; i < list.size(); i++) {
					WbBbsDto wbs = list.get(i);

			%>
			<tr>
				<th><%=i+1 %></th>

				<td>
					<%
						if(wbs.getDel() ==0){
					%>
					<a href="wbbbs?write=detailView&seq=<%=wbs.getSeq() %>">
						<%=wbs.getTitle() %>

					</a>
					<%
					}else{
					%>
					<font color="#ff0000">******** 이글은 작성자에 의해 삭제 되었습니다. </font>
					<%
						}
					%>
				</td>
				<td align="center"><%=wbs.getId() %> </td>
				<td align="center"><%=wbs.getWdate() %></td>
			</tr>
			<%
					}
				}
			%>
		</table>
		<%
	for(int i =0; i<wbBbsPage; i++){
		if(pageNumber == i){
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i+1 %>
		</span>
		<%
			}
		else{
		%>
		<a href="#" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
				style="font-size:  15pt; color: #000; font-weight: bold; text-decoration: none">
			[<%=i+1 %>]
		</a>
		<%
			}
			}
		%>
	<% if(auth ==1) {%>
		<div align="center">
			<a href = "wbbbs?write=addView" > 글쓰기 </a>
		</div>
		<%
			}else{
		%>
		<%}%>
	</div>
	<br>
	<form action="wbbbs" method="get">
		<input type="hidden" name="write" value="choice">
		<div align="center">
			<select id="choice" name="choice" >
				<option value="sel">선택</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="content">내용</option>
			</select>

			<input type="text" id="search" name="search" value="<%=searchWord %> ">
			<input type="submit" value="검색">
		</div>
	</form>
	<script type="text/javascript">





		function  searchWbBbs(){
			var choice = document.getElementById("choice").value;
			var word = document.getElementById("search").value;

			location.href = "wbbbs?write=choice&search=" +word + "&choice=" + choice;
		}

		function goPage( pageNum ){
			console.log(pageNum);
			let choice = document.getElementById("choice").value;
			let word =document.getElementById("search").value;

			location.href = "wbbbs?write=choice&search=" +word + "&choice=" + choice + "&pageNumber=" + pageNum;
			//location.href = "main?search=" +word ;
		}
	</script>















<%@ include file="parts/footer.jsp"%>
</div>
</body>
</html>