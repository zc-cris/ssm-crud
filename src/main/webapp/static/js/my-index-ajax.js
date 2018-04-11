
        	// 1. 页面加载完成后，直接发送 ajax 请求去后台获取到分页数据
        	$(function () {
        		
        		//使用默认的BlockUI设置（专门用来对发送ajax请求和接收ajax响应进行页面处理）
        		//$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
        		//自定义具体的blockUI使用
        		 $(document).ajaxStart(function(){
        			 
        			$.blockUI({
        				message: $("#loading"),
        				css:{
        					top:($(window).height() - 400)/2 + 'px',
        					left:($(window).width() - 400)/2 + 'px',
        					width:'400px',
        					border:'none'
        				},
        				overlayCSS:{backgroundColor:'white'}
        			})
        		}).ajaxStop($.unblockUI); 
				
        		// 通过 ajax 获取后台的分页数据
        		to_page(1);
				
        	});
        	
        	// 构建一个专门发送 ajax请求的方法
        	function to_page(pageNum){
				$.ajax({
					
					url: "${APP_PATH}/emps_ajax",
					data: {"pageNum": pageNum},
					type: "GET",
					success:function(backData){
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
			
        	// 后台返回时间戳，前台如何显示时间由前台自己选择
        	function formatDate(now) {
        		
        		var year=now.getFullYear();
        		var month=now.getMonth()+1;
        		var date=now.getDate();
        		
        		/* var hour=now.getHours();
        		var minute=now.getMinutes();
        		var second=now.getSeconds(); 
        		return year+"/ "+month+"/ "+date+" "+hour+":"+minute+":"+second;
        		*/
        		
        		return year+" / "+month+" / "+date;
        	}
        	
        	// 后台返回的数据中工资需要显示两位小数，不足的补0
            function changeTwoDecimal_f(x) {  
        		
                var f_x = parseFloat(x);    
                if (isNaN(f_x))    
                {    
                    //alert('function:changeTwoDecimal->parameter error');    
                    //return false;    
                    return '0.00';//如果不是数字的话返回0.00  
                }    
                var f_x = Math.round(x*100)/100;    
                var s_x = f_x.toString();    
                var pos_decimal = s_x.indexOf('.');    
                if (pos_decimal < 0)    
                {    
                    pos_decimal = s_x.length;    
                    s_x += '.';    
                }    
                while (s_x.length <= pos_decimal + 2)    
                {    
                    s_x += '0';    
                }    
                return s_x;    
            }  
        		
        	
			// 通过jQuery 的方式构建员工数据显示表格
			function build_emps_table(backData){
				
				// 显示数据之前先要清空当前数据
				$("#emps_table tbody").empty();
				
				var emps = backData.map.pageInfo.list;
       			$.each(emps, function (index, emp) {

       				// 将后台传来的时间戳类型的时间进行自定义格式化
       				var hiredate = formatDate(new Date(emp.hiredate));
       				// 将后台传来的字符串类型的工资转换为 两位小数的格式
       				var salary = changeTwoDecimal_f(emp.salary);
       			
       				
					var idTd = $("<td></td>").append(emp.id);
       				var nameTd = $("<td></td>").append(emp.name).addClass("active");
       				var salaryTd = $("<td></td>").append(salary);
       				var ageTd = $("<td></td>").append(emp.age);
       				var genderTd = $("<td></td>").append(emp.gender == "M" ? "男" : "女");
       				var emailTd = $("<td></td>").append(emp.email);
       				var hiredateTd = $("<td></td>").append(hiredate);
       				var departmentNameTd = $("<td></td>").append(emp.department.name);
       				
       				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
       					.append($("<spand></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
       				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
       					.append($("<spand></span>").addClass("glyphicon glyphicon-trash")).append("删除");
       				
       				var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
       				
       				
       				// append方法可以实现链式调用，将append方法里的标签放进jquery 生成的标签里
       				$("<tr></tr>").append(idTd)
       					.append(idTd)
       					.append(nameTd)
       					.append(salaryTd)
       					.append(ageTd)
       					.append(genderTd)
       					.append(emailTd)
       					.append(hiredateTd)
       					.append(departmentNameTd)
       					.append(btnTd)
       					.appendTo("#emps_table tbody");	// appendTo方法用于将jquery 生成的标签放进某个指定标签
       					
				})
			}
			
			// 通过 jquery 动态显示分页信息
			function build_page_info_area(backData) {
				
				// 获取到 后台返回的 json 数据的 pageInfo 对象
				var pageInfo = backData.map.pageInfo;
				
				// 显示数据之前先要清空当前数据
				$("#page_info_area").empty();
				$("#page_info_area").append("当前页数：" + pageInfo.pageNum + " 页/ 总页数：" + pageInfo.pages + " 页/ 总记录数：" + pageInfo.total + " 条");
				
			}
			
			// 通过 jquery 动态显示导航条信息
			function build_page_nav_area(backData) {
				// 获取到 后台返回的 json 数据的 pageInfo 对象
				var pageInfo = backData.map.pageInfo;
				
				// 显示数据之前先要清空当前数据
				$("#page_nav_area").empty();
				
				// 构建首页
				var firstLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
				
				// 构建向上翻页标志 <<
				/*<li>
                     <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum - 1 }" aria-label="Previous">
                         <span aria-hidden="true">&laquo;</span>
                     </a>
                 </li> */
				var preLi = $("<li></li>").append($("<a></a>").attr({ "href": "#", "aria-label": "Previous"}).append($("<span></span>").attr("aria-hidden", "true").append("&laquo;")));
			
                //当前页就是首页，将首页和上一页链接置为不可用
                if(pageInfo.hasPreviousPage == false){
                	firstLi.addClass("disabled");
                	preLi.addClass("disabled");
                }else{
                	firstLi.click(function(){
                		to_page(1);
                	});
                	preLi.click(function(){
                		to_page(pageInfo.pageNum - 1);
                	})
                }
                 
				// 构建末页
				var lastLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
				
				// 构建向下翻页标志 >>
				/* <li>
                    <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum + 1 }" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li> */
				var nextLi = $("<li></li>").append($("<a></a>").attr({ "href": "#", "aria-label": "Next"}).append($("<span></span>").attr("aria-hidden", "true").append("&raquo;")));	
                
                var navUl = $("<ul></ul>").addClass("pagination").append(firstLi).append(preLi);
                
                //当前页就是末页，将末页和下一页链接置为不可用
                if(pageInfo.hasNextPage == false){
                	nextLi.addClass("disabled");
                	lastLi.addClass("disabled");
                }else{
                	nextLi.click(function(){
                		to_page(pageInfo.pageNum + 1);
                	})
                	lastLi.click(function(){
                		to_page(pageInfo.pages);
                	})
                }
                
                $.each(pageInfo.navigatepageNums, function(index, item){
                	
                	var numLi = $("<li></li>").append($("<a></a>").attr("href", "#").append(item)); 
                	// 为当前页码绑定发送 ajax 请求的单击事件
                	numLi.click(function(){
                		to_page(item);
                	})
                	// 如果是当前页码，显示加深效果
                	if(pageInfo.pageNum == item){
                		numLi.addClass("active");
                	}
                	navUl.append(numLi);
                })
                
                navUl.append(nextLi).append(lastLi);
                
                var nav = $("<nav></nav>").attr("aria-label", "Page navigation").append(navUl);
				$("#page_nav_area").append(nav);
				
			}
			