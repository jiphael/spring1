package com.my.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.my.vo.Product;

@RestController
public class RestTestController {
	@GetMapping("/o.do")
	public String a() throws JsonProcessingException {
		Map<String, Object> map = new HashMap<>();
		map.put("msg", "테스트");
		map.put("cnt", 5);
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(map);
		// return "{\"msg\":\"hello\", \"cnt\":5}";
	}

	@GetMapping(value = "/p.do", produces = { "application/json" }) // 응답형식
	public String b() {
		return "{\"msg\":\"hello\", \"cnt\":5}";

	}

	@GetMapping(value = "/q.do", produces = { "application/json" })
	public Product c() {
		Product p = new Product("C0001", "아메리카노", 1000);
		return p;
	}

	@GetMapping(value = "/r.do", produces = { "application/json" })
	public List<Product> d() {
		List<Product> list = new ArrayList<>();
		Product p = new Product("C0001", "아메리카노", 1000);
		list.add(p);
		list.add(new Product("S0001", "팥빙수", 7000));
		return list;
	}

	// http://localhost/mbv/s.do?num=1 (x)
	// http://localhost/mbv/s.do
//	public String e(@RequestParam(value="num",
//								  ,required =false
//								  ,defaultValue="1")int no) {
//		
//	}

	// http://localhost/mvc/s.do/1 (o)

//	@GetMapping(value="/s.do/{num}",produces = {"text/plain;charset=UTF-8"} ) 
	@GetMapping(value = { "/s.do", "s.do/{num}" }, produces = { "text/plain;charset=UTF-8" })
	public String e(@PathVariable(value = "num", required = false) Optional<Integer> no) {//optional은 무겁다.
		//직접 널값체크를 권장.
		int num = 1;
		if(no.isPresent()) {
			num = no.get(); 
		}
		return "번호:" + num;

	}
//	public String e(@PathVariable(value="num", required = false) Integer no) {
//		int num = 1;
//		if(no!=null) {
//			num = no;
//		}
//		return "번호:" + num;
//		
//	}
	
	@GetMapping("/t.do")
	public ResponseEntity<Product> f(int num){
		if(num%2==0) {
		Product p = new Product("C0001", "아메리카노", 1000);
		ResponseEntity<Product> re = 
				(ResponseEntity<Product>) ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(p);
		return re;
		}else {
			Product p = new Product("C0001", "아메리카노", 1000);
			ResponseEntity<Product> re = 
					(ResponseEntity<Product>) ResponseEntity.status(HttpStatus.OK).body(p);
			return re;
		}
	}
}
