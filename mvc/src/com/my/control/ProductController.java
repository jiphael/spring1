package com.my.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.my.dao.CustomerDAO2;
import com.my.exception.FindException;
import com.my.service.CustomerService2;
import com.my.service.ProductService;
import com.my.vo.Product;

@Controller
//@WebServlet("/productList")
public class ProductController {
	@Autowired
	private ProductService service;


	@RequestMapping("/productList")
	public ModelAndView list() {
		ModelAndView mnv = new ModelAndView();
		List<Product> list;
		try {
			list = service.findAll();
			mnv.addObject("list", list);
			mnv.setViewName("/productList");
		} catch (FindException e) {
			e.printStackTrace();
			mnv.setViewName("/fail");
			mnv.addObject("errorMsg", e.getMessage());
		}
		return mnv;
	}

//	@GetMapping("/productDetail")
//	@ResponseBody

//	public void prod_no(String prod_no){
//		Product p = new Product();
//		p.setProd_no(prod_no);
//		try {
//			p=service.findByNo(prod_no);
//		} catch (FindException e1) {
//			p.setProd_no("/fail");
//			e1.printStackTrace();
//		}
//		
//	}

	
		

	}
	

