<%@ page import="dto.WbBbsDto" %>
<%@ page import="dao.WbBbsDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    WbBbsDto dto = (WbBbsDto)request.getAttribute("wb");
	
%>

<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  
    <style>
        /* 헤더 푸터 ------------------------------------------------------------------------ */

        /* Add some padding on document's body to prevent the content
         to go underneath the header and footer */
        body{
            padding-top: 60px;
            padding-bottom: 40px;
        }
        .container{
            width: 80%;
            margin: 0 auto; /* Center the DIV horizontally */
        }
        .fixed-header, .fixed-footer{
            width: 100%;
            position: fixed;
            background: #fff;
            padding: 10px 0;
            margin-right: 20px;
            color: black;
        }
        .fixed-header{
            top: 0;
        }
        .fixed-footer{
            bottom: 0;
            background: #8AC47A;
            font-size: 12px;
        }
        /* Some more styles to beutify this example */
        nav a{
            color: #fff;
            text-decoration: none;
            padding: 7px 25px;
            display: inline-block;
        }
        .container p{
            line-height: 200px; /* Create scrollbar to test positioning */
        }
        /* --------------------------------------------------------------------------------- */
        /* 여기부터 사용하세요 */




    </style>
</head>
<body>



<h1 align="center">웰빙 정보</h1>


<div align="center">
    <table border="1">
        <colgroup>
            <col style="width: 200px">
            <col style="width: 400px">
        </colgroup>

        <tr>
            <th>작성자</th>
            <td id="id"><%=dto.getId()%>
            
            </td>
        </tr>

        <tr>
            <th>제목</th>
            <td><%=dto.getTitle() %></td>
        </tr>

        <tr>
            <th>작성일</th>
            <td><%=dto.getWdate() %></td>
        </tr>

        <tr>
            <th>조회수</th>
            <td><%=dto.getReadCount() %></td>
        </tr>

        <tr>
            <th>내용</th>
            <td><textarea rows="30" cols="110" readonly="readonly"><%=dto.getContent() %></textarea></td>
        </tr>
    </table>
    <%
        if(dto.getId()== dto.getId()){
    %>
    <button type="button" id="updateBtn">수정</button>
    <button type="button" id="deleteBtn">삭제</button>
    <%
        }
    %>

    <script type="text/javascript">
        $(document).ready(function () {
        let seq="<%=dto.getSeq() %> ";
            $("#updateBtn").click(function () {
            location.href= "wbbbs?write=updateView&seq=" + seq;

            })

            $("#deleteBtn").click(function () {
                location.href= "wbbbs?write=delete&seq=" + seq;
                <%=dto.getId() %>
            })
        })
    </script>
</div>

<%@ include file="parts/footer.jsp" %>  
</body>
</html>
