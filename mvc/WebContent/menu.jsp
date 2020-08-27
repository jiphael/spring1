<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<ul>
<c:choose>
<%-- <c:when test="${empty cookie.loginInfo}"> --%>
 <c:when test="${ empty sessionScope.loginInfo}">
 <li><a href="#" class="login">로그인</a></li>
      <li><a href="#" class="signup">가입</a></li>
 </c:when>
<c:otherwise>
    <li><a href="#" class="logout">로그아웃</a></li>
</c:otherwise>
</c:choose>
      <li><a href="#" class="productList">상품목록</a></li>
       <li><a href="#" class="viewCart">장바구니보기</a></li>
      <li><a href="#" class="viewOrder">주문목록보기</a></li>
</ul>