package test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
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
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.my.control.ProductController;


@ExtendWith(SpringExtension.class)
//@ContextConfiguration(locations = "file:WebContent\\WEB-INF\\mvc-servlet.xml")
@ContextHierarchy({
    @ContextConfiguration(locations = "file:WebContent\\WEB-INF\\root-context.xml"),
    @ContextConfiguration(locations = "file:WebContent\\WEB-INF\\servlet-context.xml")
})
@WebAppConfiguration
class ControllerTest2 {
	@Autowired
	private ProductController productController;
	private MockMvc mockMvc;
	
	@BeforeEach
	public void setup(){
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setSuffix(".jsp");
		this.mockMvc = MockMvcBuilders.standaloneSetup(productController)
				.setViewResolvers(viewResolver)
				.build();        
//		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context).build();
	}
	
	@Test
	void productListTest() throws Exception {
		String uri="/productList";
		MockHttpServletRequestBuilder mockReqBuilder = MockMvcRequestBuilders.get(uri);
		//mockReqBuilder.contentType(MediaType.APPLICATION_JSON);
		//mockReqBuilder.param("id", "id1");
		ResultActions resultAction1 = mockMvc.perform(mockReqBuilder);
		
		resultAction1.andDo(MockMvcResultHandlers.print());
		ResultActions resultAction2 = resultAction1.andExpect(status().isOk());
//		ResultMatcher matcher = MockMvcResultMatchers.forwardedUrl("/productList.jsp");
		ResultMatcher matcher = MockMvcResultMatchers.view().name("/productList");
		resultAction2.andExpect(matcher);
	}
}