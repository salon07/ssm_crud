<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
</head>
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<body>
	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_name" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" name="email" id="email_add_input" placeholder="email@123.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="gender_add_input" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="dept_add_input" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-5">
					<select class="form-control" name="dId">
			  
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_update_name" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" name="empName" id="empName_update_input"></p>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_update_input" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" name="email" id="email_update_input" placeholder="email@123.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="gender_update_input" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="dept_update_input" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-5">
					<select class="form-control" name="dId" id="dept_update_select">
			  
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工信息</h1>
			</div>
		</div>		
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_all_btn">删除</button>
			</div>
		</div>	
		<!-- 数据 -->	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>	
		<!-- 分页 -->	
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>		
	</div>
	<script type="text/javascript">
		var curr_page = null;
		var total_page = null;
		//页面加载完成，直接发送ajax请求，获取分页数据
		$(function(){
			to_page(1);
		});

		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pageNo="+pn,
				type:"get",
				success:function(result){
					//解析并显示员工数据
					build_emps_table(result);
					//解析并显示分页信息
					build_page_info(result);
					//解析显示分页条
					build_page_nav(result);

					curr_page = result.extend.pageInfo.pageNum;
					total_page = result.extend.pageInfo.pages;
				}
			});
		}
		
		function build_emps_table(result){
			//清空table
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'>"));
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男🚹":"女🚺");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);

				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("编辑");
				editBtn.attr("edit_id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
					.append("删除");
				delBtn.attr("del_id",item.empId);
				var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btn)
					.appendTo("#emps_table tbody");
			}); 
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"/"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录")
		}
		//解析显示分页条
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prevPageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prevPageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prevPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			
			if(result.extend.pageInfo.hasNextPage == false){
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(firstPageLi).append(prevPageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			})
			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul);
			
			navEle.appendTo("#page_nav_area");
		}

		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		$("#emp_add_modal_btn").click(function(){
			//clear
			/* $("#empAddModal form")[0].reset(); */
			reset_form("#empAddModal form");
			//发送Ajax请求，查出部门信息，显示在下拉列表中
			getDept("#empAddModal select");
			//显示模态框
			$('#empAddModal').modal({
				backdrop:'static'
			})
		})

		function getDept(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/dept",
				type:"GET",
				success:function(res){
					//$('#empAddModal select').append("")
					$.each(res.extend.dept,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					})
				}	
			})
		}

		//校验数据
		function valid_add_form(){
			//校验姓名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名为2-5中文或6-16英文数字组合");
				show_valid_msg("#empName_add_input","error","用户名为2-5中文或6-16英文数字组合");
				return false;
			} else{
				show_valid_msg("#empName_add_input","success","");
			}
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_valid_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			} else{
				show_valid_msg("#email_add_input","success","");
			}
			return true;
		}

		function show_valid_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				data:"empName="+empName,
				type:"POST",
				success:function(res){
					if(res.code == 100){
						show_valid_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-valid","success");
					} else if(res.code == 200){
						show_valid_msg("#empName_add_input","error",res.extend.valid_msg);
						$("#emp_save_btn").attr("ajax-valid","error");
					}
				}
			})
		})

		//员工信息保存
		$("#emp_save_btn").click(function(){
			//将表单中的数据提交给服务器
			//先对数据进行校验
			
			/* if(!valid_add_form()){
				return false;
			} */

			if($(this).attr("ajax-valid") == "error"){
				return false;
			} 
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(res){
					if(res.code == 100){
						$("#empAddModal").modal("hide");
						to_page(total_page + 1);
					}else{
						//console.log(res);
						if(res.extend.errorFields.empName != undefined){
							show_valid_msg("#empName_add_input","error",res.extend.errorFields.empName);
						}
						if(res.extend.errorFields.email != undefined){
							show_valid_msg("#email_add_input","error",res.extend.errorFields.email);
						}
					}
					
				}
			}) 
		})
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(res){
					var emp = res.extend.emp;
					$("#empName_update_input").text(emp.empName);
					$("#email_update_input").val(emp.email);
					$("#empUpdateModal input[name=gender]").val([emp.gender]);
					$("#empUpdateModal select").val([emp.dId]);
				}
			})
		}
		
		$(document).on("click",".edit_btn",function(){
			//查出并显示部门信息
			getDept('#empUpdateModal select');
			//查出并显示员工信息（先查出部门才能选中员工所在的部门）
			getEmp($(this).attr("edit_id"));
			$("#emp_update_btn").attr("update_id",$(this).attr("edit_id"));
			$('#empUpdateModal').modal({
				backdrop:'static'
			})
		})
		
		$("#emp_update_btn").click(function(){
			//校验邮箱
			var email = $("#email_update_input").val();
			var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_valid_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			} else{
				show_valid_msg("#email_update_input","success","");
			}
			//发送Ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("update_id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(res){
					$('#empUpdateModal').modal("hide");
					to_page(curr_page);
				}
			})
		})
		
		$(document).on("click",".del_btn",function(){
			//首先弹出确认删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除"+empName+"吗？")){
				$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("del_id"),
				type:"DELETE",
				success:function(res){
					alert(res.msg);
					to_page(curr_page);
					}
				}) 
			}
		})
		
		//全选
		$("#check_all").click(function(){
			//prop()获取dom原生的属性，attr获取自定义的属性
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		})
		//check_item
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		})
		//批量删除
		$("#emp_del_all_btn").click(function(){
			var empNames = "";
			var empIds = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+"，";
				empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
			})
			empNames = empNames.substring(0,empNames.length-1);
			empIds = empIds.substring(0,empIds.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empIds,
					type:"DELETE",
					success:function(res){
						alert(res.msg);
						to_page(curr_page);
						}
					}) 
			}
		})
	</script>
</body>
</html>