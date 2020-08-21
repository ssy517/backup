<%@page import="dto.MemberDto"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>

    .container{
        width: 80%;
        padding-top: 170px;
        /* margin: 0 auto; */ /* Center the DIV horizontally */
    }
    .container p{
        line-height: 200px; /* Create scrollbar to test positioning */
    }
    .prdinfo{
    	margin-left: 200px;
    }
    .prdinfo .image{
    	float: left;
    	padding-left: 200px;
    	margin-bottom: 70px;
    }
    .infoRight{
    	padding-top: 50px;
    	padding-left: 70px;
    	float: left;
    }
    .infoRight table{
    	width: 500px;
    	font-size: 16px;
    }
    .infoRight td{
    	padding-bottom: 20px;
    }
    hr{
    	margin: 0;
    	border-top: 1px solid grey;
    }
    .infoRight .price{
    	font-size: 20px;
    	color: #0D6400;
    }
    .infoRight .btn{
    	font-weight: bold;
		background: #0D6400;
		border-color: #0D6400;
		min-width: 150px;
		color: #fff;
		padding: 10px 0;
    }
    .detail td{
    	background-color: #fff;
    	font-weight: bold;
    }
    .detail td:active, .detail td:hover, .detail td:focus {
		color: #0D6400 !important;
		/* background: transparent !important; */
	}
	.detail .active{
    	background-color: #F0F0F0;
    }
    /* ajax */
    .box{
    	margin: 50px;
    }
    .box table{
    	height: 400px;
    	text-align: center;
    }
    .box table th, .delivery table th{
    	text-align: center;
    	background-color: #F0F0F0;
    }
    .delivery{
    	margin: 50px 400px;
    }
    .delivery table{
    	margin: 30px 0;
    	text-align: center;
    	width: 1100px;
    	height: 300px;
    } 
    .delivery b{
    	font-size: 18px;
    	color: #0D6400;
    }
    .revboard{
    	margin-bottom: 50px;
    }
   
    .revboard table tr{
    	height: 50px;
    	border-bottom: 1px solid lightgrey;
    } 
    .revboard table{
    	text-align: center;
    	margin: 50px;
    	width: 1000px;
    	border-top: 1.5px solid lightgrey;
    	border-bottom: 1.5px solid #0D6400;
    	margin-bottom: 30px;
    }
    .revboard .title:hover, .revboard .title:active{
    	background-color: #F0F0F0;
    }
    .revboard .firstrow{
    	background-color: #FFFAF2;
    }
    .revboard .title {
    	font-weight: bold;
    }
    .writebtn{
  		font-weight: bold;
		background: #0D6400;
		border-color: #0D6400;
		min-width: 100px;
		color: #fff;
		margin-left: 800px;
    }
</style>
</head>

<!-- body----------------------------------------------------------------------------------------->
<body onload="init();">
<%
ProductDto dto = (ProductDto)request.getAttribute("dto");

//가격 표기 함수
DecimalFormat formatter = new DecimalFormat("###,###");
%>
<br><br>
<div class="container">

<div class="prdinfo" align="center">
<!-- 상품 이미지 -->
	<div class="image">
		<table>
			<tr>
				<td>
					<% 
		   			if( dto.getPrd_num()%10 > 5){
		   			%>
		   				<img src="./upload/<%=dto.getImg_name() %>"  width="550px">
		   			<%	
		   			}else{
		   			%>
		   				<img src="img/prdimg/<%=dto.getImg_name() %>">
		   			<%	
		   			}
		   			%>
				</td>
			</tr>
		</table>
	</div>	

<!-- 상품 정보 -->
	<div class="infoRight">
		<form name="form" action="product?work=addCart" method="post">	
				<table>
				<col width="200px">
					<tr id="title">
						<td colspan="2" style="padding-bottom: 5px"><h3><b><%=dto.getName() %></b></h3></td>
					</tr>
					<tr>
						<td colspan="2"><%=dto.getInfo() %> </td>
					</tr>
					<tr><td colspan="2"><hr></td></tr>
					<tr>
						<td>판매가</td><td><b class=price><%=formatter.format( dto.getPrice() ) %></b>원</td>
					</tr>
					<tr>
						<td>규격</td><td><%=dto.getSize() %></td>
					</tr>
					<tr>
						<td>원산지</td><td><%=dto.getOrigin() %></td>
					</tr>
					<tr><td colspan="2"><hr></td></tr>
					<tr>
						<td>구입 수량</td>
						<td>
							<input type=hidden name="sell_price" value="<%=dto.getPrice()%>">
							<input type="button" value=" + " onclick="add();">
							<input style="text-align: right;" type="text" name="amount" value="1" size="3" onchange="change();">
							<input type="button" value=" - " onclick="del();">
						</td>
					</tr>
					<tr><td colspan="2"><hr></td></tr>
					<tr>
						<td>금액</td>
						<td><input type="text" name="sum" id="sum" size="11" readonly>원</td>
						<!-- <td style="text-align: right">0원</td> -->
					</tr>
					<tr>
						<td colspan="2" align="center" style="padding-top: 30px">
							<input type="hidden" name="prd_num" value="<%=dto.getPrd_num()%>">
	 						<input class="btn" type="submit" id="cart" value="장바구니">&nbsp;&nbsp;
							<span class="btn" id="buyNow" >바로구매</span>
						</td>
					</tr>
				</table> 
			</form>
		</div>
	</div>
<br>
</div>

<div id=detailmenu align="center">
	<div class="detail">
		<table>
			<col width="250px"><col width="250px"><col width="250px">
			<tr>
				<td colspan="3"><hr></td>
			</tr>
			<tr style="text-align: center; height: 50px">
				<td class="active" id="prd_info">제품정보</td>
				<td id="del_info">배송정보</td>
				<td id="prd_review">제품후기</td>
			</tr>
			<tr>
				<td colspan="3"><hr></td>
			</tr>
		</table>
	</div>
</div>
<!-- 수량 / 금액 설정 함수 -->
<script type="text/javascript">
var sell_price;
var amount;

function init () {
	sell_price = document.form.sell_price.value;
	amount = document.form.amount.value;
	document.form.sum.value = sell_price;
	change();
}

function add () {
	hm = document.form.amount;
	sum = document.form.sum;
	hm.value ++ ;

	sum.value = parseInt(hm.value) * sell_price;
}

function del () {
	hm = document.form.amount;
	sum = document.form.sum;
		if (hm.value >= 1) {
			hm.value -- ;
			sum.value = parseInt(hm.value) * sell_price;
		}
}

function change () {
	hm = document.form.amount;
	sum = document.form.sum;

		if (hm.value < 0) {
			hm.value = 0;
		}
	sum.value = parseInt(hm.value) * sell_price;
}  
//name="amount" 구입수량 , name="sum" 총 금액

$(document).on( "click", "#cart", function() {
	
	if( $("#sum").val() == 0 ) {
		alert("구매 수량을 설정해주세요.");
		return false;
	}
<%
//	Object ologin = session.getAttribute("login");
	
	if(mem == null ){
	%>
		alert("로그인해주세요.");
		location.href="login.jsp";
		return false;
	<%
	}
%>
	
});

</script>

<!-- 바로구매 함수  -->
<script type="text/javascript">
document.getElementById("buyNow").addEventListener("click", function() {
	   // let x = document.getElementsByName("prd_num").innerHTML.value;
	    let x = $('input[name="prd_num"]').val();
	    console.log(x);
	    let y = $('input[name="amount"]').val();
	    console.log(y);
	    let z = $('input[name="sum"]').val();
	   	console.log(z);
	   	
	   	location.href= "product?work=buyNow&prdnum=" + x + "&amount=" + y + "&sum=" + z;
	}, false);
</script>


<!-- 상품정보 append --> 
<script type="text/javascript">

let tb = '<div id ="box" class="box" align="center">' +
		'<table border="1">' +
		'<col width="150px"><col width="400px">' +
		'<tr>' +
		'	<th>제품명</th><td><%=dto.getName()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>가격</th><td><%=dto.getPrice()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>규격</th><td><%=dto.getSize()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>원산지</th><td><%=dto.getOrigin()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>유통기한</th><td><%=dto.getExpdate()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>보관방법</th><td><%=dto.getKeep()%></td>' +
		'</tr>' +
		'<tr>' +
		'	<th>포장상태</th><td><%=dto.getPack()%></td>' +
		'</tr>' +
		'</table>' +
		'</div>';
$("#detailmenu").append(tb);
		
$("#prd_info").click( function() {
		//alert('success');
		$(".active").removeClass();
		$(this).attr("class","active");
		$("#box").remove();
		$("#detailmenu").append(tb);
});
</script>

<!-- 배송/반품/교환  append -->
<script type="text/javascript">
$("#del_info").click( function() {
	$(".active").removeClass();
	$(this).attr("class","active");
	let delinfo = '<div class="delivery" id="box" align="center">' + 
					'<div style="text-align: left"><b>01. 배송정보</b>' +
					'<table border="1">' +
					'<tr height="70px">'+
					'	<th>제품</th><th>도착일</th><th>배송</th>'+
					'</tr>'+
					'<tr>'+
					'	<td>신선/냉동상품있는 주문</td><td>지정한 공급일에 도착</td><td>생협공급자</td>'+
					'</tr>'+
					'<tr>'+
					'	<td>상온 상품만 주문</td><td>결제 완료 2-3일 후 도착(※택배사 사정에 따라 1-2일 지연 가능, 제주/도서산간지역은 약 2일 추가요소 가능 )</td>'+
					'	<td>택배기사</td>'+
					'</tr>'+
					'</table><br>'+
					'■ 모든 상품은 공급(구입) 즉시 상품상태를 확인하시기 바랍니다.<br>'+
					'■ 상온 상품만 주문 주문/결제 완료 후 다음날 발송<br>'+
					'<br>'+
					'1. 상온 상품만 주문시 기본은 택배공급이나 2일 후 공급자 공급일이 가능한 경우 공급자를 통해 배송됩니다.<br>'+
					'2. 별도 배송기간 안내가 있을 경우 별도 안내를 우선합니다.<br>'+
					'  - 명절 연휴, 법정 공휴일, 예약/기획 상품, 산지 배송상품 이 외 배송관련 사전 알림이 있는 경우<br>'+
					'3. 배송비 및 배송가능 지역<br>'+
					'  - 2,500원, 50,000 이상 무료배송<br>'+
					'  - 배송지역은 전국배송이나 일부 도서지역 / 택배불가 지역 제외입니다.<br>'+
					'4. 배송기간 예외 사항<br>'+
					'  - 추가 배송기간 소요 : 제주도 및 도서산간 지역으로 배송시 배송기간은 약 4~6일 소요될 수 있습니다. 각 영업소 사정에 따른 배송지연은 배송기간에 포함되지 않음'+
				'</div><br>'+
				'<div style="text-align: left">'+
				'	<b>02. 반품/교환 유효기간</b><br>'+
				'	제품에 이상이 있을 경우 교환/반품은 상품 수령일로부터 2일 이내입니다. (단, 유통기한이 넘지 않은 제품과 개봉하지 않은 제품만 가능)<br>'+
				'	제품 이상이란? 제품의 파손, 변질, 유통기한 경과, 이물질 혼입 등 상품에 중대한 결함이 발생한 경우를 지칭함.<br>'+
				'<br>'+	
				'	- 생식품/신선식품/냉동식품 : 상품수령 후 2일 이내<br>'+
				'	- 상온상품 : 상품수령 후 7일 이내<br>'+
				'<br>'+
				'	<b>03. 반품/교환 배송비용</b><br>'+
				'	고객 단순변심에 의한 교환/반품은 배송비가 고객부담입니다. (고객부담 배송비 6,000원 - 왕복배송비)<br>'+
				'	(단, 신선식품(채소, 청과, 일부 신선가공식품) / 냉동식품은 고객변심으로인한교환/반품/환불 불가)<br>'+
				'<br>'+
				'	고객 단순변심이란?<br>'+
				'	- 개인 사정에 의한 부재로주문 상품을 미수령할 경우<br>'+
				'	- 주문 상품에 대해 특별한 사유없이 취소 / 반품할 경우<br>'+
				'<br>'+
				'	<b>04. 취소/반품/교환 불가 사항</b><br>'+
				'	해당 상품이 포함된 주문건은 고객 단순변심에 의한 취소/교환/반품이 불가합니다.<br>'+
				'	- 신선식품 : 채소, 청과, 일부 신선가공식품<br>'+
				'	- 냉동식품'+
				'</div>'+
				'</div>';
	$("#box").remove();
	$("#detailmenu").append(delinfo);
	
});
</script>   

<!-- 후기 게시판 리스트 ajax -->    
<script type="text/javascript">
$("#prd_review").click( function() {
	$(".active").removeClass();
	$(this).attr("class","active");
	$.ajax({
		url:"product",
		type:"post",
		data:"work=review&prd_num=" + "<%=dto.getPrd_num()%>",
		success:function(datas){
			//alert('success');
			let revlist = datas.map.list;
			let bbsPage = datas.map.bbsPage;
			let pageNumber = datas.map.pageNumber;
			
			let tb = '<div id="box" class="revboard">' +
					 '<table class="rev_tb">' + 
					 '<col width="50px"><col width="100px"><col width="600px">' +
					 '<tr class="firstrow">' +
					 '	<td></td><td>평점</td><td>제목</td><td>ID</td><td>작성일</td>' +
					 '</tr>'; 
			if(revlist[0] == null){
				tb += '<tr>' +
					  '	<td colspan=5>작성된 후기가 없습니다.</td></tr>' +
					  '</table>';
			}else{
				$.each(revlist, function(i, dto) {
					
					tb += '<tr class="title">' +
						 '	<td>' + (i + 1) + '</td><td><img src="./img/stars/star' + dto.score + '.png" width="100px"></td><td id="title" class="title">' + dto.title + '</td><td>' + dto.id + '</td><td>' + dto.wdate.substr(0, 10) + '</td>' +
						 '</tr>' + 
						 '<tr style="height: 150px; display:none" id="content">' +
						 '<td></td>' +
					  	 '<td colspan="4">' + dto.content;
					if( dto.filename != "" ){						
						tb += '<br><img src="upload/' + dto.filename + '" width="500px">';
					}
					
					<%
					if (mem != null){
					%>
						if( dto.id == "<%=mem.getId()%>" || <%=mem.getAuth()%> == 1){
							
						tb += '<br><button type="button" id="updatebtn">수정</button>' +
						  '<button type="button" id="delbtn" onclick="goDelete(' + pageNumber + ')">삭제</button>' +
						  '<input type="hidden" id="hiddenseq" value="' + dto.seq +'">';
						}
					<%
					}
					%>
				});	
			}	
				tb += '</td></tr></table>';
			 	  
			for (var i = 0; i < bbsPage; i++) {
				if(pageNumber == i){
					tb += '<span style="font-size: 15pt; color: #0D6400; font-weight: bold">' + (i+1) + '</span>&nbsp;';
				}else{
					tb += '<a href="#none" title="' + (i+1)+ '페이지" onclick="goPage(' + i + ')"' +
						  'style="font-size: 14pt; color: lightgrey; font-weight: bold; text-decoration: none">' + (i+1) + '' + 
						  '</a>&nbsp;';
				}
			}		  
			 //해당상품 구입여부 설정 추가
					tb+=  '<div class="btn writebtn">후기등록 </div>' + 
					  '</div>';			
			$("#box").remove();
			$("#detailmenu").append(tb);
		},
		error:function(){
			alert('error');
		}
	});
	
});
</script>

<!-- 페이징 ajax -->  
<script type="text/javascript">
function goPage( pageNum ) {
	$.ajax({
		url:"product",
		type:"post",
		data:"work=review&prd_num=" + "<%=dto.getPrd_num()%>" + "&pageNumber=" + pageNum,
		success:function(datas){
			//alert('success');
			let revlist = datas.map.list;
			let bbsPage = datas.map.bbsPage;
			let pageNumber = datas.map.pageNumber;
			let tb = '<div class="revboard" id="box">' +
					 '<table class="rev_tb">' + 
					 '<col width="50px"><col width="100px"><col width="600px">' +
					 '<tr class="firstrow">' +
					 '	<td></td><td>평점</td><td>제목</td><td>ID</td><td>작성일</td>' +
					 '</tr>'; 
			if(revlist[0] == null){
				tb += '<tr>' +
				 '	<td colspan=5>작성된 후기가 없습니다.</td></tr>';
			}else{
				$.each(revlist, function(i, dto) {
					
					tb += '<tr class="title">' +
						 '	<td>' + (i + 1) + '</td><td><img src="./img/stars/star' + dto.score + '.png" width="100px"></td><td id="title" class="title">' + dto.title + '</td><td>' + dto.id + '</td><td>' + dto.wdate.substr(0, 10) + '</td>' +
						 '</tr>' + 
						 '<tr style="height: 150px; display:none" id="content" class="title">' +
						 '<td></td>' +
					  	 '<td colspan="4">' + dto.content;
					if( dto.filename != "" ){
						tb += '<br><img src="./upload/' + dto.filename + '" width="500px">';
					}
					<%
					if (mem != null){
					%>
						if( dto.id == "<%=mem.getId()%>" || <%=mem.getAuth()%> == 1 ){
							tb += '<br><button type="button" id="updatebtn">수정</button>' +
							  '<button type="button" id="delbtn" onclick="goDelete(' + pageNum + ')">삭제</button>' +
							  '<input type="hidden" id="hiddenseq" value="' + dto.seq +'">';
							}
					<%
					}
					%>
				});	
			}	
				tb += '</td></tr></table>'; 
					  
			for (var i = 0; i < bbsPage; i++) {
				if(pageNumber == i){
					tb += '<span style="font-size: 15pt; color: #0D6400; font-weight: bold">' + (i+1) + '</span>&nbsp;';
				}else{
					tb += '<a href="#none" title="' + (i+1)+ '페이지" onclick="goPage(' + i + ')"' +
						  'style="font-size: 14pt; color: lightgrey; font-weight: bold; text-decoration: none">' + (i+1) + '' + 
						  '</a>&nbsp;';
				}
			}		  
					  //해당상품 구입여부 설정 추가
					tb+=  '<div class="btn writebtn">후기등록 </div>' + 
					  '</div>';
			$("#box").remove();
			$("#detailmenu").append(tb);
		},
		error:function(){
			alert('error');
		}
	});
}
</script>   

<!-- 후기게시판 toggle -->
<script type="text/javascript">
$(document).ready(function(){
	$(document).on( "click", ".title", function() {
		//$("#content").toggle();
		var obj = $(this);

		obj.parent().next().toggle(500);
	});
});

// 후기 글쓰기
$(document).on( "click", ".writebtn", function() {
	window.open("./review/reviewWrite.jsp?prd_num=<%=dto.getPrd_num()%>", "리뷰작성", "width=650, height=550, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
});
// 후기 수정 
$(document).on( "click", "#updatebtn", function() {
	window.open("product?work=reviewUpdate&seq=" + $("#hiddenseq").val(), "리뷰수정", "width=650, height=550, toolbar=no, menubar=no, scrollbars=no, resizable=yes method=post");
});
</script>

<!-- 삭제 ajax -->
<script type="text/javascript">
function goDelete( pageNum ) {
	
 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		
	$.ajax({
		url:"product",
		type:"post",
		data:"work=reviewDelete&seq=" + $("#hiddenseq").val() + "&pageNumber=" + pageNum,
		success:function(datas){
			let revlist = datas.map.list;
			let bbsPage = datas.map.bbsPage;
			let pageNumber = datas.map.pageNumber;
			let isS = datas.map.b;
			
			if(isS){
				alert('삭제되었습니다.');
			}else{
				alert('삭제에 실패했습니다.');
			}
			let tb = '<div class="revboard" id="box">' +
					 '<table class="rev_tb">' + 
					 '<col width="50px"><col width="100px"><col width="600px">' +
					 '<tr class="firstrow">' +
					 '	<td></td><td>평점</td><td>제목</td><td>ID</td><td>작성일</td>' +
					 '</tr>'; 
			if(revlist[0] == null){
				tb += '<tr>' +
				 '	<td colspan=5>작성된 후기가 없습니다.</td></tr>';
			}else{
				$.each(revlist, function(i, dto) {
					
					tb += '<tr class="title">' +
						 '	<td>' + (i + 1) + '</td><td><img src="./img/stars/star' + dto.score + '.png" width="100px"></td><td id="title" class="title">' + dto.title + '</td><td>' + dto.id + '</td><td>' + dto.wdate.substr(0, 10) + '</td>' +
						 '</tr>' + 
						 '<tr style="height: 150px; display:none" id="content" class="title">' +
						 '<td></td>' +
					  	 '<td colspan="4">' + dto.content;
					if( dto.filename != "" ){
						tb += '<br><img src="./upload/' + dto.filename + '" width="500px">';
					}
					<%
					if (mem != null){
					%>
						if( dto.id == "<%=mem.getId()%>" || <%=mem.getAuth()%> == 1 ){
							tb += '<br><button type="button" id="updatebtn">수정</button>' +
							  '<button type="button" id="delbtn" onclick="goDelete(' + pageNum + ')">삭제</button>' +
							  '<input type="hidden" id="hiddenseq" value="' + dto.seq +'">';
					}
					<%
					}
					%>
				});	
			}	
				tb += '</td></tr></table>'; 
					  
			for (var i = 0; i < bbsPage; i++) {
				if(pageNumber == i){
					tb += '<span style="font-size: 15pt; color: #0D6400; font-weight: bold">' + (i+1) + '</span>&nbsp;';
				}else{
					tb += '<a href="#none" title="' + (i+1)+ '페이지" onclick="goPage(' + i + ')"' +
						  'style="font-size: 14pt; color: lightgrey; font-weight: bold; text-decoration: none">' + (i+1) + '' + 
						  '</a>&nbsp;';
				}
			}		  
					  //해당상품 구입여부 설정 추가
					tb+=  '<div class="btn writebtn">후기등록 </div>' + 
					  '</div>';
			$("#box").remove();
			$("#detailmenu").append(tb);
		},
		error:function(){
			alert('삭제에 실패했습니다.');
		}
	});
}else{   //취소

    return false;

}
}
</script>


<%@ include file="parts/footer.jsp" %>

</body>
</html>