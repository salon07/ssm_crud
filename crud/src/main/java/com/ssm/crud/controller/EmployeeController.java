package com.ssm.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.Result;
import com.ssm.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * 
 * @author salon
 *
 */
@RestController
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@RequestMapping("/emps")
	public Result getEmps(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pageNo, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Result.success().add("pageInfo", page);
	}
	
	
	public String getEmps(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo, Model model) {
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pageNo, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);

		return "list";
	}
	
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	public Result saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				/*
				 * System.out.println(fieldError.getField());
				 * System.out.println(fieldError.getDefaultMessage());
				 */
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Result.fail().add("errorFields", map);
		}
		employeeService.saveEmployee(employee);
		return Result.success();
	}
	
	@RequestMapping("checkUser")
	public Result checkUser(@RequestParam("empName") String empName) {
		String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(reg)) {
			return Result.fail().add("valid_msg", "用户名必须是2-5中文或6-16英文数字组合");
		}
		
		boolean checkUser = employeeService.checkUser(empName);
		if(checkUser) {
			return Result.success();
		}else {
			return Result.fail().add("valid_msg", "用户名不可用");
		}
	}
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
	public Result getEmp(@PathVariable("id") Integer id) {
		Employee emp = employeeService.getEmp(id);
		return Result.success().add("emp", emp);
	}
	/**
	 * 员工更新
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Result saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Result.success();
	}
	/**
	 * 批量删除：1-2-3
	 * 删除单个员工：id
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Result deleteEmp(@PathVariable(value = "ids")String ids) {
		if(ids.contains("-")) {
			//批量
			String[] split = ids.split("-");
			List<Integer> list = new ArrayList<Integer>();
			for (String id : split) {
				list.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(list);
		}else {
			//单个
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Result.success();
	}
}
