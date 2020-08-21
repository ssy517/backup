<%@page import="dto.CartDto"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
List<CartDto> cartlist = (List<CartDto>) request.getAttribute("cart");
List<ProductDto> productlist = (List<ProductDto>) request.getAttribute("product");
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
	<!-- body--------------------------------------------------------------------------------------- -->
	<div class="container">

		<h1>결제한 주문 확인 페이지</h1>

		<div align="center">
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

					<th>총결제액</th>

				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>

				<%
					if (cartlist.size() == 0) {
				%>
				<tr bgcolor="#f6f6f6">
					<td colspan="5" align="center" height="100">상품 리스트가 존재하지 않습니다</td>
				</tr>
				<tr>
					<td height="5" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<%
					} else {
					for (int i = 0; i < cartlist.size(); i++) {
						CartDto cdto = cartlist.get(i);
						ProductDto pdto = productlist.get(i);
						/* 	ProductDto pdto = receiptProduct.get(i); */
				%>

				<tr bgcolor="#f6f6f6">

					<td><img src="img/prdimg/<%=pdto.getImg_name()%>"
						style="max-width: 145px; height: auto;"></td>

					<td style="word-break: break-all" align="center">
			
					상품번호: <%=pdto.getPrd_num()%><br>
						상품이름: <%=pdto.getName()%><br> 
						
						</td>
						
						

					<td align="center"><%=pdto.getPrice()%></td>


					<td align="center"><%=cdto.getAmount()%></td>

					<td align="center"><%=pdto.getPrice() * cdto.getAmount() %></td>
					
				</tr>
				<tr>
					<td height="2" bgcolor="#8AC47A" colspan="5"></td>
				</tr>
				<%
					}
				}
				%>
				
			</table>
		</div>




	<!-- ---------------------------------------------------------------------------------------------------------------- -->
		<script type="text/javascript">
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
				alert("얍");
				alert(content);
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

		

</div>
<%@ include file="parts/footer.jsp" %>  
</body>
</html>