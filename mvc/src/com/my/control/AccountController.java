package com.my.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.dao.AccountDAO;

@Controller
public class AccountController {
	@Autowired
	private AccountDAO dao;
	
	@RequestMapping("/account/add")
	@ResponseBody
	public String add(String no, int balance) {
		//service.add() - >dao.insert()
//		SqlSession session = sqlSessionFactory.openSession();
//		Map<String,Object> parameter = new HashMap<>();
//		parameter.put("account_no",no); //계좌번호
//		parameter.put("account_balance",balance);
//		session.insert("AccountMapper.insert",parameter);
//		
//		throw new RuntimeException("rollbacked");
		
		//return "int";`
	try {
		dao.insert(no,balance);
	}catch (Exception e) {
		e.printStackTrace();
	}
	return "int";

}
	}
