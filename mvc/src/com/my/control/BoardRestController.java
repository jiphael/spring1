package com.my.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.exception.FindException;
import com.my.model.PageBean;
import com.my.service.BoardService;
import com.my.vo.Board;

@Controller
@RequestMapping("/board/*")
public class BoardRestController {
	@Autowired
	private BoardService service;
//	
//	@RequestMapping("/boardRest")
//	public void root() {
//		// / web-inf/jsp/obardRest.jsp로 포워드
//		
//	}
	@RequestMapping("/boardRest")
	public String root2() {
		return "/boardRest"; //  web-inf/jsp/obardRest.jsp로 포워드
	}
	
	@RequestMapping("/deatil/{board_no}")
	@ResponseBody
	public ResponseEntity<Board> detail(@PathVariable int board_no){
			 Board board =null;
		try {
			 board = service.findByNo(board_no);
			return (ResponseEntity<Board>)ResponseEntity.status(HttpStatus.OK).body(board);
		}catch(FindException e) {
			e.printStackTrace();
			return (ResponseEntity<Board>)ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(board);
		}
		
	}
	@RequestMapping("/list/{currentPage}")
	@ResponseBody
	public ResponseEntity<PageBean> list(@PathVariable(value="currentPage",required=false) Integer cp){
		int currentPage = 1;
		
		if(cp !=null) {
			currentPage = cp;
		}
		PageBean pb =null;
		try {
		pb = service.findAll(currentPage);
		return (ResponseEntity<PageBean>)ResponseEntity.status(HttpStatus.OK).body(pb);
	   }catch (FindException e) {
					e.printStackTrace();
					return (ResponseEntity<PageBean>)ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(pb);
				}
		
	}

//   	
//   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//	   String pathInfo = request.getPathInfo();
//	   String servletPath = "";
//	   if ("/write".equals(pathInfo)) {//글쓰기
//		   String board_title =request.getParameter("board_title");
//	      String board_writer = request.getParameter("board_writer");
//	      String board_content = request.getParameter("board_content");
//	      System.out.println(board_content);
//	      Board board = new Board(board_title, board_writer, board_content);
//	      try {
//	         service.write(board);
//	         servletPath = "/success.jsp";
//	         RequestDispatcher rd = request.getRequestDispatcher(servletPath);
//			 rd.forward(request, response);
//	      } catch (AddException e) {
//	         e.printStackTrace();
//	      }
//	   }else if("/replay".equals(pathInfo)) {//답글쓰기
//		   
//	   }else if("/detail".equals(pathInfo)) {//디테일보기
//		  
//		   
//	   }
//	   
//	   else if("/list".equals(pathInfo)) {//게시물 목록보기
//		   List<Board> list ;
//		   try {
//			   String strPage = request.getParameter("currentPage");
//			   int currentPage = 1;
//			   //if(strPage != null && !strPage.equals("")){
//			   if(!"".equals(strPage)) { //if(!strPage.equals(""){
//			   currentPage = Integer.parseInt(strPage);
//			   }
//			   com.my.model.PageBean pb = service.findAll(currentPage);
//			   String url = request.getServletPath() + request.getPathInfo();
//			   pb.setUrl(url);
//			   System.out.println(pb);
////			   list = service.findAll(currentPage);
//			   //request.setAttribute("list", list);
//			   request.setAttribute("pb", pb);
//			   servletPath = "/boardList.jsp";
//			   RequestDispatcher rd = request.getRequestDispatcher(servletPath);
//			   rd.forward(request, response);
////			   for(Board b:list) {
////				   System.out.println(b); //b toString 자동호출
////			   }
//		   }catch (FindException e) {
//				   e.printStackTrace();
//			   }
//		   }   
//	   }

//글쓰기
//	
	// 답변보기
//	  int Parent_no = 10;
//	  String board_title = "테스트1";
//      String board_writer = "작성자1";
//      String board_content = "내용1";
//      Board board = new Board(Parent_no,board_title, board_writer, board_content);
//      try {
//         service.reply(board);
//      } catch (AddException e) {
//         e.printStackTrace();
//      }
	//

}
