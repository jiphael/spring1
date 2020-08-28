<%@page import="com.my.vo.Product"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<% 

Map<Product,Integer> cartDetail = (Map)request.getAttribute("cartDetail");

boolean isFirst = true;

// 객체형태로 응답해주기 위해서{}중괄호 형식 열어주고 닫아줘야 한다.
// "status":"success" 는 index.html 에서 status == success 로 했기 때문에 선언해준디
// 즉 석세스가 장바구니에 물품이 있을때 뷰카트 제이에스피로 오게 한다 
// 그리거 [] 대괄호가 제이에스피에서 배열시작 이다!
// 그리고 마지막 콤마가 안찍히게 할려면 블린타입으로 true 값을 주고
// "" 프로퍼티 값이기 때문에 !
// isFirst 값이 처음일때 펄스 다 왜냐 처음에는 콤마가 필요 없으니까 그런데 else로 가면서 두번째가 된다 그러므로
// 콤마가 찍히면서 처음으로 돌아가면 찍히지 않을거다.

%>

{
"status":"success"
,"cart":[ 
<%for(Product p :cartDetail.keySet()){
   
   if(isFirst){
      
      isFirst = false;
      
   } else{
      
%>,   

<%   }
%>
{"prod_no" : "<%= p.getProd_no()%>"
, "prod_name" : "<%= p.getProd_name()%>"
, "prod_price" : "<fmt:formatNumber value="<%=p.getProd_price()%>" pattern="#,##0"  />"
, "quantity" : <%=cartDetail.get(p)%>
}

<%
} // end for%>
]
}
