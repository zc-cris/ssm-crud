package com.zc.cris.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.bean.vo.Msg;
import com.zc.cris.crud.service.employee.EmployeeService;

/**
 * 
 * @Description：TODO (员工控制器)
 * @Project Name：ssm-crud
 * @Package Name: com.zc.cris.crud.controller
 * @ClassName：EmployeeController.java
 * @Author：zc-cris
 * @version: v1.0
 * @Copyright: zc-cris
 * @mail: 17623887386@163.com
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	/**
	 * 
	 * @MethodName: getEmp
	 * @Description: TODO (根据id 查询用户)
	 * @param id
	 * @return
	 * @Return Type: Msg
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value = "id") Integer id ) {
	    
	    Employee employee = employeeService.getEmpById(id);
	    
	    return Msg.success().add("emp", employee);
	}
	
	/**
	 * 
	 * @MethodName: checkEmpName
	 * @Description: TODO (验证前端传来用户名是否可用)
	 * @param empName
	 * @return
	 * @Return Type: Msg
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@ResponseBody
	@RequestMapping("/checkEmpName")
	public Msg checkEmpName(@RequestParam(name="empName") String empName) {
	    boolean flag = employeeService.countByName(empName);
	    if(flag) {
	        return Msg.success();
	    }else {
	        return Msg.fail();
	    }
	}
	
	/**
	 * 
	 * @MethodName: saveEmp
	 * @Description: TODO (新增一条员工数据)
	 * @param employee
	 * @return
	 * @Return Type: Msg
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
	    
        System.out.println(employee);
        if (result.hasErrors()) {
            
            // 业务优化：即使用户绕过了前台验证，也无法通过后台的 JSR303 校验，
            // 并且后台不需要将校验信息传给前端，只需要告诉前端哪个字段不合法即可
            
            //Map<String, Object> map = new HashMap<>();
            List<String> list = new ArrayList<>();
            
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println(fieldError.getField());
                System.out.println(fieldError.getDefaultMessage());
                list.add(fieldError.getField());
            }
            return Msg.fail().add("fieldErrors", list);

        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
	}
	
	/**
	 * 
	 * @MethodName: getAllByJson
	 * @Description: TODO (为了满足移动设备端，我们需要对后台返回数据做 Json 优化，增强用户体验)
	 * @param pageNum
	 * @return
	 * @Return Type: Msg
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@RequestMapping("/emps_ajax")  
	@ResponseBody
	public Msg getAllByJson(@RequestParam(name="pageNum", defaultValue="1") Integer pageNum) {
	    // 使用 线程休眠的方式测试 blockUI
	    try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            
            e.printStackTrace();
        }
	    
	    // 1. 引入分页查询助手(查询第几页，每页显示5条记录)
        PageHelper.startPage(pageNum, 5);
        // 2. startPage 方法后面再使用我们的查询方法就会生成 limit 关键字的 sql 语句
        List<Employee> emps = employeeService.listAll();
        // 3. 使用 pageInfo 包装查询后的数据，然后将 pageInfo 交给前台处理即可
        // pageInfo 封装了详细的分页信息，包括我们的分页数据，前台连续显示页码参数(需要设置)等等...
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        
	    return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 
	 * @MethodName: getAll
	 * @Description: TODO (访问首页时，分页查询数据并跳转)
	 * @param pageNum
	 * @return
	 * @Return Type: String
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
	@RequestMapping("/emps")
	public String getAll(@RequestParam(name="pageNum", defaultValue="1") Integer pageNum,
			Model model) {
		
		// 1. 引入分页查询助手(查询第几页，每页显示5条记录)
		PageHelper.startPage(pageNum, 5);
		// 2. startPage 方法后面再使用我们的查询方法就会生成 limit 关键字的 sql 语句
		List<Employee> emps = employeeService.listAll();
		// 3. 使用 pageInfo 包装查询后的数据，然后将 pageInfo 交给前台处理即可
		// pageInfo 封装了详细的分页信息，包括我们的分页数据，前台连续显示页码参数(需要设置)等等...
		PageInfo<Employee> page = new PageInfo<>(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
	
}
