package com.zc.cris.crud.service.employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.dao.EmployeeMapper;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Override
	public List<Employee> listAll() {
		return employeeMapper.selectByExampleWithDepartment(null);
	}

}
