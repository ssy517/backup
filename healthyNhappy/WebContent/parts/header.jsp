<%@page import="dto.MemberDto"%>
<head>
<meta charset="utf-8">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/css?family=Raleway|Open+Sans" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>	

<style>
	body{
		font-family: 'Open Sans', 'Nanum Gothic', sans-serif;
	}
	.header {
		position: fixed;
		width: 100%;
		background: #fff;
		font-family: 'Open Sans', 'Nanum Gothic', sans-serif;
		height: 150px;
		z-index: 10;
	}
    .form-inline {
        display: inline-block;
    }
    .logoTop{
    	padding:10px;
    	margin-bottom: 10px;
    }
    .centerTop{
    	float: center;
    }
    .rightTop{
    	height: 30px;
    }
    .rightTop ul li {
    	font-weight: bold;
    	color: #777;
    	margin-right: 5px;
    	list-style: none;
    	text-align: right;
    	float: right;
    }
    .rightTop li a{
    	text-decoration: none;
    	display: block;
    	color: #777;
    }
    .rightTop li:hover > a, .rightTop li:focus > a {
		color: #0D6400 !important;
		background: transparent !important;
	}
	.navbar {
		font-size: 14px;
		background: #fff;
		padding-left: 16px;
		padding-right: 16px;
		border-bottom: 1px solid #d6d6d6;
		box-shadow: 0 0 4px rgba(0,0,0,.1);		
	}
	.navbar .navbar-brand {
		color: #555;
		padding-left: 120px;
		font-size: 20px;
		padding-right: 50px;
		font-family: 'Raleway', sans-serif;
		text-transform: uppercase;
	}
	.navbar .navbar-brand b {
		font-weight: bold;
		color: #0D6400;
	}
	#menu{
		padding-left: 285px;
	}
	.navbar ul.nav li {
		font-size: 110%;
		font-weight: bold;		
		text-transform: uppercase;
		padding-left: 15px;
		padding-right: 15px;
		margin: 0 auto;
		text-align: center;
	}
	.navbar ul.nav li.active a:active, .navbar ul.nav li.active a:hover, .navbar ul.nav li.active a:focus {
		color: #0D6400 !important;
		background: transparent !important;
	}
	li.on{
		color: #0D6400;
	}
	.search-box {
         position: relative; 
    }
	.search-box input.form-control, .search-box .btn {
		font-size: 14px;
		border-radius: 2px !important;
	}
	.search-box .input-group-btn {
		padding-left: 4px;		
	}
	.search-box input.form-control:focus {
		border-color: #0D6400;
		box-shadow: 0 0 8px rgba(240,79,1,0.2);
	}
	.search-box .btn-primary, .search-box .btn-primary:active {
		font-weight: bold;
		background: #0D6400;
		border-color: #0D6400;
		text-transform: uppercase;
		min-width: 90px;
	}
	.search-box .btn-primary:focus {
		outline: none;
		background: #0A4B00;
		box-shadow: 0 0 8px rgba(240,79,1,0.2);
	}
	.search-box .btn span {
		transform: scale(0.9);
		display: inline-block;
	}
	.navbar ul li i {
		font-size: 18px;
	}
	.dropdown:hover .dropdown-menu { 
		display: block; 
	}
	.navbar .dropdown-menu i {
		font-size: 16px;
		min-width: 22px;
	}
	.navbar .dropdown.open > a {
		background: none !important;
	}
	.navbar .dropdown-menu {
		display: none;
		border-radius: 1px;
		border-color: #e5e5e5;
		box-shadow: 0 2px 8px rgba(0,0,0,.05);
	}
	.navbar .dropdown-menu li a {
		color: #777;
		padding: 8px 20px;
		line-height: normal;
		font-size: 14px;
		margin: 0 auto;
	}
	.navbar .dropdown-menu li a:hover, .navbar .dropdown-menu li a:active {
		color: #333;
	}
	.navbar .navbar-form {
		border: none;
	}
	@media (min-width: 992px){
		.form-inline .input-group .form-control {
			width: 225px;			
		}
	}
	@media (max-width: 992px){
		.form-inline {
			display: block;
		}
	}
	.container{
	padding-left: 0;
	padding-right: 0;
	margin-left:0;
	margin-right:0;
	padding-top: 150px;
	width: 100%;
	}
	
</style>
</head> 

<div class="header">
<div class="logoTop">
	<nav class="rightTop">
		<ul>
			<%if(mem == null){%> 
				<li><a href='Yhregi.jsp'>회원가입</a></li>
			<%}%>
			<%
	    	if(mem == null || mem.getId().equals("")){
	    	%>
			 	<li><a href='Yhlogin.jsp'>로그인</a></li>
			<%
			}else if(mem != null && mem.getAuth() == 2){
			%>
				<li><a href="member?action=logout2" method="dopost" >로그아웃</a></li>
				
			<%
			}else if(mem != null && mem.getAuth() == 1){
			%>
				<li><a href="member?action=logout2" method="dopost" >로그아웃</a></li>
				<li><a href="authProduct?work=chart">관리자페이지</a></li>
			<%
			}
			%> 	
			<li><a href="product?work=mycart">장바구니</a></li>
			<li><a href="product?work=mypage">마이페이지</a></li>
		</ul>
	</nav>
	<div class="centerTop" align="center">
		<a href="main.jsp"><img alt="" src="img/logo/HEALTHYNHAPPY.png" height="50px"></a>
	</div>
	
</div>
<nav class="navbar navbar-default navbar-expand-lg navbar-light">
	
	<div class="navbar-header">
		<a class="navbar-brand" href="main.jsp">Healthy<b>&Happy</b></a>  		
		<button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
			<span class="navbar-toggler-icon"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	</div>
	<!-- Collection of nav links, forms, and other content for toggling -->
	<div id="navbarCollapse" class="collapse navbar-collapse">
		
		<ul class="nav navbar-nav" id="menu">
			<li><a href="main?work=about">회사소개</a></li>			
			<li class="dropdown">
				<a href="product?work=list&category=all">제품보기 <b class="caret"></b></a>
				<!-- data-toggle="dropdown" -->
				<ul class="dropdown-menu">					
					<li><a href="product?work=list&category=all">전체</a></li>
					<li><a href="product?work=list&category=fruit">과일</a></li>
					<li><a href="product?work=list&category=vegi">채소</a></li>
				</ul>
				
			</li>
			<!-- class="active" -->
			<li><a href="main?work=delivery">배송안내</a></li>
			<li><a href="wbbbs?write=choice">웰빙스토리</a></li>
			<li><a href="main?work=QAlistView">Q & A</a></li>
		</ul>
		<span class="navbar-form form-inline navbar-right ml-auto">
			<div class="input-group search-box">
				
				<input type="text" class="form-control"
				id="searchword" value="${map.searchWord}" onkeypress="if(event.keyCode==13) {goSearch();}">
				<span class="input-group-btn">
					<button type="button" class="btn btn-primary"  onclick="goSearch()"><span>Search</span></button>
				</span>
			</div>
		</span>		
	</div>
</nav>
</div>
    <!--  <br><br><br><br><br><br><br><br> -->
<script type="text/javascript">
function goSearch() {
	var word = document.getElementById("searchword").value;
	if(word.trim() == "" ){
		alert("검색어를 입력해주세요.");
		return false;
	}else{
		//alert("word:" + word);
		/* location.href = "main?work=search&searchWord=" + word;		 */
		location.href = "wbbbs?write=search&searchWord=" + word + "&pageNumber=0";
	}
}

$(function() {
	$("li").click(function() {
		$("li").removeClass();
		$(this).addClass("on");
	});
});
</script>