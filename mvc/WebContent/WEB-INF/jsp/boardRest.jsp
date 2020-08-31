<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	$.ajax({
		url:"/mvc/board/list/1"
		,method:"get"
		,success:function(pbObj){
			var $boardPage = $("div.boardPage");
			var currentPage = pbObj.currentPage;
			var totalPage = pbObj.totalPage;
			var boardPageData = "";
			boardPageData += "<h3> 게시물 목록</h3>";
			boardPageData += currentPage +"/"+totalPage+"<br>"
			var arr = pbObj.list;
			arr.forEach(function(board,index){
				boardPageData += "<div>"+board.board_no+"</div>";
			});
			$boardPage.html(boardPageData);
		}
		,error:function(xhr){
			alert("실패:"+xhr.status);
		}
	});
});
</script>
</head>
<body >
<div class="boardPage">
</div>

</body>
</html>