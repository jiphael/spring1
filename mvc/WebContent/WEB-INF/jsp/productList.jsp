<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.my.vo.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%List<Product> list = (List)request.getAttribute("list");
  ObjectMapper mapper = new ObjectMapper();
  String jsonStr = mapper.writeValueAsString(list);
%>
<%=jsonStr%>