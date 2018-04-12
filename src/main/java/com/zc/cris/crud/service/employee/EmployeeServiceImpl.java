package com.zc.cris.crud.service.employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.bean.EmployeeExample;
import com.zc.cris.crud.dao.EmployeeMapper;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 
	 * @MethodName: listAll
	 * @Description: TODO (分页查询所有员工)
	 * @see com.zc.cris.crud.service.employee.EmployeeService#listAll()
	 * @Author：zc-cris
	 */
	@Override
	public List<Employee> listAll() {
	    EmployeeExample employeeExample = new EmployeeExample();
	    employeeExample.setOrderByClause("id ASC");
		return employeeMapper.selectByExampleWithDepartment(employeeExample);
	}

	/**
	 * 
	 * @MethodName: saveEmp
	 * @Description: TODO (新增一个员工数据)
	 * @see com.zc.cris.crud.service.employee.EmployeeService#saveEmp(com.zc.cris.crud.bean.Employee)
	 * @Author：zc-cris
	 */
    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

}
