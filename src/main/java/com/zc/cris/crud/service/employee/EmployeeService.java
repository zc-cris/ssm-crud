package com.zc.cris.crud.service.employee;

import java.util.List;

import com.zc.cris.crud.bean.Employee;

public interface EmployeeService {
	
	List<Employee> listAll();

    void saveEmp(Employee employee);

}
