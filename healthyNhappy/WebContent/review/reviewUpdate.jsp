<%@page import="dto.ReviewBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
.list table{
	margin: 30px;
	border-collapse: collapse;
	font-weight: bold;
}
.list table tr{
	height: 50px;
	border-bottom: 1px solid lightgrey;
	border-top: 1px solid lightgrey;		
}
.list textarea{
	margin: 10px 0;
}
.list caption{
	color: #0D6400;
	text-align: left;
	margin-bottom: 10px;
}
.top, .bottom{
	height: 30px;
	background-color: #0D6400;
}
.btn{
	margin-bottom: 20px;
	padding: 5px;
	font-weight: bold;
	background: #0D6400;
	border: 0;
	min-width: 100px;
	color: #fff;
	outline: 0;
	border-radius: 5px;
}
img{
	width: 550px;
}

</style>
</head>
<body>
<div id="box">
	<div class="top"></div>
	<div class="list" style="text-align: left">
		<form action="product?work=updateAf&seq=${dto.seq}" method="post" enctype="multipart/form-data" id="frm" >
			<table>
			<col width="100px">
			<caption><b>후기수정</b></caption>
			<tr>
				<td>제목</td><td><input type="text" size="60px" name="title" id="title" value="${dto.title}"></td>
			</tr>
			<tr>
				<td>평점</td>
				<td>
					<select name="score">
						<option value="5">5점 (최고예요)</option>
						<option value="4">4점 (좋아요)</option>
						<option value="3">3점 (괜찮아요)</option>
						<option value="2">2점 (그저 그래요)</option>
						<option value="1">1점 (별로예요)</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="60" name="content" id="content">${dto.content}</textarea></td>
			</tr>
			<tr>
				<td>파일 첨부</td><td><input type="file" name="update_file" id="upload"></td>
			</tr>
			<tr style="border-bottom: 0px; height: 0">
				<td colspan="2" id="preview"></td>
			</tr>
			</table>
			<div align="center">
				<button class="btn" id="cancelbtn">취소</button>
				<input class="btn" type="submit" id="updatebtn" value="수정">
			</div>
		</form>
	</div>
	<div class="bottom"></div>
</div>

<!-- 파일 프리뷰 함수 -->
<script type="text/javascript">
var upload = document.querySelector('#upload');
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

$("#updatebtn").click(function(){
	
	if( $("#title").val().trim() == "" ){
		let content = $("#content").val();
		alert("제목을 입력해주세요.");
		return false;
		 setTimeout(function(){
		    $("#title").focus();
		   }, 0); 
	}else if( $("#content").val().trim() == "" ){
		alert("내용을 입력해주세요.");
		return false;
		setTimeout(function(){
		    $("#content").focus();
		   }, 0);
	}

});

$("#cancelbtn").click( function() {
	self.close(); 
});
</script>
</body>
</html>