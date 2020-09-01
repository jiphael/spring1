package test;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.my.dao.OrderDAO;
import com.my.exception.AddException;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

import lombok.extern.log4j.Log4j;
//@RunWith(SpringJUnit4ClassRunner.class)
@ExtendWith(SpringExtension.class)
@ContextConfiguration({           //테스트할 설정파일들
	   "file:WebContent\\WEB-INF\\root-context.xml"
	})
@Log4j
class OrderDAOTest {
	@Autowired
	OrderDAO orderDAO;
	@Test
	public void insert() {
		String loginedId = "id2";
		OrderInfo info = new OrderInfo();
		Customer c = new Customer();	
		c.setId(loginedId);
		info.setOrder_c(c);//로그인된 ID를 주문자ID로 설정
		
		List<OrderLine> lines = new ArrayList<>(); //주문상세들
		for(int i=1; i<3; i++) { 
			OrderLine line = new OrderLine();
			Product p = new Product();
			p.setProd_no("C000"+i);
			line.setOrder_p(p);
			if(i==1) {
				line.setOrder_quantity(i);
			}else {
				line.setOrder_quantity(i);
			//line.setOrder_quantity(i*1000000);
			}			
			lines.add(line);
		}
		info.setLines(lines);
		try {
			orderDAO.insert(info);
		} catch (AddException e) {
			e.printStackTrace();
		}
	}
}