<%@page import="com.my.vo.OrderInfo"%>
<%@page import="com.my.vo.OrderLine"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<table>
   <%  List<OrderInfo> list = (List)request.getAttribute("list");
   	System.out.println(list.size());
   	for(OrderInfo info: list){
   		List<OrderLine> lines = info.getLines();
   		int linesSize = lines.size();
   	}
   
   %>
<!--    <tr> -->
<%--    <td rowspan="<%=lineSize%>"><%=getOrder_no() %> --%>
<%--    <td rowspan="<%=linesSize %>"><%=info.getOrder_dt() %></td> --%>
<%-- <%--    <% --%> --%>
<!-- //    for(int i=0; i<linesSize; i++){ -->
<!-- // 	   OrderLIne line = lines.get(i); -->
<!-- // 	   if(i>0){ -->
  
  
<%-- <%-- 	   } %> --%> --%>
  
   </td>
   </tr>
    </table>