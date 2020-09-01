package com.my.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.my.exception.AddException;
import com.my.exception.FindException;
import com.my.sql.MyConnection;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

import lombok.extern.log4j.Log4j;
@Repository("orderDAO")

@Log4j
public class OrderDAO {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Transactional(rollbackFor = AddException.class)
	public void insert(OrderInfo info) throws AddException{
		try {
			insertInfo(info); 
			insertLines(info.getLines());
		}catch(Exception e) {
			e.printStackTrace();
			throw new AddException(e.getMessage());
		}finally {
			
		}
	}
	
	public void insertInfo(OrderInfo info)  throws AddException{		
		SqlSession session = sqlSessionFactory.openSession();
		try {
			session.insert("OrderMapper.insertInfo", info.getOrder_c().getId());
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		}
	}
	private void insertLines(List<OrderLine> lines)  throws AddException{
		try {
		SqlSession session = 
				sqlSessionFactory.openSession(ExecutorType.BATCH);
		for(OrderLine line: lines) {
			session.insert("OrderMapper.insertLine", line);
		}
		session.flushStatements(); //con.executeBatch()와 같음
		}catch(Exception e) {
			throw new AddException(e.getMessage());
		}
	}
	public List<OrderInfo> selectById(String id) throws FindException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = MyConnection.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new FindException(e.getMessage());
		}
		String selectByIdSQL = 
				"SELECT info.order_no,  order_id, order_dt\r\n" + 
						"      ,order_prod_no, prod_name, prod_price\r\n" + 
						"      , order_quantity     \r\n" + 
						"FROM order_info info \r\n" + 
						"JOIN order_line line ON (info.order_no = line.order_no)\r\n" + 
						"JOIN product p ON (line.order_prod_no = p.prod_no)\r\n" + 
						"WHERE order_id = ? "+
						"ORDER BY info.order_no DESC";

		try {
			pstmt = con.prepareStatement(selectByIdSQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			List<OrderInfo> infos = new ArrayList<>(); 			
			List<OrderLine> lines = null; //�ֹ��󼼵�
			int oldOrder_no = 0;//�����ֹ���ȣ
			while(rs.next()) {
				int order_no = rs.getInt("order_no"); //���� �ֹ���ȣ ���				
				if(oldOrder_no != order_no) {
					OrderInfo info=null; //�ֹ��⺻
					info = new OrderInfo();   //�ֹ��⺻��ü ���� ����
					info.setOrder_no(order_no); 
					info.setOrder_dt(rs.getDate("order_dt"));
					lines = new ArrayList<>(); //�ֹ��󼼵�lines ���� ����
					info.setLines(lines); 
					infos.add(info);	
					oldOrder_no = order_no;
				}
				Product order_p = new Product();
				order_p.setProd_no(rs.getString("order_prod_no"));
				order_p.setProd_name(rs.getString("prod_name"));
				order_p.setProd_price(rs.getInt("prod_price"));
				//order_p.setAmount(rs.getInt("�ݾ�"));//???

				OrderLine line = new OrderLine(
						order_no
						,order_p
						,rs.getInt("order_quantity")
						);
				//line.setAmount(rs.getInt("�ݾ�"));
				lines.add(line);
			}
			if(infos.size() == 0) {
				throw new FindException("�ֹ��� �����ϴ�");
			}
			return infos;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new FindException(e.getMessage());
		}finally {
			MyConnection.close(rs, pstmt, con);
		}

	}



}