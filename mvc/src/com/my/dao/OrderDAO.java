package com.my.dao;


import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.my.exception.AddException;
import com.my.exception.DuplicatedException;
import com.my.exception.FindException;
import com.my.sql.MyConnection;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

@Repository
//@Qualifier(value="orderDAO")
public class OrderDAO {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	public void insertInfo(OrderInfo info)  throws AddException{
			SqlSession session = sqlSessionFactory.openSession(ExecutorType.BATCH,false);
			try {
			//insertInfo(session,info);
			//insertLine(session,info.getLines());
			session.commit();
			}catch(Exception e){
				e.printStackTrace();
				throw new AddException(e.getMessage());
			}finally {
				session.close();
			}
	}

	
	private void insertLines(List<OrderLine> lines)  throws AddException{
		SqlSession session = sqlSessionFactory.openSession();
		try {
			session.insert("OrderMapper.insertLine", lines);
		}catch(Exception e){
			e.printStackTrace();
			throw new AddException(e.getMessage());
		}finally {
			session.close();
		}
		}

	public List<OrderInfo> selectById(String id) throws FindException{
		SqlSession session = sqlSessionFactory.openSession();
		try {
			OrderInfo info = session.selectOne("OrderMapper.selectById",id);	
		}catch(Exception e){
			e.printStackTrace();
			throw new FindException(e.getMessage());
		}finally {
			session.close();
		}	return null;
	}

	
}
