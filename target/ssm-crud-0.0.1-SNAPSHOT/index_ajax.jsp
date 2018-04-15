<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>员工列表</title>

<!-- 
    web 路径问题：
        不以/开始的相对路径，找资源就是以当前资源的路径为基准，容易出问题；
        以/开始的相对路径，找资源，是以服务器的路径为基准(http://localhost:8080);
        浏览器访问的实际路径：http:localhost:8080/项目名
 -->
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
			//          /项目名 --> http:localhost:8080/项目名
%>
<!-- 引入 jquery -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
<!-- 引入 blockUI -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery.blockUI.js"></script>
<!-- 引入 bootstrap -->
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
</head>
<body>

		<!-- 员工修改信息显示Modal 模态框组件 -->
		<div class="modal fade" id="update_emp_modal" tabindex="-1" role="dialog" aria-labelledby="update_emp_modal" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
						<h4 class="modal-title" id="myModalLabel">修改员工</h4>
					</div>
					<div class="modal-body">
						<!--模态框里面的表单-->
						<form class="form-horizontal" id="update_emp_form">
							<!--名字-->
							<div class="form-group">
								<label for="update_name_input" class="col-sm-2 control-label">名字</label>
								<div class="col-sm-8">
									<p class="form-control-static" id="update_empNname_static"></p>
								</div>
							</div>
							<!--薪水-->
							<div class="form-group">
								<label for="update_salary_input" class="col-sm-2 control-label">薪水</label>
								<div class="col-sm-8">
									<input type="text" name="salary" class="form-control" id="update_salary_input" placeholder="请输入薪水">
									<span class="help-block" style="font-size: 13px;">工资必须为数字且包含5-8位整数和2位小数</span>
								</div>
							</div>
							<!--年龄-->
							<div class="form-group">
								<label for="update_age_input" class="col-sm-2 control-label">年龄</label>
								<div class="col-sm-8">
									<p class="form-control-static" id="update_age_static"></p>
								</div>
							</div>
							<!--性别-->
							<div class="form-group">
								<label for="update_gender_input" class="col-sm-2 control-label">性别</label>
								<div class="col-sm-8">
								<label class="radio-inline">
									<input type="radio" name="gender" id="update_gender_M" value="M" checked> 男
								</label>
								<label class="radio-inline">
									  <input type="radio" name="gender" id="update_gender_F" value="F"> 女
								</label>
								<div id ="update_gender_input"></div>
								<span class="help-block" style="font-size: 13px;">请选择正确的性别</span>
								</div>
							</div>
							<!--邮箱-->
							<div class="form-group">
								<label for="update_email_input" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-8">
									<input type="email" name="email" class="form-control" id="update_email_input" placeholder="请输入邮箱">
									<span class="help-block" style="font-size: 13px;">邮箱格式必须合法</span>
								</div>
							</div>
							<!--入职时间-->
							<div class="form-group">
								<label for="update_hiredate_input" class="col-sm-2 control-label">入职时间</label>
								<div class="col-sm-8">
									<p class="form-control-static" id="update_hiredate_static"></p>
								</div>
							</div> 
							<!--部门名字-->
							<div class="form-group">
								<label for="update_department_input" class="col-sm-2 control-label">所属部门</label>
								<div class="col-sm-5">
									<!--部门信息只需要向后台发送部门id即可-->
									<select class="form-control" name="deptId" id="update_deptId_input">
										
									</select>
									<span class="help-block" style="font-size: 13px;">请选择正确的部门</span>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="update_emp_btn">修改</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 员工新增Modal 模态框组件 -->
		<div class="modal fade" id="add_emp_modal" tabindex="-1" role="dialog" aria-labelledby="add_emp_modal" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
						<h4 class="modal-title" id="myModalLabel">新增员工</h4>
					</div>
					<div class="modal-body">
						<!--模态框里面的表单-->
						<form class="form-horizontal" id="add_emp_form">
							<!--名字-->
							<div class="form-group">
								<label for="add_name_input" class="col-sm-2 control-label">名字</label>
								<div class="col-sm-8">
									<input type="text" name="name" class="form-control" id="add_name_input" placeholder="请输入名字">
									<span class="help-block" style="font-size: 13px;"></span>
								</div>
							</div>
							<!--薪水-->
							<div class="form-group">
								<label for="add_salary_input" class="col-sm-2 control-label">薪水</label>
								<div class="col-sm-8">
									<input type="text" name="salary" class="form-control" id="add_salary_input" placeholder="请输入薪水">
									<span class="help-block" style="font-size: 13px;">工资必须为数字且包含5-8位整数和2位小数</span>
								</div>
							</div>
							<!--年龄-->
							<div class="form-group">
								<label for="add_age_input" class="col-sm-2 control-label">年龄</label>
								<div class="col-sm-8">
									<input type="text" name="age" class="form-control" id="add_age_input" placeholder="请输入年龄">
									<span class="help-block" style="font-size: 13px;">年龄必须在1-200之间</span>
								</div>
							</div>
							<!--性别-->
							<div class="form-group">
								<label for="add_gender_input" class="col-sm-2 control-label">性别</label>
								<div class="col-sm-8">
								<label class="radio-inline">
									<input type="radio" name="gender" id="add_gender_M" value="M" checked> 男
								</label>
								<label class="radio-inline">
									  <input type="radio" name="gender" id="add_gender_F" value="F"> 女
								</label>
								<div id ="add_gender_input"></div>
								<span class="help-block" style="font-size: 13px;">请选择正确的性别</span>
								</div>
							</div>
							<!--邮箱-->
							<div class="form-group">
								<label for="add_email_input" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-8">
									<input type="email" name="email" class="form-control" id="add_email_input" placeholder="请输入邮箱">
									<span class="help-block" style="font-size: 13px;">邮箱格式必须合法</span>
								</div>
							</div>
							<!--入职时间-->
							<div class="form-group">
								<label for="add_hiredate_input" class="col-sm-2 control-label">入职时间</label>
								<div class="col-sm-8">
									<input type="date" name="hiredate" class="form-control" id="add_hiredate_input" placeholder="请填选入职时间">
									<span class="help-block" style="font-size: 13px;">请勿选择大于当前的时间</span>
								</div>
							</div> 
							<!--部门名字-->
							<div class="form-group">
								<label for="add_department_input" class="col-sm-2 control-label">所属部门</label>
								<div class="col-sm-5">
									<!--部门信息只需要向后台发送部门id即可-->
									<select class="form-control" name="deptId" id="add_deptId_input">
										
									</select>
									<span class="help-block" style="font-size: 13px;">请选择正确的部门</span>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="save_emp_btn">Save</button>
					</div>
				</div>
			</div>
		</div>

	<!--搭建显示页面-->
	<div class="container">
		<!--标题-->
		<div class="row">
			<div class="col-md-12">
				<h1>ZC-CRIS SSM CRUD</h1>
			</div>
		</div>

		<!--按钮组-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="add_emp_modal_btn" data-toggle="modal"
					data-target="#add_emp_modal" data-backdrop="static">新增</button>
				<button class="btn btn-danger" id="delete_allEmp_btn">删除</button>
			</div>
		</div>
		<hr />



		<!--显示表格数据-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped table-hover" id="emps_table">
					<thead>
						<tr class="info text-center">
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>name</th>
							<th>salary</th>
							<th>age</th>
							<th>gender</th>
							<th>email</th>
							<th>hiredate</th>
							<th>department</th>
							<th>操作</th>
						</tr>
					</thead>

					<tbody>

					</tbody>

				</table>
			</div>
		</div>

		<!--显示分页信息-->
		<div class="row">

			<!--分页文字信息-->
			<div class="col-md-6" id="page_info_area"></div>

			<!--分页条信息-->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	
	

	<!-- 引入 blockUI 需要的 gif -->
	<img id="loading" alt="" src="${APP_PATH}/static/img/load.gif"
		style="display: none" />

	<script type="text/javascript">
		// 定义一个变量记录总记录数，主要是为了新增数据成功跳转至最后一页显示新添加的数据
		// 定义一个当前页码的变量，方便更新数据成功后跳转至当前页显示修改后的数据
		var totalRecord, currentPage;
	
		/* 1. 页面加载完成后，直接发送 ajax 请求去后台获取到分页数据 */
		$(function() {
			

			//使用默认的BlockUI设置（专门用来对发送ajax请求和接收ajax响应进行页面处理）
			//$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
			//自定义具体的blockUI使用
			$(document).ajaxStart(function() {
			
				$.blockUI({
					message : $("#loading"),
					css : {
						top : ($(window).height() - 400) / 2 + 'px',
						left : ($(window).width() - 400) / 2 + 'px',
						width : '400px',
						border : 'none'
					},
					overlayCSS : {
						backgroundColor : 'white'
					}
				})
			}).ajaxStop($.unblockUI);

			// 通过 ajax 获取后台的分页数据
			to_page(1);

		});

		/* 2. 构建一个专门发送 ajax请求的方法 */
		function to_page(pageNum) {
			$.ajax({

				url : "${APP_PATH}/emps_ajax",
				data : {
					"pageNum" : pageNum
				},
				type : "GET",
				success : function(backData) {
					//console.log(backData);
					// 1. 解析并显示员工数据
					build_emps_table(backData);
					// 2. 解析并显示分页信息
					build_page_info_area(backData);
					// 3. 解析并显示导航条信息
					build_page_nav_area(backData);

				}
			});
		}

		/* 3. 后台返回时间戳，前台如何显示时间由前台自己选择 */
		function formatDate(now) {

			var year = now.getFullYear();
			var month = now.getMonth() + 1;
			var date = now.getDate();

			/* var hour=now.getHours();
			var minute=now.getMinutes();
			var second=now.getSeconds(); 
			return year+"/ "+month+"/ "+date+" "+hour+":"+minute+":"+second;
			 */
			if(month < 10){
				month = "0" + month;
			}
			if(date < 10){
				date = "0" + date;
			}

			return year + " / " + month + " / " + date;
		}

		/* 4.后台返回的数据中工资需要显示两位小数，不足的补0 */
		function changeTwoDecimal_f(x) {

			var f_x = parseFloat(x);
			if (isNaN(f_x)) {
				//alert('function:changeTwoDecimal->parameter error');    
				//return false;    
				return '0.00';//如果不是数字的话返回0.00  
			}
			var f_x = Math.round(x * 100) / 100;
			var s_x = f_x.toString();
			var pos_decimal = s_x.indexOf('.');
			if (pos_decimal < 0) {
				pos_decimal = s_x.length;
				s_x += '.';
			}
			while (s_x.length <= pos_decimal + 2) {
				s_x += '0';
			}
			return s_x;
		}

		/* 5. 通过jQuery 的方式构建员工数据显示表格 */
		function build_emps_table(backData) {
			
			

			// 显示数据之前先要清空当前数据
			$("#emps_table tbody").empty();

			var emps = backData.map.pageInfo.list;
			$.each(emps,
					function(index, emp) {

						// 将后台传来的时间戳类型的时间进行自定义格式化
						var hiredate = formatDate(new Date(emp.hiredate));
						// 将后台传来的字符串类型的工资转换为 两位小数的格式
						var salary = changeTwoDecimal_f(emp.salary);

						var checkboxTd = $("<td><input type='checkbox' class='check_item'></td>");
						var idTd = $("<td></td>").append(emp.id);
						var nameTd = $("<td></td>").append(emp.name).addClass(
								"active");
						var salaryTd = $("<td></td>").append(salary);
						var ageTd = $("<td></td>").append(emp.age);
						var genderTd = $("<td></td>").append(
								emp.gender == "M" ? "男" : "女");
						var emailTd = $("<td></td>").append(emp.email);
						var hiredateTd = $("<td></td>").append(hiredate);
						var departmentNameTd = $("<td></td>").append(
								emp.department.name);

						var editBtn = $("<button></button>").addClass(
								"btn btn-primary btn-sm edit_btn").append(
								$("<spand></span>").addClass(
										"glyphicon glyphicon-pencil")).append(
								"编辑");
						// 为编辑按钮添加自定义的属性，表示当前员工id
						editBtn.attr("edit_id", emp.id);
						
						
						var deleteBtn = $("<button></button>").addClass(
								"btn btn-danger btn-sm delete_btn").append(
								$("<spand></span>").addClass(
										"glyphicon glyphicon-trash")).append(
								"删除");
						// 为删除按钮添加自定义的属性
						deleteBtn.attr("delete_id", emp.id);
						

						var btnTd = $("<td></td>").append(editBtn).append(" ")
								.append(deleteBtn);
						
						// append方法可以实现链式调用，将append方法里的标签放进jquery 生成的标签里
						$("<tr></tr>").append(checkboxTd).append(idTd).append(nameTd)
								.append(salaryTd).append(ageTd)
								.append(genderTd).append(emailTd).append(
										hiredateTd).append(departmentNameTd)
								.append(btnTd).appendTo("#emps_table tbody"); // appendTo方法用于将jquery 生成的标签放进某个指定标签

					})
		}

		/* 6. 通过 jquery 动态显示分页信息 */
		function build_page_info_area(backData) {

			// 获取到 后台返回的 json 数据的 pageInfo 对象
			var pageInfo = backData.map.pageInfo;
			
			totalRecord = pageInfo.total;
			currentPage = pageInfo.pageNum;

			// 显示数据之前先要清空当前数据
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前页数：" + pageInfo.pageNum + " 页/ 总页数：" + pageInfo.pages
							+ " 页/ 总记录数：" + totalRecord + " 条");

		}

		/* 7. 通过 jquery 动态显示导航条信息 */
		function build_page_nav_area(backData) {
			// 获取到 后台返回的 json 数据的 pageInfo 对象
			var pageInfo = backData.map.pageInfo;

			// 显示数据之前先要清空当前数据
			$("#page_nav_area").empty();

			// 构建首页
			var firstLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));

			// 构建向上翻页标志 <<
			/*<li>
			    <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum - 1 }" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			    </a>
			</li> */
			var preLi = $("<li></li>").append(
					$("<a></a>").attr({
						"href" : "#",
						"aria-label" : "Previous"
					}).append(
							$("<span></span>").attr("aria-hidden", "true")
									.append("&laquo;")));

			//当前页就是首页，将首页和上一页链接置为不可用
			if (pageInfo.hasPreviousPage == false) {
				firstLi.addClass("disabled");
				preLi.addClass("disabled");
			} else {
				firstLi.click(function() {
					to_page(1);
				});
				preLi.click(function() {
					to_page(pageInfo.pageNum - 1);
				})
			}

			// 构建末页
			var lastLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			// 构建向下翻页标志 >>
			/* <li>
			   <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum + 1 }" aria-label="Next">
			       <span aria-hidden="true">&raquo;</span>
			   </a>
			</li> */
			var nextLi = $("<li></li>").append(
					$("<a></a>").attr({
						"href" : "#",
						"aria-label" : "Next"
					}).append(
							$("<span></span>").attr("aria-hidden", "true")
									.append("&raquo;")));

			var navUl = $("<ul></ul>").addClass("pagination").append(firstLi)
					.append(preLi);

			//当前页就是末页，将末页和下一页链接置为不可用
			if (pageInfo.hasNextPage == false) {
				nextLi.addClass("disabled");
				lastLi.addClass("disabled");
			} else {
				nextLi.click(function() {
					to_page(pageInfo.pageNum + 1);
				})
				lastLi.click(function() {
					to_page(pageInfo.pages);
				})
			}

			$.each(pageInfo.navigatepageNums, function(index, item) {

				var numLi = $("<li></li>").append(
						$("<a></a>").attr("href", "#").append(item));
				// 为当前页码绑定发送 ajax 请求的单击事件
				numLi.click(function() {
					to_page(item);
				})
				// 如果是当前页码，显示加深效果
				if (pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				navUl.append(numLi);
			})

			navUl.append(nextLi).append(lastLi);

			var nav = $("<nav></nav>").attr("aria-label", "Page navigation")
					.append(navUl);
			$("#page_nav_area").append(nav);

		}
		
		/* 8. 动态生成新增员工的模态框 */
		// 注意：无法根据 bootstrap 官网的示例，将模态框参数通过 js 代码设置，
		// 且 modal 方法里的参数需要一个形参，不能没有，也不能为{}，否则经过
		// fireFox 和 chrome 测试模态框均闪退
		$("#add_emp_modal_btn").click(function(){
			
				// 表单重置
				$("#add_emp_modal form")[0].reset();
				// 清除所有输入框的提示信息
				//$("#add_emp_modal span").text("");
				// 清除所有输入框的颜色样式
				$("#add_emp_modal input").parent().removeClass("has-error has-success");
				$("#add_emp_modal span").css("color", "darkseagreen");
				$("#add_name_input").next("span").text("名字需以英文，中文开头，不能包含除 -，_ 以外其他特殊字符的3-5位字符串");
				
				
				// 发送 ajax 请求，查出部门信息，显示在下拉列表中
				getDepts("#add_emp_modal select");
				
				// 弹出模态框
				$("#add_emp_modal").modal(options);
				
			});
		
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				data : {
					"date" : new Date()
				},
				type : "GET",
				success : function(backData) {
					//console.log(backData);
					var select = $(ele);
					$.each(backData.map.depts, function(){
						$("<option></option>").append(this.name).attr("value", this.id).appendTo(select);
					})

				}
				
			})
		}
		
		/* 9. 将表单数据直接转换为 json 格式的数据 */
		$.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        }; 
        
        /* 10. 自定义通用的 replaceAll */
        String.prototype.replaceAll = function(s1, s2){
				return this.replace(new RegExp(s1, "gm"), s2);
				
			}
        
        // 名字验证(单独提取出来，因为后台有唯一性需求)
        function validate_name(nameInput){
        	var name = $(nameInput).val();
        	var regName = /(^[a-zA-Z0-9\u2E80-\u9FFF][\w\u2E80-\u9FFF-]{2,4}$)/;
        	if(!regName.test(name)){
        		validate_msg(nameInput, "error");
        		$("#add_name_input").next("span").text("名字需以英文，中文开头，不能包含除 -，_ 以外其他特殊字符的3-5位字符串").css("color", "red");
        		return false;
        	}else{
        		validate_msg(nameInput, "success");
        		return true;
        	}
        }
        
        // 工资校验
        function validate_salary(ele){
        	
        	var salary = $(ele).val();
        	var regSalary = /^[1-9]\d{4,7}\.{1}\d{2}$/;
        	if(!regSalary.test(salary)){
        		validate_msg(ele, "error");
        		return false;
        	} else {
        		validate_msg(ele, "success");
        		return true;
        	}
        }
        // 邮箱校验
        function validate_email(ele) {
        	var email = $(ele).val();
        	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        	if (!regEmail.test(email)) {
        		validate_msg(ele, "error");
        		return false;
        	} else {
        		validate_msg(ele, "success");
        		return true;
        	}
		}
        
        
     
		/* ~~~新增员工时的数据校验 */
        function validate_add_emp(){
			
			// 取消用户名校验，通过 change 事件校验即可
        	// 工资校验
        	if(!validate_salary("#add_salary_input")){
        		return false;
        	};
        	
        	// 年龄校验
        	var age = $("#add_age_input").val();
        	var regAge = /(^[1]\d{1,2}$)|(^[2-9]\d{1}$)/;
        	if(!regAge.test(age)){
        		validate_msg("#add_age_input", "error");
        		return false;
        	}else{
        		validate_msg("#add_age_input", "success");
        	}
        	
        	// 邮箱校验
        	if(!validate_email("#add_email_input")){
        		return false;
        	};
        	
        	
        	// 入职时间校验
        	var hiredate = $("#add_hiredate_input").val();
        	if($.trim(hiredate) == ""){
        		validate_msg("#add_hiredate_input", "error");
        		return false;
        	}
			hiredate = hiredate.replace(/-/g, "/");
			var d=new Date(Date.parse(hiredate));
			var curDate=new Date();
			if(d>curDate){
				validate_msg("#add_hiredate_input", "error");
				return false;
			}else{
				validate_msg("#add_hiredate_input", "success");
			}
        	return true;
        }
        /* 11. 结合bootstrap 进行验证信息的美化显示*/
       function validate_msg (obj , status){
       		var objParent = $(obj).parent();
       		
       		objParent.removeClass("has-error has-success");
       		
       		if ("success" == status) {
       			objParent.addClass("has-success");
       			$(obj).next("span").css("color", "darkseagreen");
       		} else if ("error" == status) {
       			objParent.addClass("has-error");
       			$(obj).next("span").css("color", "red");
       		}
       }
       
        
       /* 12. 内容改变事件：发送 ajax请求到后台验证用户名是否已经存在 */
       $("#add_name_input").change(function(){
       			
    	   		// 如果用户名不合法也就没有必要去后台校验用户名是否存在了
    	   		if(!validate_name("#add_name_input")){
    	   			return false;
    	   		}
    	   
       			var empName = $(this).val();
       			empName = $.trim(empName);
       			$.ajax({
       				type:"post",
       				url:"${APP_PATH}/checkEmpName",
       				data:"empName=" + empName,
       				success:function(backData){
       					if(backData.code == 100){		//后台返回code 为100 表示当前用户名可以使用
       						validate_msg("#add_name_input", "success");
       						$("#add_name_input").next("span").text("用户名可用").css("color", "darkseadarkseagreen");
       						$("#save_emp_btn").attr("name_validate", "available");	//添加指定属性给保存按钮
       					} else if (backData.code == 200){	//后台返回code 为100 表示当前用户名不可以使用
       						validate_msg("#add_name_input", "error");
       						$("#add_name_input").next("span").text("用户名不可用").css("color", "red");
       						$("#save_emp_btn").attr("name_validate", "disable");	//添加指定属性给保存按钮
       					}
       				}
       			});
       			
       		
       })
        
		/* 13. 通过 ajax 完成模态框的数据新增 */
		$("#save_emp_btn").click(function(){
			
			// 13.1 数据校验
			if(!validate_add_emp()){
				return false;
			}; 
			
			
			// 13.2 必须验证用户名的 ajax 请求返回成功的信息，才可以完成数据的新增操作
			// 通过保存按钮属性值判断后台验证是否成功（更优雅）
			 if($("#save_emp_btn").attr("name_validate") != "available"){
				$("#add_name_input").next("span").css("color", "red");
				return false;
			} 
		
			var NewEmpdata = $("#add_emp_modal form").serializeObject();
			// json 对象修改指定键的值
			NewEmpdata["hiredate"] = NewEmpdata.hiredate.replace(/-/g,"/");
			alert(JSON.stringify(NewEmpdata));
			
			
			// 模态框填写的表单数据交给服务器保存
			// 13.3 发送 ajax 请求保存员工
			 $.ajax({ 
				url : "${APP_PATH}/emp",
				// SpringMVC 默认只处理前台传来的数据格式为 xxxx/xx/xx 的时间格式
				//data : JSON.parse(AddEmpdata),		// 将j处理后的 son 字符串转换为 json 对象
				data : NewEmpdata,						// 直接传入处理后的 json 对象
				type : "POST",
				success : function(backData){
					
					alert(backData.message);
					
					if(backData.code == 100){
					// 保存员工成功
					// 1.关闭模态框
					$("#add_emp_modal").modal('hide');
					// 2. 来到最后一页，显示刚才保存的数据（发送 ajax 请求，显示最后一页的数据即可）
					// 这里故意使后台的 pagehelper 助手跳转到比当前总页数最大的一页，默认处理为最后一页
					to_page(totalRecord);
					
					}else{
						// 哪个字段后台校验不通过，那么就提示哪个字段
						// 使用jquery 遍历 map里面的 每个 json格式的数据，index 就是键，fieldError（this) 就是值
						// 使用jquery 遍历 list里面的 每个 字符串格式的数据，index 就是索引，fieldError（this) 就是值
						$.each(backData.map.fieldErrors, function(index, fieldError){
							
							if(undefined != fieldError){
								validate_msg("#add_"+ fieldError +"_input", "error");
							}
						})
					}
					
				} 
			})
		})
		
		// 14. 因为是在按钮创建之前就绑定了click 时间，所以使用click 事件无法创建函数
		// 1. 可以在创建按钮的时候绑定	//2. 使用on 事件（live 事件在 jquery 1.7 之后就被取消）
		$(document).on("click",".edit_btn", function(){
			
			
			//1. 查询部门信息
			// 发送 ajax 请求，查出部门信息，显示在下拉列表中
			getDepts("#update_emp_modal select");
			$("#update_emp_modal").modal({
				backdrop:"static"
			});
			
			//2. 查询需要更新的用户信息
			getEmp($(this).attr("edit_id"));
			
			//2.2 将员工的id值放入到 update 按钮的属性中
			$("#update_emp_btn").attr("update_id", $(this).attr("edit_id"));
			
			//3. 弹出模态框
			// 表单重置
			$("#update_emp_modal form")[0].reset();
			// 清除所有输入框的颜色样式
			$("#update_emp_modal input").parent().removeClass("has-error has-success");
			$("#update_emp_modal span").css("color", "darkseagreen");
			
		
			
		});
		
			// 15.使用 ajax 请求去后台根据id查询员工并显示在模态框中
			function getEmp(id) {
				$.ajax({
					url: "${APP_PATH}/emp/" + id,
					type: "get",
					success: function (backData) {
						
						var emp = backData.map.emp;
						// 将后台传来的时间戳类型的时间进行自定义格式化
						var hiredate = formatDate(new Date(emp.hiredate));
						// 将后台传来的字符串类型的工资转换为 两位小数的格式
						var salary = changeTwoDecimal_f(emp.salary);
						
						$("#update_empNname_static").text(emp.name);
						$("#update_hiredate_static").text(hiredate);
						$("#update_age_static").text(emp.age);
						$("#update_email_input").val(emp.email);
						$("#update_salary_input").val(salary);
						
						// 单选框被选中
						$("#update_emp_modal input[name=gender]").val([emp.gender]);
						// 下拉框被选中
						$("#update_emp_modal select").val([emp.deptId]);
						
						
					}
				})
			}
		
			// 16. 更新员工数据
			$("#update_emp_btn").click(function(){
				
				//1. 验证薪水是否合法
        		if(!validate_salary("#update_salary_input")){
        			return false;
        		};
				
				//2. 验证邮箱是否合法
        		if(!validate_email("#update_email_input")){
        			return false;	
        		};
        		
				//3. 发送ajax 请求保存更新的员工数据
				$.ajax({
					url: "${APP_PATH}/emp/" + $(this).attr("update_id"),
					method: "PUT",   // 需要在web.xml 中配置一个专门的put请求解析的filter
					data:$("#update_emp_modal form").serialize(),
					
					// 传统的方法将将 post 请求转换为 PUT 或 DELETE 请求
/* 					method: "POST",  
					data:$("#update_emp_modal form").serialize() + "&_method=PUT", */
					
					success:function(backData){
						alert(backData.message);
						
						// 修改员工成功
						// 1.关闭模态框
						$("#update_emp_modal").modal('hide');
						// 2. 来到当前页，显示刚才修改的数据（发送 ajax 请求，显示当前页的数据即可）
						to_page(currentPage);
						
					}
				})
			})
			
			// 为删除按钮绑定单击事件(单个删除)
			$(document).on("click",".delete_btn", function(){
				var name = $(this).parents("tr").find("td:eq(2)").text();
				if (confirm("确认要删除【" + name + "】吗？")) {
					$.ajax({
						url:"${APP_PATH}/emp/" + $(this).attr("delete_id"),
						type:"DELETE",
						success:function(backData){
							alert(backData.message);
							//回到本页显示删除后的页面信息
							to_page(currentPage);
						}
					})
				}
			
		});
			
			// 完成全选全不选的功能（非常简单）
			$("#check_all").click(function(){
				// prop用来获取dom原生属性的值，attr用来获取自定义属性的值
				// 如果使用 attr 来获取原生属性的值，就会是 undefined
				$(".check_item").prop("checked", $(this).prop("checked"));
			})
			// 完成当前页面所有数据的checkbox都选择时，全选框自动勾选；反之取消
			$(document).on("click",".check_item", function(){
				var flag = $(".check_item:checked").length == $(".check_item").length;
				$("#check_all").prop("checked", flag);
			})
			// 点击批量删除按钮
			$("#delete_allEmp_btn").click(function () {
				var names = "";
				var ids = "";
				$.each($(".check_item:checked"),function(){
					names += $(this).parents("tr").find("td:eq(2)").text() + ",";
					ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
				})
				names = names.substring(0, names.length - 1);
				ids = ids.substring(0, ids.length - 1);
				if (confirm("确认要删除【" + names + "】吗？")) {
					$.ajax({
						url:"${APP_PATH}/emp/"+ ids,
						type:"DELETE",
						success:function(backData){
							alert(backData.message);
							to_page(currentPage);
						}
					})
				}
			})
		
		
	</script>




</body>
</html>