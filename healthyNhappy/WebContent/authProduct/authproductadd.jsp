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
<%@ include file="../parts/header.jsp" %>  
<style type="text/css">
.container{
	padding-top: 140px;
}
.menu {
	float: left;
	margin-left: 250px;
	margin-top: 50px;
}
.menu table{
	width: 200px;
	height: 250px;
	font-size: 16px;
}
.menu tr{
	border-bottom: 1px solid lightgrey;
}
.menu tr:hover{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.menu a{
	text-decoration: none;
	color: black;
}
.menu .active{
	border-bottom: 2px solid #0D6400;
	font-weight: bold;
}
.list table{
	margin-top: 50px;
	width: 600px;
    margin-right: 360px;
}
.list table input{
	width: 100%;
}
.list table textarea{
	width: 100%;
    margin-top: 5px;
}
.list table tr{
	border-bottom: 1px solid lightgrey;
	height: 50px;
}
.list table hr{
	border-top: 2px solid #0D6400;
}
.list table th{
	text-align: center;
}
.list table img{
	margin: 5px 0;
}
.container .btn{
   	font-weight: bold;
	background: #0D6400;
	color: #fff;
	border-color: #0D6400;
	min-width: 100px;
	margin: 0 5px;
	margin-bottom: 30px;
}
table img{
	width: 450px;
}	
</style>
</head>


<body>
<br><br><br>
<div class="container">

	<div class="menu">
		<table>
			<tr><td><a href="authProduct?work=chart">제품차트</a></td></tr>
			<tr class="active"><td><a href="authProduct?work=list">제품관리</a></td></tr>
			<tr><td><a href="">주문관리</a></td></tr>
			<tr><td><a href="Manager?action=list">회원정보관리</a></td></tr>
		</table>
	</div>

	<div class="list" align="center">
		<form action="authProduct?work=add" method="post" enctype="multipart/form-data" id="frm">
		<table>
			<col width="150px">
			<tr style="border-bottom: 0px solid black">
				<td colspan="4"><hr style="margin:0;"></td>
			</tr>
			<tr>
				<th>제품명</th><td colspan="3"><input class="write" type="text" name="name" id="name"></td>
			</tr>
			<tr>
				<th>제품 카테고리</th>
				<td>
				<select id="cate" name="category">
					<option value="select">선택</option>
					<option value="110">생과일</option>
					<option value="120">냉동과일</option>
					<option value="210">잎채소</option>
					<option value="220">뿌리채소</option>
					<option value="230">열매채소</option>	
				</select>
				</td>
				<th>가격</th><td><input type="text" name="price" id="price"></td>
			</tr>
			<tr>
				<th>재고</th><td><input type="text" name="amount" id="amount"></td>
				<th>판매량</th><td><input type="text" name="sell" id="sell"></td>
			</tr>
			<tr style="border-bottom: 0px">
				<th>제품이미지</th><td colspan="3"><input type="file" name="fileload" id="fileload"></td>
			</tr>
			<tr style="height: 0">
				<td></td><td colspan="3" id="preview"></td>
			</tr>
			<tr>
				<th>규격</th><td><input class="write" type="text" name="size" id="size"></td>
				<th>원산지</th><td><input class="write" type="text" name="origin" id="origin"></td>
			</tr>
			<tr>
				<th>보관방법</th><td><input class="write" type="text" name="keep" id="keep"></td>
				<th>포장</th><td><input class="write" type="text" name="pack" id="pack"></td>
			</tr>
			<tr>
				<th>유통기한</th>
				<td colspan="3">
					<textarea class="write" name="expdate" rows="4" cols="50" id="expdate"></textarea> 
				</td>
			</tr>
			<tr>
				<th>제품설명</th>
				<td colspan="3">
					<textarea class="write" name="info" rows="4" cols="50" id="info"></textarea> 
				</td>
			</tr>
			<tr style="border-bottom: 0px solid black">
				<td colspan="4"><hr style="margin:0;"></td>
			</tr>
		</table><br>
		<input class="btn" id="cancelbtn" type="button" value="취소">
		<input class="btn" id="writebtn" type="submit" value="등록">
		</form>
	</div>
</div>
	
<%@ include file="../parts/footer.jsp" %>  

<!-- 파일 프리뷰 함수 -->
<script type="text/javascript">
var upload = document.querySelector('#fileload');
var preview = document.querySelector('#preview');

upload.addEventListener('change',function (e) {
    var get_file = e.target.files;

    var image = document.createElement('img');

    /* FileReader 객체 생성 */
    var reader = new FileReader();

    /* reader 시작시 함수 구현 */
    reader.onload = (function (aImg) {
        console.log(1);

        return function (e) {
            console.log(3);
            /* base64 인코딩 된 스트링 데이터 */
            aImg.src = e.target.result
        }
    })(image)

    if(get_file){
        /* 
            get_file[0] 을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 
            onload 에 설정했던 return 으로 넘어간다.
       	     이와 함게 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.
        */
        reader.readAsDataURL(get_file[0]);
        console.log(2);
    }
    preview.appendChild(image);
})
</script>

<script type="text/javascript">

$("#writebtn").click(function(){
	
	if( $("#name").val().trim() == "" ){
		alert("제품명을 입력해주세요.");
		return false;
	}if( $("#cate").val() == "select" ){
		alert("제품 카테고리를 선택해주세요.");
		return false;
	}if( $("#price").val().trim() == "" ){
		alert("가격을 입력해주세요.");
		return false;
	}if( $("#amount").val().trim() == "" ){
		alert("재고를 입력해주세요.");
		return false;
	}if( $("#sell").val().trim() == "" ){
		alert("판매량을 입력해주세요.");
		return false;
	}if( $("#fileload").val().trim() == "" ){
		alert("파일 이미지를 업로드해주세요.");
		return false;
	}if( $("#size").val().trim() == "" ){
		alert("규격을 입력해주세요.");
		return false;
	}if( $("#origin").val().trim() == "" ){
		alert("원산지를 입력해주세요.");
		return false;
	}if( $("#keep").val().trim() == "" ){
		alert("보관방법을 입력해주세요.");
		return false;
	}if( $("#pack").val().trim() == "" ){
		alert("포장상태를 입력해주세요.");
		return false;
	}if( $("#expdate").val().trim() == "" ){
		alert("유통기한을 입력해주세요.");
		return false;
	}if( $("#info").val().trim() == "" ){
		alert("제품설명을 입력해주세요.");
		return false;
	}

});

$("#cancelbtn").click( function() {
	location.href="authProduct?work=list"; 
});
</script>

</body>
</html>