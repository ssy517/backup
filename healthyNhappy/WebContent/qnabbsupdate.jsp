<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaAnsDto"%>
<%@page import="dto.QnaBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%



QnaBbsDto qbdto = (QnaBbsDto)request.getAttribute("qbdto");



%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  

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

    .container p{
        line-height: 200px; /* Create scrollbar to test positioning */
    }
/* --------------------------------------------------------------------------------- */
/* 여기부터 사용하세요 */

input:focus {

outline: none;
}





</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="QAcss/QA.css?after" />	
</head>
<body>



<!-- body--------------------------------------------------------------------------------------- -->
<div class="container">
    
<div align="center" style="margin-top:20px"><img src="./img/icon/banner.png"></div>
    
    
<div align="center">
	<form id="QAfrm" action="bbs?work=QABbsUpdate" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="seq" value="<%=qbdto.getSeq() %>" > 
		
		
		<table class="alt">
			<col width="100"><col width="500"><col width="200">
		
			
			
		
			<tr>
				
				<th colspan="2" class="write">
				ID:&nbsp;&nbsp;<%=qbdto.getId() %>
				조회수:&nbsp;&nbsp;<%=qbdto.getReadcount() %>
				올린날짜:&nbsp;&nbsp;<%=qbdto.getWdate() %></th>
				<th class="write">
					<select name="open" >
					<option value="0" selected="selected">공개</option>
					<option value="1">비공개</option>
					</select>
				</th>
			</tr>
			
			
			
		<%
		if(qbdto.getFilename() != null && !qbdto.getFilename().equals("")){
		
		%> 
			<tr>
				<td>기존파일 :</td>
				<td>
					<input type="text" id="oldfile" name="oldfile" value="<%=qbdto.getFilename() %>" class="txt" style="width:250px" readonly="readonly">
				</td>
				<td class="content_btn">
				
					<button type="button" class="button" onclick="delToggle()" id="delFileBtn">기존파일 삭제</button>
				</td>
			</tr>
		<%
		}
		%>
			<tr>
				<td>파일변경 :</td>
				<td colspan="2" style="text-align:left">
					<input type="file" name="fileload" style="width:180px">
				</td>
				
			</tr>
			
		
			<tr>		
				<td colspan="3">&nbsp;&nbsp;<input type="text" id="title" name="title" size="81" class="txt2" value="<%=qbdto.getTitle() %>"> </td>
			</tr>
			
			
			<tr>
			
				<td colspan="3"><textarea  id="content" name="content" class="area2"><%=qbdto.getContent() %></textarea> </td>
			</tr>
		
		</table>
	</form>
<button type="button" class="button" id="qesUpBtn" >수정완료</button>
</div>    
    
   
</div>    



<script type="text/javascript">


let _oldfilename = "<%= qbdto.getFilename()%>";

function delToggle(){
	
	if($('#delFileBtn').text() == '기존파일 삭제'){
		
		$('#delFileBtn').text('기존파일 전환');
		$('#oldfile').val("");
		
	}else{
		
		$('#delFileBtn').text('기존파일 삭제');
		$('#oldfile').val(_oldfilename);
		
	}
		
}

$(function () {
	
	$('#qesUpBtn').click(function() {
		
		if($('#title').val().trim() == ""){
			
			alert("제목을 입력해주세요");
			$('#title').focus();
		}
		else if($('#content').val().trim() == ""){
			
			alert("내용을 입력해주세요");
			$('#content').focus();
		}
		
		else{
			
			$('#QAfrm').submit();
		}
		
	});
	

	
});


</script>   
<%@ include file="parts/footer.jsp" %>  
</body>
</html>