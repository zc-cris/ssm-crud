package com.zc.cris.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.bean.vo.Msg;
import com.zc.cris.crud.service.employee.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
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
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getAllByJson(@RequestParam(name="pageNum", defaultValue="1") Integer pageNum) {
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
	 * @Description: TODO (访问首页时，分页查询数据)
	 * @param pageNum
	 * @return
	 * @Return Type: String
	 * @Author: zc-cris
	 * @since
	 * @throws
	 */
//	@RequestMapping("/emps")
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
