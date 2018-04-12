package com.zc.cris.crud.service.department;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zc.cris.crud.bean.Department;
import com.zc.cris.crud.bean.DepartmentExample;
import com.zc.cris.crud.dao.DepartmentMapper;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    
    /**
     * 
     * @MethodName: listAll
     * @Description: TODO (查询所有部门信息并返回给前台)
     * @return
     * @Return Type: List<Department>
     * @Author: zc-cris
     * @since
     * @throws
     */
    @Override
    public List<Department> listAll(){
        DepartmentExample departmentExample = new DepartmentExample();
        departmentExample.setOrderByClause("id ASC");
        return departmentMapper.selectByExample(departmentExample);
    }
    
    
}
