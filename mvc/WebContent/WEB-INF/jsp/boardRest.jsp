<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div.boardList {display:table; border: 1px solid;}
div.boardList > div.board {display:table-row;}
div.boardList > div.board > *{display: table-cell; 
                              border: 1px dotted; 
                              border-collapse: collapse;}
div.boardList > div.board:hover{background-color: lime}                              
div.boardDetail>div.board>div.board_content>pre{margin: 1px; border: 1px solid;}
div.boardReply{ display: none; }
</style> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
  $.ajax({
	  url:"/mvc/board/list/1"
	  ,method:"get"
	  ,success:function(pbObj){
// 		var $boardPage = $("div.boardPage");
// 		var currentPage = pbObj.currentPage;
// 		var totalPage = pbObj.totalPage;
// 		var boardPageData = "";
// 		boardPageData += "<h3>게시물 목록</h3>";
// 		boardPageData += currentPage + "/" + totalPage + "<br>";
// 		var arr = pbObj.list;
// 		arr.forEach(function(board, index){
// 			boardPageData += "<div>" + board.board_no+"</div>";
// 		});
// 		$boardPage.html(boardPageData);

		var currentPage = pbObj.currentPage;
		var totalPage = pbObj.totalPage;
		$("div.boardPage>div.boardInfo>span.currentPage").html(currentPage);
		$("div.boardPage>div.boardInfo>span.totalPage").html(totalPage);
	  	var $divBoardList = $("div.boardPage>div.boardList");
	  	var $board = $divBoardList.find("div.board");
	  	var arr = pbObj.list;
		arr.forEach(function(board, index){
// 			boardPageData += "<div>" + board.board_no+"</div>";
	  		var $boardClone = $board.clone();
			$boardClone.find("div.board_no").html(board.board_no);
			$boardClone.find("div.board_title").html(board.board_title);
			$boardClone.appendTo($divBoardList);
		});
	  }
  	  ,error:function(xhr){
  		alert("실패:" + xhr.status);  
  	  }
  });
});
</script>
</head>
<body>
<div class="boardPage">
<h3>게시물 목록</h3>
<div class="boardInfo">현재페이지:<span class="currentPage"></span>/
                                  총페이지수: <span class="totalPage"></span>                                
   <button type="button">글쓰기</button>   
</div>
<div class="boardList">
  <div class="board">
    <div class="board_no">게시글번호</div>
    <div class="board_title">제목</div>
    <div class="board_writer">작성자</div>
    <div class="board_dt">날짜</div>
  </div>
</div>
</div>
</body>
</html>