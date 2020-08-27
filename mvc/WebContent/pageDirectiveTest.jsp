<%@page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page buffer="1000kb" %>
<%@ page errorPage="./error.jsp"  %>


<%for(int i=0; i<1000; i++){%>
<div><%=i%></div>
<%}%>

<%--

   FileInputStream fis;
   try{
   fis = new FileInputStream("c:\\a.txt");
   }catch(FileNotFoundException e){
	   String servletPath = "/error.jsp";
	   RequestDispatcher rd = request.getRequestDispatcher(servletPath);
	   rd.forward(request, response);
   }
--%>
<%
FileInputStream fis;
fis = new FileInputStream("c:\\a.txt");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>