<%@page import="com.my.model.PageBean"%>
<%@page import="com.my.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "pb" value = "${requestScope.pb}"/>
<c:set var = "currentPage" value = "${pb.currentPage}"/>
<c:set var = "list" value = "${pb.list}"/>
<c:set var = "totalPage" value = "${pb.totalPage}"/>
<c:set var = "startPage" value = "${pb.startPage}"/>
<c:set var = "endPage" value = "${pb.endPage}"/>
<c:set var = "url" value = "${pb.url}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%--
PageBean pb = (PageBean)request.getAttribute("pb");
int currentPage = pb.getCurrentPage();
List<Board>list = pb.getList();
int totalPage = pb.getTotalPage();
int startPage = pb.getStartPage();
int endPage = pb.getEndPage();
String url = pb.getUrl();
//List<Board>list = (List)request.getAttribute("list");
//스크립틀릿으로 선언한건 밖에서 변수사용 안되는 듯 표현식은 익스프레션 <%= 요렇게 쓰면 상용가능하지만.. ${요렇게는 안됨
//여튼 스크립틀릿으로안하고 JSTL로 사용
--%>
<style>
   div.boardList {display:table;}
   div.boardList > div.board{display:table-row;}
   div.boardList > div.board > *{display: table-cell;
                          border: 1px dotted;
                          border-collapse: collapse;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
   var $boardPage = $("div.boardPage");
//    var pageSpan = $("div.pageGroup>span");
      //jQuery로 dom객체를 찾을때배열을 반호나하면
      //해당 배열은 무조건 JavaScript객체이다
      $boardPage.on("click", "div.pageList>span", function(e){
    	var $etClass = $(e.target).attr('class');
    	var page = "1";
    	if($etClass == 'prev'){
    		page = ${startPage-1};
    	}else if($etClass =='next'){
    		page = ${endPage +1};
    	}else{
    		page = $(e.target).html();
    	}
      
//    $(pageSpan).click(function(e){
//       var page = $(e.target).html();
       alert(page);
      $.ajax({
         url:"${contextPath}${url}"
         ,data:'currentPage='+page
         ,success:function(data){
            $boardPage.html(data.trim());
         }
      });
      $boardPage.empty();
      return false;
   });
});
</script>
<div class="boardPage">
<div class="boardInfo">현재페이지:${currentPage}/총페이지수:${totalPage}</div>
<div class="boardList">
   <div class="board">
      <div class="board_no">게시글번호</div>
      <div class="board_title">제목</div>
      <div class="board_writer">작성자</div>
      <div class="board_dt">날짜</div>
   </div>
<%--for(Board b: list){--%>
<c:forEach items="${list}" var="b">
   <div class="board">
      <div class="board_no">${b.board_no}</div>
      <div class="board_title"><c:forEach var="i" begin="0" end="${b.level}">&nbsp;&nbsp;</c:forEach>${b.board_title}</div>
      <div class="board_writer">${b.board_writer}</div>
      <div class="board_dt">${b.board_dt}</div>
   </div>
<%--}--%>
</c:forEach>
</div>
<div class="pageList">
<c:set var="data" value=""/>
<c:if test="${startPage >1 }">
[<span class="prev">prv</span>]
</c:if>
<c:forEach begin="${startPage}" end="${endPage}" var="i">
[
<span>${i}</span>
]
&nbsp;&nbsp;
</c:forEach>
<c:if test="${totalPage > endPage}">
[<span class="next">next</span>]
</c:if>
</div>
</div>