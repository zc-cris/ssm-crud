package com.zc.cris.crud.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.zc.cris.crud.bean.Employee;

// 使用 SpringTest 提供的请求测试功能，测试前台 crud 请求的准确性
// Spring4 测试的时候，需要 servlet3.0 的支持
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MVCTest {

	// 注入 SpringMVC 的ioc 容器，必须使用 @WebAppConfiguration 注解
	@Autowired
	WebApplicationContext context;
	
	// 虚拟 mvc 请求，获取到处理结果
	MockMvc mockMvc;
	
	/**
	 * 
	 * @MethodName: initMockMvc
	 * @Description: TODO (创建一个MockMvc 实例，模拟用户的一次 HTTP 请求以及后台 Controller 的处理结果)
	 * @Return Type: void
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	/**
	 * @throws Exception 
	 * 
	 * @MethodName: testPage
	 * @Description: TODO (测试用户第一次访问时的查询分页数据请求能否正确处理并返回相应的结果)
	 * @Return Type: void
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@Test
	public void testPage() throws Exception {
		// 模拟请求并拿到处理结果
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();
		
		// 请求成功后，请求域中会有 pageInfo 对象，我们可以取出 pageInfo 进行校验
		MockHttpServletRequest request = result.getRequest();
		@SuppressWarnings("unchecked")
		PageInfo<Employee> page = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + page.getPageNum());
		System.out.println("总页码：" + page.getPages());
		System.out.println("总记录数：" + page.getTotal());
		
		int[] nums = page.getNavigatepageNums();
		System.out.println("前台连续显示的页码是：");
		for (int i : nums) {
			System.out.print(i);
		}
		System.out.println();
		// 获取查询到的员工数据
		List<Employee> emps = page.getList();
		for (Employee employee : emps) {
			System.out.println(employee);
		}
	}

	
	
	
	
	
	
	
	
}
