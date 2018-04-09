package com.zc.cris.crud.test;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zc.cris.crud.dao.DepartmentMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:appplicationContext.xml"})
public class SMMTest{

	@Autowired
	DepartmentMapper departmentMapper;
	
	// 以后不需要使用这种方式了，Spring 项目测试使用 Spring 的单元测试即可，自动注入我们需要的组件
	// 1. 导入 SpringTest 单元测试模块
	// 2. 使用 @ContextConfiguration 指定配置文件位置
	// 3. 使用 @RunWith(SpringJUnit4ClassRunner.class) 指定使用 SpringTest 提供的 junit 进行测试
	// 4. 直接 @Autowired 需要使用的组件
//	private ApplicationContext context = new ClassPathXmlApplicationContext("spring-context.xml");
//	private EmployeeMapper empMapper = context.getBean(EmployeeMapper.class);
	
	
	// 调用 MBG 工程（固定代码）
	@Test
	public void test() throws IOException, XMLParserException, SQLException, InterruptedException, InvalidConfigurationException {
		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		File configFile = new File("mbg.xml");
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
	}
	
	
	
	@Test
	public void testDepartmentCRUD() {
		System.out.println(departmentMapper);
		
	}
	
	
	

}
