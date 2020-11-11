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
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<body>
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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>	
		<!-- 数据 -->	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
					<tr>
						<td>${emp.empId }</td>
						<td>${emp.empName }</td>
						<td>${emp.gender=="M"?"男":"女" }</td>
						<td>${emp.email }</td>
						<td>${emp.department.deptName }</td>
						<td>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>	
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>	
		<!-- 分页 -->	
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				<b>当前第${pageInfo.pageNum }/${pageInfo.pages }页,总${pageInfo.total }条记录</b>
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pageNo=1">首页</a></li>
						<c:if test="${pageInfo.hasPreviousPage }">
							<li><a href="${APP_PATH }/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
							<c:if test="${page_num==pageInfo.pageNum }">
								<li class="active"><a href="#">${page_num }</a></li>
							</c:if>
							<c:if test="${page_num!=pageInfo.pageNum }">
								<li class=""><a href="${APP_PATH }/emps?pageNo=${page_num}">${page_num }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage }">
							<li><a href="${APP_PATH }/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						<li><a href="${APP_PATH }/emps?pageNo=${pageInfo.pages}">尾页</a></li>
					</ul>
				</nav>
			</div>
		</div>		
	</div>
</body>
</html>