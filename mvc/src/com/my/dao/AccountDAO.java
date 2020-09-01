package com.my.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("AccountDAO")
public class AccountDAO {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	@Transactional(rollbackFor = Exception.class)
	public void insert(String no, int balance) throws Exception {
		SqlSession session = sqlSessionFactory.openSession();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("account_no",no); //계좌번호
		map.put("account_balance",balance);
		session.insert("AccountMapper.insert",map);
		throw new Exception("롤백 안됨");
	}
	
//	@Transactional()
//	public void insert(String no, int balance) {
//		SqlSession session = sqlSessionFactory.openSession();
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("account_no",no); //계좌번호
//		map.put("account_balance",balance);
//		session.insert("AccountMapper.insert",map);
//		throw new RuntimeException("롤백됨");
//	}

}
