package com.zc.cris.crud.bean;

import java.util.Date;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;


public class Employee {
	private Integer id;

	// 使用 JSR303 校验规范的 @Pattern 注解的时候，可以指定 java 正则，注意和 js 正则略有不同   ok
	@NotBlank
	@Pattern(regexp = "^([a-zA-Z0-9\\u2E80-\\u9FFF][\\w\\u2E80-\\u9FFF-]{2,4})$", message = "名字需以英文，中文开头，不能包含除 -，_ 以外其他特殊字符的3-5位字符串")
	private String name;

	// JSR303 约束（因为经过了SpringMVC 的封装，数值型的数据非空校验使用 @NotNull）
	@NotNull
	@DecimalMax(value = "100000.00", message ="工资必须小于 100000.00 ")     //ok
	@DecimalMin(value = "1000.00", message ="工资必须大于 1000.00 ")          //ok
	private Double salary;

	@NotNull
	@Range(min = 1, max = 100, message = "年龄需在1-100之间")            //ok
	private Integer age;

	// JSR303 约束（因为经过了SpringMVC 的封装，String型的数据非空校验使用 @NotBlank）
	@NotBlank
	@Pattern(regexp = "(M)|(F)", message = "性别不符合要求")  //ok
	private String gender;

	@NotBlank
	@Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", message = "邮箱格式不正确") //ok
	private String email;

	// JSR303 约束（因为经过了SpringMVC 的封装，Date型的数据非空校验使用 @NotNull）
	@NotNull   
	@Past(message = "时间选择不正确")     //ok
	@DateTimeFormat(pattern = "yyyy/MM/dd")    //ok 注意：@DateTimeFormat 是 springMVC 自带的验证规则，没有 mesage 属性，
	private Date hiredate;             //可以通过国际化文件实现错误消息的定制化，具体参考以前笔记

	@NotNull
	@Range(max = 4, min = 1, message = "没有该部门")    //ok
	private Integer deptId;

	private Department department;

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Employee(Integer id, String name, Double salary, Integer age, String gender, String email, Date hiredate,
			Integer deptId) {
		super();
		this.id = id;
		this.name = name;
		this.salary = salary;
		this.age = age;
		this.gender = gender;
		this.email = email;
		this.hiredate = hiredate;
		this.deptId = deptId;
	}

	public Employee() {
		super();

	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + ", salary=" + salary + ", age=" + age + ", gender=" + gender
				+ ", email=" + email + ", hiredate=" + hiredate + ", deptId=" + deptId + ", department=" + department
				+ "]";
	}
	

}