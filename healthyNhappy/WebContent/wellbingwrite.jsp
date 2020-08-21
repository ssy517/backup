<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<html>
<head>


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
/* Some more styles to beutify this example */
nav a {
	color: #fff;
	text-decoration: none;
	padding: 7px 25px;
	display: inline-block;
}

.container p {
	line-height: 200px; /* Create scrollbar to test positioning */
}
.pan {
	font-family: Georgia, "맑은 고딕", serif;
}

.pan {
	padding: 40px;
	margin-top: 20px;
}

.logo-top {
	position: relative, fixed;
	overflow: hidden;
	background-color: #66ff66;
	width: 800px;
	padding: 10px;
	margin: 0 auto;
	border-radius: 10px;
}

.table {
	margin: 50px;
}

.id {
	width: 80%;
	margin: 0 auto;
	border-style: solid;
	border-color: #EFEFEF;
	border-radius: 10px;
	background-color: #fffafa;
}

.con {
	width: 80%;
	margin: 3 auto;
	border-style: solid;
	border-color: #efefef;
	border-radius: 10px;
	background-color: #fffafa;
}

.con1 {
	width: 80%;
	margin-left: 110;
}

.writeButton {
	display: flex;
	justify-content: flex-end;
}
/* --------------------------------------------------------------------------------- */
/* 여기부터 사용하세요 */
</style>

<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  
</head>
<body>

	<h2 align="center">웰빙 스토리 게시판 글쓰기</h2>




	<form action="wbbbs?wrtie=dataWrite" method="post">
		<input type="hidden" name="write"  value="dataWrite">

		<table class="id">
			<col width="100">
			<col width="885">

			<tr>
				<th><font color="#535353"> 작성자</font></th>
				<td><input type="text" name="id" id="id" value="aaa"></td>
			</tr>
			<tr>
				<th><font color="#535353">제목</font></th>
				<td><input type="text" size="100" placeholder="제목" name="title" id="title"></td>
			</tr>
		</table>


		<table class="con">
			<tr>
				<th><font color="#535353">내용</font></th>
			</tr>
		</table>

		<table class="con1">
			<tr align="center">
				<td><textarea rows="30" cols="110" name="content"></textarea></td>
			</tr>
		</table>


		<div align="center">
			<table>
				<tr class="writeButton">

					<td colspan="2"><br> <input type="submit" value="등록">
						<input type="reset" value="취소"></td>

				</tr>
			</table>
		</div>
	</form>


<%@ include file="parts/footer.jsp" %>  
</body>
</html>
