<%@page import="java.util.List"%>
<%@page import="com.my.vo.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstlTest</title>
</head>
<body>
<h3>c:set태그</h3>
<%--page에 attribute추가--%>
<c:set var="num" value="10"/>
<c:set var="num" value="hello"></c:set>
num : <%=pageContext.getAttribute("num")%>, ${num}, ${pageScope.num} <-EL표기
<c:set var="num1" value="2"/>
<c:set var="num2" value="3"/>
<c:set var="sum" value="${num1+num2}"></c:set>
<hr>
sum : ${sum}
<c:remove var="sum"/>
<hr>
sum : ${sum}
<hr>
<h3>c:if태그</h3>
<%-- 요청전달데이터 opt값이 add인 경우 if(request.getParameter("opt").equals("add")) --%>
<c:if test="${param.opt=='add'}">추가작업을 선택했습니다</c:if>
<hr>
<c:choose><%-- switch --%>
  <c:when test="${param.opt=='add'}"><%--case --%>
  추가작업을 선택했습니다
  </c:when>
  <c:when test="${param.opt =='update'}">
  수정작업을 선택했습니다.
  </c:when>
    <c:when test="${param.opt =='delete'}">
  삭제작업을 선택했습니다.
  </c:when>
  <c:otherwise><%--dafault  --%>
  그외의 작업을 선택했습니다.
  </c:otherwise>
</c:choose>
<hr>
<h3>c:forEach태그</h3>
<table border="1">
<!-- <tr><td>1</td><td>2</td><td>3</td></tr> -->
<tr>
<c:forEach begin="1" end="3" var="i" varStatus="status" step="2">
<%--짝수셀 (2,4)인 경우 td의 배경색을 다르게 지정하시오 --%>
  
  <td
    <c:if test="${status.count%2==0 }">style="backgound-color:green"</c:if>
  >${status.index} : ${status.count} : ${i}</td>
</c:forEach>
</tr>
</table>

<%
List<Product> list = new ArrayList<>();
list.add(new Product("C0001", "아메리카노", 1000));
list.add(new Product("C0002", "아메리카노", 1000));
list.add(new Product("C0003", "아메리카노", 1000));
request.setAttribute("list", list);
// RequestDispatcher rd = request.getRequestDispatcher("/jstlTest.jsp");
// rd.forward(request,response);

%>
<c:forEach items="${requestScope.list}" var="p">
 ${status.index} : ${p.prod_no} - ${p.prod_name} - ${p.prod_price}<br>
</c:forEach>
<hr>
<h3>fmt:formatNumber, fmt:formatDate태그</h3>
<fmt:formatNumber value="1234.5678" pattern="#,##0.00"/><br>
<%java.util.Date dt = new java.util.Date();
request.setAttribute("dt",dt);
//현재 JSP로 forward됨
%>
<fmt:formatDate value="${requestScope.dt}" pattern="yyyy-MM-dd a h:mm:ss"/>


</body>
</html>