<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.QnaBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//ss에 저장된Dto정보를 가져옴

//MemberDto mem = (MemberDto)session.getAttribute("login"); 
//선택한 항목과 키워드 데이터, 없으면 CHOICE,""
String category = request.getAttribute("category")+"";
String keyword = request.getAttribute("keyword")+"";


// db에 저장된 게시물
@SuppressWarnings("unchecked")
List<QnaBbsDto> list =(List<QnaBbsDto>)request.getAttribute("QAlist");

// db에 저장된 게시물의 갯수
int QABbs_len = (int)request.getAttribute("QABbs_len");


// 선택한 페이지
int currPage = (int)request.getAttribute("currPage");


// 첫 번째 페이지, 마지막 페이지
int startPage = (int)request.getAttribute("startPage");
int lastPage = (int)request.getAttribute("lastPage");




%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="QAcss/QA.css?after" />	

 	
 
</head>
<body>

  



<!-- body--------------------------------------------------------------------------------------- -->
<div class="container">
<img alt="" src="img/main/07.jpg">    
<div align="center" style="margin-top:20px"></div>



<div align = "center">
<form  action="bbs?work=delcheck" id="QAfrm" method="post">
	<table class="alt">
<%

if(mem != null && mem.getAuth() == 1){
%>
		<col width="50">

<%
}
%>
		<col width="40"> <col width="650"><col width="80"> <col width="70"> <col width="60"> <col width="160">
		<thead>
		<tr>
		<td colspan="7" style="text-align: left"><%=currPage+1 %>/<%=QABbs_len %>&nbsp;페이지</td>
		</tr>
		<tr >
<%

if(mem != null && mem.getAuth() == 1){

%>
		
		
			<th> <input type="checkbox" name="alldel" onclick="deletechecks(this.checked)" > </th>
<%
}
%>
			<th>번호</th>
			<th>제목</th>
			<th>답변상태</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성날짜</th>
		</tr>
		
	
		</thead>

<% 
// 등록된 게시물이 없을 때
if(list.size() == 0){

%>

		<tr>
			<td colspan="7" align="center">게시된 글이 없습니다.</td>
		</tr>
		


<%
// 등록된 게시물이 있을 때
}else{
	
	for(int i = 0; i < list.size(); i++){
		
		QnaBbsDto qdto = list.get(i);
		String status = "";
		
		// 삭제된 게시물이 아닐 때
		if(qdto.getDel() == 0){	
			// 게시물의 답변상태 확인
			if(qdto.getStatus() == 1){
				status ="<font color='blue'>답변완료</font>";
			}else{
				status ="<font color='#ff6600'>답변대기</font>";
			}
%>	
	<tbody>
		<tr>
	<%
	if(mem != null && mem.getAuth() == 1){
	%>	
			<td  style="text-align: center;"> <input type="checkbox" name="delcheck" value="<%=qdto.getSeq() %>" >	
	<%
	}
	%>	
			<td  ><%=(i+1) %></td>
		
		
<%
		// 비공개글일 때
		if(qdto.getOpen() == 1){
			// 작성자나 관리자일 때 상세정보페이지 보기가능
			if(mem != null && (mem.getId().equals(qdto.getId()) || mem.getAuth() == 1)){

%>
			<td class="title">
			<a href="main?work=QAdetailView&seq=<%=qdto.getSeq() %>&filename=<%=qdto.getFilename()%>" class="bbs">
			<%=qdto.getTitle() %>
			
			</a>
			<img src="./img/icon/QAlock.png" style=" vertical-align: -9%;" >
			<%
			if(qdto.getFilename() != null && !qdto.getFilename().equals("")){
			%>
			<img src="./img/icon/content_img.png" style=" vertical-align: text-bottom;" >
			
			<%
			}
			%>
			</td>
		
		
<%
			}
			// 그외 사용자는  불가능
			else{
%>
		
			<td class="title">
			비공개글입니다.
			<img src="./img/icon/QAlock.png" style=" vertical-align: -9%;" >
			</td>

<%		
			}
		// 공개글일 때	
		}else{
		%>
		<td class="title">
			<a href="main?work=QAdetailView&seq=<%=qdto.getSeq() %>&filename=<%=qdto.getFilename()%>" class="bbs">
			<%=qdto.getTitle() %>
			</a>
			<%
			if(qdto.getFilename() != null && !qdto.getFilename().equals("")){
			%>
			<img src="./img/icon/content_img.png" style=" vertical-align: text-bottom;" >
			
			<%
			}
			%>
		</td>
	<%	
	}
%>
			<td><%=status %></td>
			<td><%=qdto.getId() %></td>
			<td><%=qdto.getReadcount() %></td>
			<td><%=qdto.getWdate() %></td>
		</tr>
<%
		// 삭제된 게시물일 때
		}else{
			
			%>
			<tr>
				<td colspan="7" class="bbs">관리자에 의해 삭제된 글입니다.</td>
			</tr>
		
			<%		
		}
	}
}
%>
	</tbody>
	
	
	<tfoot>
<%
if(mem != null && mem.getAuth() == 1){
	%>
		<tr>	
			<td style="padding-top: 7px"><button type="button" class="button primary" id="chDelBtn">삭제</button></td>
		</tr>
	<%
	}

%>	
	
	
	</tfoot>
	
	
	</table>

	
</form>

	


<%

if(mem != null){
%>
<a href="main?work=QAWriteView" class="bbs">글작성</a>  

<%}
%>

</div>




</div> 

<br>


<!--  페이지 번호 -->


<div>
	<ul class="pagination">
		<li><a href="#" onclick="goPage(0)"  class="page bbs">처음</a></li>
			
	 
			
		<li><a href="#" onclick="goPage(<%=(currPage-1)%>)"  class="page bbs">앞으로</a></li>
		<%
	
	for(int i = startPage; i < lastPage + 1 ; i++){

		if(currPage == i){
		%>			 
		
			<li>
			<a href="#" class="page active">
			<%=(i+1) %>
			</a>
			</li>
			
	<%
				
		}else{
			%>
			<li>
				<a href="#" onclick="goPage(<%=i%>)" class="page bbs">
				<%=(i+1) %>
				</a>
			</li>
			<%
		}
	}	
	%>
		<li>
			<a href="#" onclick="goPage(<%=(currPage+1)%>)"  class="page bbs">다음</a>
		</li>
	
	
		<li>
			<a href="#" onclick="goPage(<%=QABbs_len-1%>)"  class="page bbs">마지막</a>
		</li>		 
	</ul>
</div>

							




<!-- 검색 테이블 -->

<div align="center">
	<form id="selfrm" action="main">
	<input type="hidden" name="work" value="QAlistView">
	<table>
		<col width="100"><col width="200"><col width="150"> 
		<tr>
			<td>
				<select name="category" id="category">
					<option value="CHOICE">선택</option>
					<option value="TITLE">제목</option>
					<option value="CONTENT">내용</option>
					<option value="ID">작성자</option>
				</select>
			</td>
				<td><input type="text"  name="keyword" id="keyword" class="txt"></td>
				<td><button type="button" class="button primary" id="selBtn">검색</button></td>
			
			

		</tr>

	</table>
	</form>
</div>
	

<script type="text/javascript">

let jcategory = "<%=category%>";
let jkeyword = "<%=keyword%>";
let jlen =  "<%=QABbs_len%>";

document.getElementById("category").value = jcategory;
document.getElementById("keyword").value = jkeyword;



// 체크한 게시물 삭제 버튼
$("#chDelBtn").click(function() {
	
	let arrCheck = document.getElementsByName("delcheck");
	let check = false;
	
	$("input:checkbox[name=delcheck]").each(function () {
		if($(this).is(':checked')){
			check = true;
		
		}
	});
	if(check){
		$('#QAfrm').submit();
	
	}
	
	else{
		alert("삭제할 게시물을 선택하세요");
	}	
});



$(function () {
	
	// 검색한 결과 페이지 이동
	$('#selBtn').click(function() {
				
			$('#selfrm').submit();
	});

	
});	

function goPage(currPage){
	
	if(currPage < 0){
		
		currPage = 0;
	}
	if(currPage > jlen -1){
		
		currPage = jlen -1;
	}
	
	
	location.href= "main?work=QAlistView&currPage=" + currPage + "&category=" + jcategory +"&keyword=" + jkeyword; 
}


function deletechecks(ch){
	
	let arrCheck = document.getElementsByName("delcheck");
	
	for(i =0; i < arrCheck.length; i++){
		arrCheck[i].checked = ch;
	} 
}


</script>

<%@ include file="parts/footer.jsp" %>  

</body>

</html>