<%@page import="dto.ProductDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.HashMap"%>

<%@page import="java.util.List"%>
<%@ page import="dto.WbBbsDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  

<style>

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





</style>
</head>
<body>

  
 <%
HashMap<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
List<ProductDto> list = (List<ProductDto>)map.get("list");

//가격 표기 함수
DecimalFormat formatter = new DecimalFormat("###,###");

//진하씨----
List<WbBbsDto> wlist = (List<WbBbsDto>)map.get("wlist");
int pageNumber = (int)map.get("pageNumber");
int wbBbsPage = (int)map.get("wbBbsPage");
%>
<div class="container">
    
   <br><br> 
   <div>검색결과</div>
   <hr>
   <div>제품</div>

	<div class="list">
    	<table>
    		<tr>
			<%
			if(list.size() > 0){
			
			   for(int i=0; i<list.size(); i++){
				%>
			   	<td style="padding-top: 10px">
			   		<a href="product?work=detail&prd_num=<%=list.get(i).getPrd_num()%>">
			   			<img src="img/prdimg/<%=list.get(i).getImg_name() %>" width="280px">
			   		</a>
			   	</td>	
				<%     
			   }
			   %>
   			</tr>
   			<tr style="text-align: center">
   				<%
			   for(int i=0; i<list.size(); i++){
				%>
   				<td style="padding-top: 30px">
   					<a href="product?work=detail&prd_num=<%=list.get(i).getPrd_num()%>">
   						<%=list.get(i).getName() %>
   					</a>
   				</td>
   				<%     
			   }
			   %>
   			</tr>
   			<tr style="text-align: center">
   				<%
			   for(int i=0; i<list.size(); i++){
				%>
   				<td><%=formatter.format(list.get(i).getPrice())  %>원</td>
   				<%     
			   }
			   %>
   			</tr>
   			<tr style="text-align: center">
   				<%
			   for(int i=0; i<list.size(); i++){
				%>
   				<td><input type="button" value="장바구니"></td>
   				<%     
			   }
			   %>
   			</tr>
   			<%
   			}else{
				%>
				<tr>
					<td>"${map.searchWord}"에 일치하는 검색 결과가 없습니다.</td>
				</tr>
				<% 
			 }
   			%>
   		</table>
   </div>
   <br><hr><br>
   
   <div>게시글</div> 
  <br>

	<form id="wellBingTable">
		<table border="1">
		<col width="100"> <col width="600"> <col width="130"> <col width="155">

			<tr>
				<th style="text-align: center">번호</th><th style="text-align: center">제목</th><th style="text-align: center">작성자</th><th style="text-align: center">작성일</th>
			</tr>
			<%
				if(wlist ==null || wlist.size() ==0){
			%>
			<tr>
			<td colspan="4" align="center">"${map.searchWord}"일치하는  게시글이 없습니다. </td>
			</tr>
			<%
				}else{

					for(int i =0; i< wlist.size(); i++){
						WbBbsDto wbs =wlist.get(i);
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
					<font color="#ff0000"> *********** 이글은 작성자에 의해 삭제 되었습니다.</font>
				<%
						}
				%>
				</td>
				<td align="center"><%=wbs.getId() %></td>
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


	</form>
	<script type="text/javascript">

		function goPage(pageNum) {
			var search = '${map.searchWord}';

			$.ajax({
				url: './wbbbs', //메인 컨트롤러로 보내겠어용
				type: 'get',  // 타입은 겟과 포스트가 있는데 저는 겟으로 보냈어용
				data: {
					write:'tableSearch',  // write.equals("tableSearch"){  컨트롤러에 이렇게 쓰는 양식
					searchWord: search,  //  서치의 키와 밸류  페이지의 키와 밸류 값이 있어야함
					pageNumber: pageNum
				},
				success: function(response) {   // 성공 할때 왤빙테이블 아이디 값을 받아  .html 값을 받음.
					$("#wellBingTable").html(response);
				},
				error: function (error) {
					console.log(error);
				}
			})
		}
	<%--ajax 로 바꾸기--%>
	// 		location.href = "main?write=choice&search=" +word + "&choice=" + choice + "&pageNumber=" + pageNum;

	</script>
  
  <%@ include file="parts/footer.jsp" %>  
</body>
</html>