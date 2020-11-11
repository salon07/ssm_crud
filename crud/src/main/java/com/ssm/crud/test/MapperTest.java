package com.ssm.crud.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
//指定Spring配置文件的位置
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Test
	public void testCRUD() {
		Employee employee = new Employee(null, "喵喵", "F", "miao@123.com",50);
		employeeMapper.insertSelective(employee);
	}

}
