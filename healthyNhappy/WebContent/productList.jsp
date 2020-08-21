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
<%@ include file="parts/header.jsp" %>  

<style>
    .category{
    	padding: 50px;
    }
	.category td a.active{
		color:#0D6400;
	}
	a.active-color {  }

    .fcontainer td a:active, .fcontainer td a:hover, .fcontainer td a:focus {
		color: #0D6400 !important;
		background: transparent !important;
	}
    .container {
   		padding-bottom: 50px;    
   	}
    .container a{
   	    font-weight: bold;
    	text-decoration: none;
    	color: black;
    }
    .list td{	
    	padding: 3px;
    }
    .list img:hover{
    -moz-transform: translate(-2px, -2px);
    -ms-transform: translate(-2px, -2px);
    -o-transform: translate(-2px, -2px);
    -webkit-transform: translate(-2px, -2px);
    transform: translate(-2px, -2px);
    transition: all 0.2s ease-in-out; 
    }
    
</style>
</head>
<body>
<!-- body--------------------------------------------------------------------------------------- -->
<%
HashMap<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
List<ProductDto> list = (List<ProductDto>)map.get("list");
String category = (String)map.get("category");

//가격 표기 함수
DecimalFormat formatter = new DecimalFormat("###,###");

%>
<div class="container">
<img alt="" src="img/main/03.jpg" width=100%>
<br><br> 
   <div class="category">
   		<table align="center">
   		<col width="70px"><col width="70px"><col width="70px"><col width="70px">
   			<tr>
   				<%
   				if(category.equals("all")){
   				%>
   				<td><a class="active" href="product?work=list&category=all">전체</a></td>
   				<td><a href="product?work=list&category=fruit">과일</a></td>
   				<td><a href="product?work=list&category=vegi">채소</a></td>
   				<%	
   				}else if(category.contains("fruit")){
   				%>
   				<td><a href="product?work=list&category=all">전체</a></td>
   				<td><a <% if(category.equals("fruit01")){
   					%>class="active"<% 
   							} %> href="product?work=list&category=fruit01">생과일</a></td>
   				<td><a <% if(category.equals("fruit02")){
   					%>class="active"<% 
   							} %> href="product?work=list&category=fruit02">냉동과일</a></td>
   				<%	
   				}else if(category.contains("vegi")){
   				%> 	
   				<td><a href="product?work=list&category=all">전체</a></td>
   				<td><a href="product?work=list&category=vegi01">잎채소</a></td>
   				<td><a href="product?work=list&category=vegi02">뿌리채소</a></td>
   				<td><a href="product?work=list&category=vegi03">열매채소</a></td>
   				<% 
   				}
   				%>
   			</tr>
   			<!-- 드롭다운 메뉴 추가 -->
   		</table>
   </div>
   
    <div class="list" align="center">
    	<table>
    		<%
    		int lastnum=0;
    		for(int i = 0; i < list.size()/4; i++){
    		%>
    		<tr>
			   <%
			   for(int j = i*4 ; j < (i+1)*4; j++){
				%>
			   	<td style="padding-top: 10px">
			   		<a href="product?work=detail&prd_num=<%=list.get(j).getPrd_num()%>">
			   			<% 
			   			if( list.get(j).getPrd_num()%10 > 5){
			   			%>
			   				<img src="./upload/<%=list.get(j).getImg_name() %>" width="280px">
			   			<%	
			   			}else{
			   			%>
			   				<img src="img/prdimg/<%=list.get(j).getImg_name() %>" width="280px">
			   			<%	
			   			}
			   			%>
			   		</a>
			   	</td>	
				<%     
			   }
			   %>
   			</tr>
   			<tr style="text-align: center">
   				<%
			   for(int j = i*4 ; j < (i+1)*4; j++){
				%>
   				<td style="padding-top: 30px">
   					<a href="product?work=detail&prd_num=<%=list.get(j).getPrd_num()%>">
   						<%=list.get(j).getName() %>
   					</a>
   				</td>
   				<%     
			   }
			   %>
   			</tr>
   			<tr style="text-align: center">
   				<%
			   for(int j = i*4 ; j < (i+1)*4; j++){
				%>
   				<td><%=formatter.format(list.get(j).getPrice())  %>원</td>
   				<% 
   			lastnum = j + 1;    
			   }
			   %>
   			</tr>
   			<%
   			}
    		
    		// 마지막 줄
    		if( list.size()%4 > 0){
    			%>
    			<tr>
    			<%
    			for(int i = lastnum; i < lastnum + list.size()%4; i++){
    			%>
    				<td style="padding-top: 10px">
			   		<a href="product?work=detail&prd_num=<%=list.get(i).getPrd_num()%>">
			   			<% 
			   			if( list.get(i).getPrd_num()%10 > 5){
			   			%>
			   				<img src="./upload/<%=list.get(i).getImg_name() %>" width="280px">
			   			<%	
			   			}else{
			   			%>
			   				<img src="img/prdimg/<%=list.get(i).getImg_name() %>" width="280px">
			   			<%	
			   			}
			   			%>
			   		</a>
			   		</td>	
    			<%
    			}
    			%>
    			</tr>
    			<tr style="text-align: center">
   				<%
					   for(int i = lastnum; i < lastnum + list.size()%4; i++){
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
					   for(int i = lastnum; i < lastnum + list.size()%4; i++){
						%>
		   				<td><%=formatter.format(list.get(i).getPrice())  %>원</td>
		   				<%     
					   }
					   %>
		   			</tr>
    			<%
    		}
   			%>
   		</table>
   </div>
 
</div>    
<%@ include file="parts/footer.jsp" %>  
</body>
</html>