package com.my.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.exception.AddException;
import com.my.exception.FindException;
import com.my.sql.MyConnection;
import com.my.vo.Board;
import com.my.vo.Product;

@Repository()
public class BoardDAO {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	public static final int CNT_PER_PAGE=3; //페이지별 목록수
	
	public void insert(Board board) throws AddException{
		SqlSession session = sqlSessionFactory.openSession();
		try {session.insert("BoardMapper.insert",board);
		session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			throw new AddException(e.getMessage());
		}finally {
			session.close();
		}
	}

	public List<Board> selectAll(int startRow, int endRow) throws FindException{
		SqlSession session = null;
		
		try {session = sqlSessionFactory.openSession();
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			List<Board> list = session.selectList("BoardMapper.selectAll", map);
			if(list.size() == 0) {
				throw new FindException("게시글이 없습니다");
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new FindException(e.getMessage());
		} finally {
			session.close();
		}
	}

//	public int selectCount() throws FindException{
//		SqlSession session = sqlSessionFactory.openSession();
//		try {session = sqlSessionFactory.openSession();
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new FindException(e.getMessage());
//		} finally {
//			session.close();
//		}return 1 ;
//	}
//
//	public Board selectByNo(int board_no) throws FindException{
//		SqlSession session = null;
//		try {session = sqlSessionFactory.openSession();
//			throw new FindException(board_no+"에 해당하는 게시글이 없습니다");
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new FindException(e.getMessage());
//		} finally {
//			session.close();
//		}
//	}
}
