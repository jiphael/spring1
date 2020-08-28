<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.my.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

Product p=(Product)request.getAttribute("p");

//String prod_no = p.getProd_no();
//String prod_name = p.getProd_name();
//int prod_price = p.getProd_price();
ObjectMapper mapper = new ObjectMapper();
String jsonString = mapper.writeValueAsString(p);
%>
<%=jsonString %>
