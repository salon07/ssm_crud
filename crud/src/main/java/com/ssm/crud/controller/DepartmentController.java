package com.ssm.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Result;
import com.ssm.crud.service.DepartmentService;

@RestController
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/dept")
	public Result getDept() {
		List<Department> list = departmentService.getDept();
		return Result.success().add("dept", list);
	}
}
