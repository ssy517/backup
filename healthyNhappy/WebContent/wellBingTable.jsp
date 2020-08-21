<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<table border="1">
    <col width="100"> <col width="600"> <col width="130"> <col width="155">
    <tr>
        <th style="text-align: center">번호</th><th style="text-align: center">제목</th><th style="text-align: center">작성자</th><th style="text-align: center">작성일</th>
    </tr>
    <c:choose>
        <c:when test="${wlist eq null}">
            <tr>
                <td colspan="4" align="center">"${searchWord}"일치하는  게시글이 없습니다. </td>
            </tr>
        </c:when>
        <c:when test="${wlist ne null}">
            <c:forEach items="${wlist}" var="wbs" varStatus="status">
                <tr>
                    <th>${status.index+1}</th>
                    <td>
                        <c:choose>
                            <c:when test="${wbs.del eq 0}">
                                <a href="wbbbs?write=detailView&seq=${wbs.seq}">
                                    ${wbs.title}
                                </a>
                            </c:when>
                            <c:when test="${wbs.del ne 0}">
                                <font color="#ff0000"> *********** 이글은 작성자에 의해 삭제 되었습니다.</font>
                            </c:when>
                        </c:choose>
                    </td>
                    <td align="center">${wbs.id}</td>
                    <td align="center">${wbs.wdate}</td>
                </tr>
            </c:forEach>
        </c:when>
    </c:choose>
</table>
<c:forEach begin="0" end="${wbBbsPage-1}" varStatus="status">
    <c:if test="${pageNumber == status.index}">
        <span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
            ${status.index+1}
		</span>
    </c:if>
    <c:if test="${pageNumber != status.index}">
        <a href="#" title="${status.index+1}페이지" onclick="goPage(${status.index})"
           style="font-size:  15pt; color: #000; font-weight: bold; text-decoration: none">
            [${status.index+1}]
        </a>
    </c:if>
</c:forEach>