<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<c:set var="b"  value="${requestScope.detail}"/> 
<div class="boardDetail">
  <div class="board">
    <div class="board_no">게시글번호:<span>${b.board_no}</span></div>
    <div class="board_title">제목:<span>${b.board_title}</span></div>
    <div class="board_writer">작성자:<span>${b.board_writer}</span></div>
    <div class="board_dt">날짜:<span>${b.board_dt}</span></div>
    <div class="board_content">글내용:<pre>${b.board_content}</pre>
    <br>TextArea:<textarea>${b.board_content}</textarea>
    </div>
  </div>
  
  <button type="button" class="reply">답글쓰기</button>
  <button type="button" class="upadte">수정</button>
  <button type="button" class="delete">삭제</button>
</div>

<div class="boardReply">
  <form class="reply">
    <input type="hidden" name="parent_no" value="${b.board_no}">
    <label>글제목:<input type="text" name="board_title"></label><br>
    <label>작성자:<input type="text" name="board_writer"></label><br>
    <label>글내용:<textarea name="board_content"></textarea></label><br>
    <button>답글쓰기전송</button>
  </form>
</div>