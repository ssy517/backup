<%@ page import="dto.WbBbsDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    WbBbsDto dto = (WbBbsDto)request.getAttribute("update");
    System.out.println(dto);
%>
<html>
<head>
    <style>

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
  
<title>HEALTHY & HAPPY</title>
<%@ include file="parts/header.jsp" %>  
</head>
<body>

        <h1 align="center"> 글 수정</h1>


<form action="wbbbs?write=updateAf" method="get">
    <input type="hidden" name="write" value="updateAf">
    <input type="hidden" name="seq" value="<%=dto.getSeq() %>">
    <table border="1" align="center">
        <colgroup>
        <col width="200">
        <col width="400">
        </colgroup>
        <tr>
            <th>작성자</th>
            <td><input type="text" name="id" value="<%=dto.getId() %>" readonly="readonly"></td>
        </tr>

        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="<%=dto.getTitle() %>"></td>
        </tr>

        <tr>
            <th>내용</th>
            <td><textarea rows="30" cols="110" name="content"><%=dto.getContent() %></textarea></td>
        </tr>

    </table>
    <div align="center">
     <input  type="submit" value="글 수정">
   <input type="reset" value="취소">
    </div>
</form>

<%@ include file="parts/footer.jsp" %>  
</body>
</html>
