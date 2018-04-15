package com.zc.cris.crud.service.employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.bean.EmployeeExample;
import com.zc.cris.crud.bean.EmployeeExample.Criteria;
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

    /**
     * 
     * @MethodName: countByName
     * @Description: TODO (根据前端传来的用户名验证数据库是否已经有相同用户名的数据了)
     * @see com.zc.cris.crud.service.employee.EmployeeService#countByName(java.lang.String)
     * @Author：zc-cris
     * @return true:表示用户名可用；false：表示用户名不可用
     */
    @Override
    public boolean countByName(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andNameEqualTo(empName);
        
        long count = employeeMapper.countByExample(example);
        
        return count == 0;
    }

    /**
     * 
     * @MethodName: getEmpById
     * @Description: TODO (根据前端传来的id查询对应的员工)
     * @see com.zc.cris.crud.service.employee.EmployeeService#getEmpById(java.lang.Integer)
     * @Author：zc-cris
     */
    @Override
    public Employee getEmpById(Integer id) {
        
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 
     * @MethodName: updateEmp
     * @Description: TODO (更新一个员工数据)
     * @see com.zc.cris.crud.service.employee.EmployeeService#updateEmp(com.zc.cris.crud.bean.Employee)
     * @Author：zc-cris
     */
    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 
     * @MethodName: removeEmployee
     * @Description: TODO (根据id删除员工)
     * @see com.zc.cris.crud.service.employee.EmployeeService#removeEmployee(java.lang.Integer)
     * @Author：zc-cris
     */
    @Override
    public void removeEmployee(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 
     * @MethodName: removeEmployeeBatch
     * @Description: TODO (根据id批量删除用户)
     * @see com.zc.cris.crud.service.employee.EmployeeService#removeEmployeeBatch(java.util.List)
     * @Author：zc-cris
     */
    @Override
    public void removeEmployeeBatch(List<Integer> idList) {
        // 使用 example 组装sql 条件
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andIdIn(idList);
        
        employeeMapper.deleteByExample(example);
    }

}
