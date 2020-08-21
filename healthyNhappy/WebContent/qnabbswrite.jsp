<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%


//MemberDto mem = (MemberDto)session.getAttribute("login");




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



/*

textarea { 
min-height: 300px;
width:100%; 
 outline:none;
 border:none;
 resize: none;
 overflow:auto;
 margin-bottom: 50px;
}
*/
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="QAcss/QA.css?after" />	

</head>
<body>

  


<!-- body--------------------------------------------------------------------------------------- -->
<div class="container">
    
<div align="center" style="margin-top:20px"><img src="./img/icon/banner.png"></div>
    
    
    
    
<div align="center">
	<form id="QAfrm" action="bbs?work=QAwriteBbs" method="post" enctype="multipart/form-data">
	
		<table class="alt" >
			<col span="100"><col span="500"> <col span="200">	
		
			
			<tr>
				
				<th class="write">작성자&nbsp;&nbsp;</th>
				<th class="write">
					
					<input type="text" class="txt2" readonly="readonly" 
					class="txt" style="outline: none"
					id="id" name="id"  value="<%=mem.getId() %>" >
				</th>
				
				<th align="right" class="write">
				
					<select name="open" >
					<option value="0" selected="selected">공개</option>
					<option value="1">비공개</option>
					</select>
				</th>
			</tr>
			
			
			
			
			<tr>
				
				<td colspan="3" style="text-align: left;">
				<input type="file" name="fileload" accept=".gif, .jpg, .png" style="width: 200px">
				</td>
			</tr>
			
			<tr>
			
				<td colspan="3"><input type="text" id="title" name="title" class="txt3" maxlength="50" > 
				</td>
			</tr>
			
			<tr>
			
				<td colspan="3">
					<textarea id="content" name="content" class="area1" ></textarea>
					
				</td>
				
			</tr>
		
		</table>
	
	
	
	</form>


<button type="button" id="addBtn" class="button">등록</button>
</div>


<script type="text/javascript">





	

$(function () {
	
	
	$('#listBtn').click(function() {
		
		location.href="main?work=QAlistView";
	});
	
	$('#addBtn').click(function() {
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
    	
   
</div>    
<%@ include file="parts/footer.jsp" %>  
</body>
</html>