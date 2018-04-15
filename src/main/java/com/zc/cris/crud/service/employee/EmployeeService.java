package com.zc.cris.crud.service.employee;

import java.util.List;

import com.zc.cris.crud.bean.Employee;

public interface EmployeeService {
	
	List<Employee> listAll();

    void saveEmp(Employee employee);

    boolean countByName(String empName);

    Employee getEmpById(Integer id);

    void updateEmp(Employee employee);

    void removeEmployee(Integer id);

    void removeEmployeeBatch(List<Integer> idList);

}
