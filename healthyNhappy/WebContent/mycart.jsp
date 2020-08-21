<%@page import="dto.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Array"%>
<%@page import="dto.ProductDto"%>
<%@page import="dto.OrderDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp"%>


<%
List<CartDto> cartlist = (List<CartDto>) request.getAttribute("cart");
List<ProductDto> productlist = (List<ProductDto>) request.getAttribute("cartProduct");
%>

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
</style>
</head>
<body>

	<div class="container">

		<h1>장바구니</h1>



		<div align="center">
			<form id="cartFrm">
				<table border="1">
					<col width="50">
					<col width="150px">
					<col width="300">
					<col width="80">
					<col width="50">
					<col width="80">
					<col width="100">
					<tr>
						<td height="2" bgcolor="#8AC47A" colspan="7"></td>
					</tr>
					<tr>
						<th><input type="checkbox" name="functionAll"
							onclick="functionChecks(this.checked)"></th>

						<th>사진</th>
						
						<th>제품</th>

						<th>가격</th>

						<th>수량</th>

						<th>총결제액</th>

						<th>변경사항 저장</th>

					</tr>
					<tr>
						<td height="2" bgcolor="#8AC47A" colspan="7"></td>
					</tr>

					<%
						if (cartlist.size() == 0) {
					%>
					<tr bgcolor="#f6f6f6">
						<td colspan="7" align="center" height="100">상품 리스트가 존재하지 않습니다</td>
					</tr>
					<tr>
						<td height="2" bgcolor="#8AC47A" colspan="7"></td>
					</tr>
					<%
						} else {
						for (int i = 0; i < cartlist.size(); i++) {
							CartDto cdto = cartlist.get(i);
							ProductDto pdto = productlist.get(i);
					%>

					<tr bgcolor="#f6f6f6">

						<td align="center"><input type="checkbox" class="chkbx"
							name="funCk" value="<%=cdto.getPrd_num()%>">
							<input	type="hidden" value="<%=cdto.getId() %>" name="ids" class="ids">
						</td>
						<!-- 삭제 기능 확인 -->

						<td><img src="img/prdimg/<%=pdto.getImg_name()%>"
							style="max-width: 145px; height: auto;"> <input
							type="hidden" value="<%=cdto.getPrd_num()%>" class="productNum">
						</td>
						<!-- 제품보는 곳으로 -->
						<!-- 제품페이지로 -->

						<td style="word-break: break-all" align="center"><input
							type="hidden" class="goodProduct" value="<%=pdto.getPrd_num()%>">

							상품번호: <%=cdto.getPrd_num()%><br> 상품이름: <%=pdto.getName()%><br>
							
						<td align="center"><input type="hidden" class="goodPrice"
							name="price" value="<%=pdto.getPrice()%>"> <%=pdto.getPrice()%></td>


						<td align="center"><input type="text" class="goodAmount"
							name="amount" value="<%=cdto.getAmount()%>" style="width: 13pt;"
							maxlength="2"></td>

						<td align="center"><input type="text" class="goodTotal"
							readonly="readonly" name="totalPrice" style="width: 40pt;"
							value="<%=pdto.getPrice() * cdto.getAmount()%>"></td>
						<td>
							<button type="button" class="btnUpdate"
								style="width: 60pt; height: 40pt;">수정</button>
						</td>
					</tr>
					<tr>
						<td height="2" bgcolor="#8AC47A" colspan="7"></td>
					</tr>
					<%
						}
					}
					%>
					<tr>

						<td colspan="7" align="center">
							<button type="button" onclick="btnDelete()"
								style="width: 60pt; height: 40pt;">삭제</button>
							<button type="button" onclick="btnOrder()"
								style="width: 60pt; height: 40pt;">주문</button>
						</td>

					</tr>
					<tr>
						<td height="2" bgcolor="#8AC47A" colspan="7"></td>
					</tr>

				</table>
			</form>

		</div>
	</div>


	<!-- 
		수정기능
		각각 수정된거 저장하는 버튼으로....
		seq=?&amount=?
		getparamete
		
		구매기능
		장바구니 체크박스한 물품만 구매하고 값 확인페이지로만 넘어가서.
		값 변경은 없고 체크박스 seq 번호로 뿌려주면서 구매하시겠습니까 확인페이지
		
		
		-->

	<script type="text/javascript">
		//필요한 기능?
		//수량 바뀌면 값 바뀌게...엔터키
		//수량 수정 기능..
		//여기 들어가면 체크박스 체크로 바뀌게...

		//값
		$(".goodAmount").on(
				"input",
				function() {
					//console.log(1);
					//let lastAmount = $(".goodAmount").val();		//확인...! 어딘가 렉나면 this...
					let lastAmount, price, total = null;
					lastAmount = $(this).val();
					//alert(lastAmount);
					price = $(this).closest('tr').children('td').children(
							'input.goodPrice').val();
					total = lastAmount * price;
					$(this).closest('tr').children('td').children(
							'input.goodTotal').val(total);

				});

		//버튼-----------------------------------------------------

		//수정 한개씩
		$(document)
				.ready(
						function() {
							$(".btnUpdate")
									.click(
											function() {

												let updateBtn = $(this);

												let fixNum = updateBtn
														.closest('tr')
														.children('td')
														.children(
																'input.productNum')
														.val();
												//alert(fixNum);
												let fixAmount = updateBtn
														.closest('tr')
														.children('td')
														.children(
																'input.goodAmount')
														.val();
												//alert(fixAmount);

												let fixTotal = $(this)
														.closest('tr')
														.children('td')
														.children(
																'input.goodTotal')
														.val();

												//alert(fixTotal);
												
												let fixId = $(this)
														.closest('tr')
														.children('td')
														.children(
																'input.ids')
														.val();

												location.href = "product?work=updateOne&fixNum="
														+ fixNum
														+ "&fixAmount="
														+ fixAmount
														+ "&fixTotal="
														+ fixTotal
														+ "&ids="
														+ fixId	;
												alert("수정 되었습니다");
											});
							

						});

		//구매 버튼
		function btnOrder() {

			$("#cartFrm").attr("action", "product?work=ordAll");
			$("#cartFrm").attr("method", "post");

			if (!$('.chkbx').is(':checked')) {
				alert('구매할 상품을 선택해주세요');
			} else {
				$("#cartFrm").submit();
			}
		}
		//삭제 기능
		function btnDelete() {
			//action="product?work=delAll" method="post"
			$("#cartFrm").attr("action", "product?work=delAll");
			$("#cartFrm").attr("method", "post");

			if (!$('.chkbx').is(':checked')) {
				alert('삭제할 상품을 선택해주세요');
			} else {
				$("#cartFrm").submit();

			}
		}

		//다중 체크
		function functionChecks(ch) {
			let arrCheck = document.getElementsByName("funCk");
			for (i = 0; i < arrCheck.length; i++) {
				arrCheck[i].checked = ch;
			}
		}
	</script>
	

	<%@ include file="parts/footer.jsp"%>
</body>
</html>