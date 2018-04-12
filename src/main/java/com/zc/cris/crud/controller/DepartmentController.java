package com.zc.cris.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zc.cris.crud.bean.Department;
import com.zc.cris.crud.bean.vo.Msg;
import com.zc.cris.crud.service.department.DepartmentService;

/**
 * 
 * @Description：TODO (部门控制器)
 * @Project Name：ssm-crud
 * @Package Name: com.zc.cris.crud.controller
 * @ClassName：DepartmentController.java
 * @Author：zc-cris
 * @version: v1.0
 * @Copyright: zc-cris
 * @mail: 17623887386@163.com
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    
    /**
     * 
     * @MethodName: listAll
     * @Description: TODO (查询所有部门信息并封装给 VO 返回前台)
     * @return
     * @Return Type: Msg
     * @Author: zc-cris
     * @since
     * @throws
     */
    @RequestMapping("depts")
    @ResponseBody
    public Msg listAll() {
        List<Department> depts = departmentService.listAll();
        return Msg.success().add("depts", depts);
    }
    
}
