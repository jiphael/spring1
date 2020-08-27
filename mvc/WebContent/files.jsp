<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String dir = application.getRealPath("files"); 
   File f = new File(dir);
   File[] files = f.listFiles();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table>
<%-- <%for(File file: files){ --%>
<%-- %><tr><td><a href="/back25/download?name=<%=file.getName() %>"><%=file.getName() %></a></td></tr> --%>
<%-- <%} %> --%>
<c:forEach items="${requestScope.files}" var="file">
<tr><td><a href="/back25/download?name=${file.name}">${file.name}</a></td></tr>
</c:forEach>

</table>
</body>
</html>