<%@page import="dto.ReviewBbsDto"%>
<%@page import="dto.CartDto"%>
<%@page import="dto.ProductDto"%>
<%@page import="dto.OrderDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp"%>




<%
List<OrderDto> orderlist = (List<OrderDto>) request.getAttribute("order");
List<ReviewBbsDto> reviewlist = (List<ReviewBbsDto>) request.getAttribute("review");
List<ProductDto> reviewProductlist = (List<ProductDto>) request.getAttribute("reviewProduct");
%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
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

		<h1>마이페이지</h1>

		<h3>
			환영합니다
			<%=mem.getId()%>님
		</h3>
	</div>

	<table>
		<col width="250">
		<col width="1000">
		<tr height="1000">
			<td align="left" valign="top">
				<nav id="naviya">
					<ul style="list-style: none">
						<li>최근 결제 목록</li>
						<li>내가 남긴 리뷰</li>
						<li>내가 남긴 QnA</li>
						<li><a href="Yhdetail.jsp">회원 정보 관리</a></li>
					</ul>
				</nav>
			</td>
			<td valign="top">

				<div align="left">

					<div id="myOrd">
						<h3>최근 결제 목록</h3>
						<table border="1" id="payList">
							<tr>
								<th>주문 번호</th>
								<th>주문날짜</th>
								<th>요청</th>
								<th>총가격</th>
								<th>주소</th>
							</tr>
							<%
								if (orderlist.size() == 0) {
							} else {
								for (int i = 0; i < orderlist.size(); i++) {
									OrderDto odto = orderlist.get(i);
							%>
							<tr>
								<td><a class="individualOrder"><%=odto.getSeq()%></a> <input
									type="hidden" class="seq" value="<%=odto.getSeq()%>"> <input
									type="hidden" class="ids" value="<%=odto.getId()%>"></td>
								<td><%=odto.getOdate()%></td>
								<td><%=odto.getAdd_req()%></td>
								<td><%=odto.getPrice()%></td>
								<td><%=odto.getDeli_addr()%></td>

							</tr>
							<%
								}
							}
							%>
						</table>
					</div>

					<div id="myRev">
						<h3>리뷰</h3>

						<table id="myReview" border="1">
							<tr>
								<th>제품</th>
								<th>사진</th>
								<th>제목</th>
								<th>별점</th>
								<th>작성일</th>
							</tr>
							<%
								for (int i = 0; i < reviewlist.size(); i++) {
								ReviewBbsDto rdto = reviewlist.get(i);
								ProductDto pdto = reviewProductlist.get(i);
							%>
							<tr>
								<td>
								<%=pdto.getName() %>
								<!-- product?work=detail&prd_num=111 -->
								</td>
								<td>
								<%=pdto.getImg_name() %>
								</td>
								<td>
								<a href="product?work=detail&prd_num=<%=pdto.getPrd_num()%>"><%=rdto.getTitle() %>
								</a>
								</td>
								<td>
								<%=rdto.getScore() %>
								</td>
								<td>
								<%=rdto.getWdate() %>
								</td>
							</tr>
							<%
								}
							%>


						</table>
					</div>

					<div id="myQue">
						<h3>QnA</h3>

						<table id="myQna" border="1">
							<tr>
								<th>시퀀스</th>
								<th>제목</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>

						</table>
					</div>

				</div>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
		$(document)
				.ready(
						function name() {

							//-----
							$(".individualOrder")
									.click(
											function() {

												let seq = $(this).closest("td")
														.children("input.seq")
														.val();
												let ids = $(this).closest("td")
														.children("input.ids")
														.val();
												alert(seq);
												alert(ids);
												location.href = "product?work=myPageOrderDetail&seq="
														+ seq + "&ids=" + ids;
											});

							$('#payList tr').hover(function() {
								$(this).css("background", "grey");
							}, function() {
								$(this).css("background", "white");
							});

							//-----
							$.ajax({
								url : "bbs",
								type : "post",
								data : {
									work : "myPageReviewQna"
								},
								datatype : "json",
								success : function(json) {

									//let revlist = json.map.revList;
									let qnalist = json.map.qnaList;
									//console.log(revlist);
									console.log(qnalist);

									//let review = "";
									let qnabbs = "";

									/*
									for (var i = 0; i < revlist.length; i++) {
										review = "<tr>" + "<td><input type='text' class='proNum' value='"
												+ revlist[i].prd_num + "' readonly></td>"
												+ "<td><img src='img/stars/star" + revlist[i].score
												+ ".png'></td>" + "<td>"
												+ revlist[i].title + "</td>"
												+ "<td>" + revlist[i].wdate
												+ "</td>";
										+"</tr>"

										$("#myReview").append(review);
									}
									 */

									for (var i = 0; i < qnalist.length; i++) {
										qnabbs = "<tr>" + "<td>"
												+ qnalist[i].seq + "</td>"
												+ "<td>" + qnalist[i].title
												+ "</td>" + "<td>"
												+ qnalist[i].readcount
												+ "</td>" + "<td>"
												+ qnalist[i].wdate + "</td>";
										+"</tr>"

										$("#myQna").append(qnabbs);
									}

								}

							});

							//------
							$("#myOrd").hide();
							$("#myRev").hide();
							$("#myQue").hide();
							$("#naviya li").click(function() {
								$()
								let a = $(this).text();
								console.log(a);
								if (a == "최근 결제 목록") {
									$("#myOrd").show();
									$("#myRev").hide();
									$("#myQue").hide();
								} else if (a == "내가 남긴 리뷰") {
									$("#myOrd").hide();
									$("#myRev").show();
									$("#myQue").hide();
								} else if (a == "내가 남긴 QnA") {
									$("#myOrd").hide();
									$("#myRev").hide();
									$("#myQue").show();
								} else if (a == "회원 정보 관리") {
									$("#myOrd").hide();
									$("#myRev").hide();
									$("#myQue").hide();
								}
							});

						});
	</script>

	<%@ include file="parts/footer.jsp"%>
</body>
</html>