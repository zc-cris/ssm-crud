package com.zc.cris.crud.dao;

import com.zc.cris.crud.bean.Employee;
import com.zc.cris.crud.bean.EmployeeExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);
    
    // 查询员工及其对应的具体部门信息
    List<Employee> selectByExampleWithDepartment(EmployeeExample example);

    Employee selectByPrimaryKey(Integer id);
    
    // 查询员工及其对应的具体部门信息
    Employee selectByPrimaryKeyWithDepartment(Integer id);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}