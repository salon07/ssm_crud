package com.ssm.crud.test;

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
import com.ssm.crud.bean.Employee;

/**
 * 使用spring测试模块提供的请求功能
 * @author salon
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MVCTest {
	//springmvc的ioc
	@Autowired
	 WebApplicationContext context;
	//虚拟mvc
	MockMvc mockMvc;
	
	//单元测试如果有初始化操作，需加上@Before注解
	@Before
	public void initMockMvc() {
		 mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "1")).andReturn();
		//请求成功后，请求域中有pageInfo，可以去除并验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");
		System.out.println(attribute);
		int[] nums = attribute.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(i);
		}
		//获取员工数据
		List<Employee> list = attribute.getList();
		for (Object object : list) {
			System.out.println(object);
		}
		
	}
}
