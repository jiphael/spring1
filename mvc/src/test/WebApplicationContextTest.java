package test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
@ExtendWith(SpringExtension.class)
@ContextConfiguration({
   "file:WebContent\\WEB-INF\\root-context.xml",
   "file:WebContent\\WEB-INF\\servlet-context.xml"
})

@WebAppConfiguration()
class WebApplicationContextTest {
	@Autowired
	 private WebApplicationContext context;
	
	private  MockMvc mockMvc;
	
	@BeforeEach
	 public void ba(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	void productListTest() throws Exception {
		String uri="/productList";
		MockHttpServletRequestBuilder mockReqBuilder = 
				MockMvcRequestBuilders.get(uri);
		ResultActions resultAction1 = mockMvc.perform(mockReqBuilder);
		resultAction1.andDo(MockMvcResultHandlers.print());
		//ResultActions resultAction2 = resultAction1.andExpect(status().isOk());
		//ResultMatcher matcher = MockMvcResultMatchers.view().name("/productList");
		//resultAction2.andExpect(matcher);
	}
	
	@Test
	void loginTest() throws Exception {
		String uri="/login";
		MockHttpServletRequestBuilder mockReqBuilder = MockMvcRequestBuilders.get(uri);
		mockMvc.perform(mockReqBuilder);
	}
}
