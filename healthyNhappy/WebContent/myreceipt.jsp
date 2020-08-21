<%@page import="dto.CartDto"%>
<%@page import="dto.ProductDto"%>
<%@page import="dto.OrderDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberDto memb = (MemberDto)session.getAttribute("login");
%>	

<%

List<CartDto> receipt = (List<CartDto>) request.getAttribute("receipt");
List<ProductDto> receiptProduct = (List<ProductDto>) request.getAttribute("receiptProduct");
//아이디랑 연결된 cartdto? orderdto?

CartDto oneCart = (CartDto)request.getAttribute("cdto");
ProductDto oneProduct = (ProductDto)request.getAttribute("pdtoOne");
System.out.println(oneCart);
%>





<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
 
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
/* 헤더 푸터 ------------------------------------------------------------------------ */

/* Add some padding on document's body to prevent the content
    to go underneath the header and footer */
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.container {
	width: 80%;
	margin: 0 auto; /* Center the DIV horizontally */
}


.container p {
	line-height: 200px; /* Create scrollbar to test positioning */
}
/* --------------------------------------------------------------------------------- */
/* 여기부터 사용하세요 */
</style>
</head>
<body>
<%
if(receipt != null) {
%>	
	<!-- body--------------------------------------------------------------------------------------- -->
	<div class="container">

		<h1>주문 확인 페이지</h1>

		<div align="center">
		
			<form id="payFrm">
			<table border="1">
			
				<col width="150px">
				<col width="300">
				<col width="80">
				<col width="50">
				<col width="80">
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<tr>
					
					

					<th>사진</th>

					<th>제품</th>

					<th>가격</th>

					<th>수량</th>

					<th>총결제액
					<input type="hidden" value="<%=memb.getId()%>" name="idindi">
					</th>

				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>

				<%
					if (receipt.size() == 0) {
				%>
				<tr bgcolor="#f6f6f6">
					<td colspan="5" align="center" height="100">상품 리스트가 존재하지 않습니다</td>
				</tr>
				<tr>
					<td height="5" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<%
					} else {
					for (int i = 0; i < receipt.size(); i++) {
						CartDto odto = receipt.get(i);
						ProductDto pdto = receiptProduct.get(i);
						/* 	ProductDto pdto = receiptProduct.get(i); */
				%>

				<tr bgcolor="#f6f6f6">

					<td><img src="img/prdimg/<%=pdto.getImg_name()%>"
						style="max-width: 145px; height: auto;"></td>
					<!-- 제품보는 곳으로 앵커 달면 새창으로? -->

					<td style="word-break: break-all" align="center">
					<input type="hidden" name="productNum" value="<%=odto.getPrd_num()%>"> 
					<input type="hidden" name="ids" value="<%=odto.getId()%>"> 
					상품번호: <%=odto.getPrd_num()%><br>
						상품이름: <%=pdto.getName()%><br> 
						
						</td>
						
						

					<td align="center"><%=pdto.getPrice()%></td>


					<td align="center"><%=odto.getAmount()%></td>

					<td align="center"> <input type="hidden" name="payMon" class="total" value="<%=pdto.getPrice() * odto.getAmount()%>"><%=pdto.getPrice() * odto.getAmount()%></td>
					
				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<%
					}
				}
				%>
				
			
				
				<tr>
					<td colspan="5">
					<input type="hidden" value="">
					&nbsp;&nbsp;주소 &nbsp;&nbsp;&nbsp; <input type="text" value="<%=memb.getAddress() %>" name="orderAddress">
					
				
				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<tr>
				
					<td colspan="5">
					&nbsp;&nbsp;요청 &nbsp;&nbsp;&nbsp; <input type="text" placeholder="요청 사항 없음 " name="orderRequest">
					</td>
				</tr>
				
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				
				<tr>
					<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;총결제액 <div id="sum" style="font-size: 30pt"></div></td>



					<!-- 업데이트할때 요청 수량 업뎃하면서 장바구니>구매로? 보내면서 새창 띄우고..총결제액 값..결제하게...
									구매시...SYSDATE로 바꾼다
									결제날...
									둘다... 업데이트...
									-->
					<td colspan="2" align="center">

						<button type="button" id="btnPay"
							style="width: 60pt; height: 40pt;">결제</button>
					</td>

				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
			</table>
			</form>
		</div>

<%
}else { // myCart 기능 확인
%>
	<div class="container">
	<h1>주문 확인 페이지</h1>
	
		<form id="payNow">
			<table border="1">
			
				<col width="150px">
				<col width="300">
				<col width="80">
				<col width="50">
				<col width="80">
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<tr align="center">
					
					<th>사진</th>

					<th>제품</th>

					<th>가격</th>

					<th>수량</th>

					<th>총결제액</th>

				</tr>
				<tr align="center">
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<tr align="center">
					<td><img src="img/prdimg/<%=oneProduct.getImg_name() %>" style="max-width: 145px; height: auto;"></td>
 <!-- name="payNow" -->
					<td>
					<%=oneProduct.getName() %><!-- 총결제액 수량 제품번호 -->
					<input type="hidden" name="payNowPrdNum" value="<%=oneProduct.getPrd_num() %>">
					<input type="hidden" name="payNowAmount" value="<%=oneCart.getAmount() %>">
					<input type="hidden" name="payNowPrice" value="<%=oneCart.getPrice() %>">
					</td>
					
					<td>
					<%=oneProduct.getPrice() %>
					</td>

					<td>
					<%=oneCart.getAmount() %>
					</td>

					<td>
					<%=oneCart.getPrice() %>
					
					</td>
				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<tr>
				<td colspan="4">
				<table>
				<tr>
				<td>&nbsp;&nbsp;주소&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><input type="text" value="<%=memb.getAddress() %>" name="payNowAddress"></td>
				</tr>
				<tr>
				<td>&nbsp;&nbsp;요청&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><input type="text" placeholder="요청사항을 적어주세요" name="payNowRequest"></td>
				</tr>
				</table>
				<td colspan="1" align="right">
				<button type="button" style="width: 60pt; height: 40pt;" id="payNowBtn">결제</button>
				</td>
				</tr>
			</table>
		</form>

	</div>

<%
}
%>
	<!-- ---------------------------------------------------------------------------------------------------------------- -->
		
		
		<script type="text/javascript">
		//list받을때..------------------------------------------
		let content = 0;
			
			//총합계..
			$(document).ready(function(){
				
				content = 0;
				//let len = $(".total").length;
				//alert(len);
				//$("#sum").
				//let aa = $(".total").val();
				//alert(aa);
								
				$( ".total" ).each(function(index) {
					  //alert(aa);
					 // alert($(".total").eq(index).val());
					  //td.eq(index);
					  content += parseInt($(".total").eq(index).val());
					  index++;
				});
				//content += "원"
				let result = content + "원";
				$("#sum").text(result);
			
			 });
		
			//결제 버튼
		$(document).ready(function(){ 
			$('#btnPay').click(function() { 
				var result = confirm('구매하시겠습니까?');
				//alert("얍");
				//alert(content);
				if(result) {//yes 
					//결제창 갈때 총합값 넘겨주기
					//결제창으로 값 넘겨주고 결제 성공시 이후 기능
					$("#payFrm").attr("action", "product?work=payOrder&orderMoney=" + content);
					$("#payFrm").attr("method", "post");
					$("#payFrm").submit();
					
					} else {//no
						
					} 
				}); 
			
		});

	
		</script>
		
		<script type="text/javascript">
		//제품디테일에서 바로 받는 부분-------------------------------------------------
		$(document).ready(function() {
			$('#payNowBtn').click(function() {
				var result = confirm('구매하시겠습니까?');
				
				if(result) {//yes 
				
					$("#payNow").attr("action", "product?work=payImmediately");
					$("#payNow").attr("method", "post");
					$("#payNow").submit();
					
					} else {//no
						
					} 
			});
		});
		</script>

		

</div>
<%@ include file="parts/footer.jsp" %>  
</body>
</html>