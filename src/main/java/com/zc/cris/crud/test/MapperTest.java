package com.zc.cris.crud.test;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
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

import com.zc.cris.crud.bean.Department;
import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.dao.DepartmentMapper;
import com.zc.cris.crud.dao.EmployeeMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest{

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	// 以后不需要使用这种方式了，Spring 项目测试使用 Spring 的单元测试即可，自动注入我们需要的组件
	// 1. 导入 SpringTest 单元测试模块
	// 2. 使用 @ContextConfiguration 指定配置文件位置
	// 3. 使用 @RunWith(SpringJUnit4ClassRunner.class) 指定使用 SpringTest 提供的 junit 进行测试
	// 4. 直接 @Autowired 需要使用的组件
//	private ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//	private EmployeeMapper empMapper = context.getBean(EmployeeMapper.class);
	
	
	/**
	 * 
	 * @MethodName: MBGtest
	 * @Description: TODO (调用 MBG 工程（固定代码）)
	 * @throws IOException
	 * @throws XMLParserException
	 * @throws SQLException
	 * @throws InterruptedException
	 * @throws InvalidConfigurationException
	 * @Return Type: void
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@Test
	public void MBGtest() throws IOException, XMLParserException, SQLException, InterruptedException, InvalidConfigurationException {
		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		File configFile = new File("mbg.xml");
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
	}
	
	
	/**
	 * 
	 * @MethodName: testCRUD
	 * @Description: TODO (测试 DepartmentMapper 和 EmployeeMapper 接口的我们所需要的功能是否正常)
	 * @Return Type: void
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@Test
	public void testCRUD() {
		
//		System.out.println(departmentMapper);
//		System.out.println(employeeMapper);
		
		
		// 测试部门的 insert     
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
//		departmentMapper.insertSelective(new Department(null, "运营部"));
		
		// 测试部门的 delete，update，select  
//		departmentMapper.deleteByPrimaryKey(1);
//		departmentMapper.updateByPrimaryKeySelective(new Department(2, "前台部"));
//		Department dept = departmentMapper.selectByPrimaryKey(3);
//		System.out.println(dept);
		
		
		// 测试新增员工  
//		employeeMapper.insertSelective(new Employee(null, "cris", 15000.34, 25, "M", "1234@qq.com", new Date(), 2));
		// 测试有选择性的更新员工数据
		//employeeMapper.updateByPrimaryKeySelective(new Employee(1, "埃尔维", null, null, "F", null, null, 3));
		// 测试查询员工(不带详细部门信息)
//		Employee emp = employeeMapper.selectByPrimaryKey(1);
//		System.out.println(emp);
		// 测试删除员工
//		employeeMapper.deleteByPrimaryKey(1);
		
		// 测试带部门具体信息的员工（测试我们自定义的 select 是否生效）
//		Employee emp = employeeMapper.selectByPrimaryKeyWithDepartment(51);
//		System.out.println(emp);
		// Employee [id=51, name=adcris, salary=20000.0, age=20, gender=F, 
		// email=adcris@163.com, hiredate=Tue Apr 10 00:00:00 CST 2018, deptId=3, 
		// department=Department [id=3, name=运营部]]
		
		
		// 测试批量插入多个员工：需要在 spring 的核心文件配置可以执行批量操作的 sqlSession 实例
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0; i < 100; i++) {
			String uuid = UUID.randomUUID().toString().subSequence(0, 2) + "cris";
			mapper.insertSelective(new Employee(null, uuid, 10000.0 + i, 20, "M", uuid + "@163.com", new Date(), 2));
		}
		
		// 测试批量更新数据
//		for(int i = 2; i < 102; i++) {
//			mapper.updateByPrimaryKeySelective(new Employee(i, null, 20000.0, 20, "F", null, null, 3));
//		}
		
		// 测试批量删除数据
//		for(int i = 2; i< 51; i++) {
//			mapper.deleteByPrimaryKey(i);
//		}
		
		// 测试批量查询
//		for(int i = 51; i < 60; i++) {
//			Employee emp = mapper.selectByPrimaryKey(i);
//			System.out.println(emp);
//		}
		
		
		
		
		
		
	}
	

}
