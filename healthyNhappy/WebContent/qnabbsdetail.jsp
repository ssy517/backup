<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaAnsDto"%>
<%@page import="dto.QnaBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//MemberDto mem = (MemberDto)session.getAttribute("login"); 

QnaBbsDto qbdto = (QnaBbsDto)request.getAttribute("qbdto");
QnaAnsDto qadto = (QnaAnsDto)request.getAttribute("qadto"); 





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

    
 <div align="center" style="margin-top:20px"><img src="./img/icon/banner.png"></div>
    
    
<div align="center">
	<form action="bbs?work=QAfileDown&filename=<%=qbdto.getFilename() %>&seq=<%=qbdto.getSeq() %>"
		  method="post" id="downfrm">
	<table class="alt2">
		 <col width="800"> <col width="350">

		<tr>
		
			<th colspan="2" class="detail_title">&nbsp;&nbsp;<%=qbdto.getTitle() %></th>
		</tr>
		<tr>
		
			<th class="detail_content">&nbsp;<img alt="" src="./img/icon/writer.png" style="margin-right:1px; vertical-align: -4%;"><%=qbdto.getId() %>
			&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="./img/icon/readcount.png" style=" vertical-align: -13%;margin-right:5px" ><%=qbdto.getReadcount() %>
			</th>
			
			<td class="date">
			<img alt="" src="./img/icon/calendar.png" style=" vertical-align: -8%;margin-right:5px" ><%=qbdto.getWdate() %></td>
		</tr>
		
	<%
	if(qbdto.getFilename() != null&& !qbdto.getFilename().equals("")){
		 %>
		<tr>
		
			<td colspan="2" class="down">			
				<input type="button" class="button" id="downBtn" name="downBtn" value="파일다운로드"/>&nbsp;&nbsp;&nbsp;<%=qbdto.getFilename() %>
			</td>
		
		</tr>
	
		<tr>
		
			<td colspan="2" class="content_img">
				<div align="left">
				<img src="./QAupload/<%=qbdto.getFilename()%>" width="auto" height="auto">
				</div>
			
			</td>
		</tr>
		
	<%
	}
	
	%>	
		
		<tr>
			<td colspan="2" class="content_area">
			<textarea readonly="readonly" id="content" class="detail" ><%=qbdto.getContent() %></textarea> 
			</td>
		</tr>
	
<tfoot>	
<tr>
<td class="content_btn">
<%
// 작성자 : 질문 수정 권한
if(mem != null && (mem.getId().equals(qbdto.getId()) || mem.getAuth() == 1)){
	
	
	
	%>
	
	<button type="button" id="qesUpBtn" class="button primary" >질문 수정</button>
	<% 
	// 관리자 : 질문 수정 삭제귄한, 답변 수정 권한
	if(mem != null && mem.getAuth() == 1){
		%>
		<button type="button" id="qesDeBtn" class="button primary" >질문 삭제</button>
		<%
		if(qadto != null){
		%>
		<button type="button" id="ansToggle" class="button primary">답변 수정하기</button>
		<%
		}
	}
	

%>

<%	
	
}

%>
</td >
<td class="content_btn2">
<button type="button" id="listBtn" class="button primary">목록</button>
</td>
</tr>



</tfoot>
</table>
</form>
</div>
	
   

<%
// 답변글이 없고 관리자권한으로 로그인했을 때
if( mem != null && (mem.getAuth() == 1 && qadto == null)){
%>

<div align="center">
	<form id="QAfrm" action ="bbs" method="post">
		<input type="hidden" name="work" value="QAwriteAns">
		<input type="hidden" name="seq" value="<%=qbdto.getSeq()%>">
		<input type="hidden" name="id" value="<%=mem.getId()%>"> 
		<table class="ans">
		<col width ="1143">
			<tr>
			
			<td class="ans"> <img src="./img/icon/qna.png" style=" vertical-align: text-bottom;" >
		&nbsp;&nbsp;답변&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;admin(ID:<%=mem.getId() %>) </td>
		
			
			
			
			</tr>
			<tr>
				
				<td colspan="2" class="ans_content"><textarea class="ans" name="ansContent" id="ansContent"></textarea>
				
			</tr>
			<tfoot>
			<tr>
			<td colspan="2" class="admin"><button type="button" class="button" id="ansBtn">답변 입력</button></td>
			</tr>
			</tfoot>
		</table>
	</form>
</div>
	

<%
}
// 답변글이 존재했을 때
if(qadto != null){

%>
<div align="center" id="ansView">
	<table class="ans_alt">
	<col width ="1150">	
		<tr>
		<td class="ans"> <img src="./img/icon/qna.png" style=" vertical-align: text-bottom;" >
		&nbsp;&nbsp;답변&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;admin(ID:<%=qadto.getId() %>) </td>
		
		</tr>	
		<tr>		
			<td>				 
				<textarea class="ans" readonly="readonly"><%=qadto.getContent() %></textarea>			 
			</td>
			
		</tr>
	</table>
</div>
<%
if(qadto != null && mem != null){
%>
<%--답변 수정 뷰 --%>
<div align="center" id="ansUpdate">
	<form id="ansfrm" action="bbs" method="post">
		<input type="hidden" name="work" value="QAAnsUpdate">
		<input type="hidden" name="seq" value="<%=qadto.getSeq()%>">
		
		<table class="ans">
			<col width ="50"> <col width = "1088">	
			<tr>
				<td class="ans"> 
				<img src="./img/icon/qna.png" style=" vertical-align: text-bottom;" >
				
				</td>
				<td>
				<input type="text" class="txt2" value="<%=mem.getId() %>" readonly="readonly" name="id">
				</td>
								
			</tr>
	
			<tr>
				<td class="ans_content" colspan="2"><textarea class="ans" name="ansUpContent" id="ansUpContent" ><%=qadto.getContent() %></textarea></td> 		
			</tr>
			
			<tfoot>
			<tr>
			<td class="admin" colspan="2"><button type="button" class="button" id="ansUpBtn">답변 수정완료</button></td>
			</tr>
			</tfoot>
		</table>
	</form>
</div>
<%
}
%>

   
<%
}
%>   
   
</div>    



<script type="text/javascript">
$(function(){

	let seq = "<%=qbdto.getSeq() %>";

	let sTextarea = document.getElementById("content");
	let csize = (sTextarea.scrollHeight >= 50) ? sTextarea.scrollHeight+"px" : 50+"px";
	sTextarea.style.height = csize;




	$('#ansUpdate').hide();

	// 답변 입력 버튼
	$('#ansBtn').click(function () {
		
			if($('#ansContent').val().trim() ==""){
				
				alert("답변을 입력해주세요");
				$('#ansContent').focus();
			}			
			else{
				
				$('#QAfrm').submit();
			}	
	});
	
	// 답변 수정 뷰 버튼
	$('#ansToggle').click(function () {
		$('#ansView').toggle(1);

		$('#ansUpdate').toggle(1);
		
		if($('#ansView').is(':visible'))
		$('#ansToggle').text('답변 수정하기');
		else
		$('#ansToggle').text('돌아가기');	
		
		
	});
	// 답변 수정 완료 버튼
	$('#ansUpBtn').click(function () {
		if($('#ansUpContent').val().trim()==""){
			
			alert("답변을 입력하세요");
			$('#ansUpContent').focus();
		}
		else{
			
			$('#ansfrm').submit();
		}
	});
	

	// 질문 수정 버튼
	$('#qesUpBtn').click(function() {
		
		location.href = "main?work=QAUpdateView&seq=" + seq;
		
	});
	// 질문 삭제 버튼
	$('#qesDeBtn').click(function () {
		
		location.href = "bbs?work=QABbsDelete&seq=" + seq;
	});
	
	
	$('#downBtn').click(function () {
		
		$('#downfrm').submit();
		
	});
	
	
	$('#listBtn').click(function () {
		
		location.href = "main?work=QAlistView";
	});
});




</script>


</body>

<%@ include file="parts/footer.jsp" %>  



</html>