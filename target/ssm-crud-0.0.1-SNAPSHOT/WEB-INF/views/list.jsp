<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
<!-- 引入 bootstrap -->
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
    <body>
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
                    <button class="btn btn-primary">新增</button>
                    <button class="btn btn-danger">删除</button>
                </div>
            </div>
            <hr />

            <!--显示表格数据-->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-striped table-hover">
                        <tr class="info text-center">
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
                        <c:forEach items = "${pageInfo.list }" var = "employee">
                        <tr>
                            <td>${employee.id }</td>
                            <td class="active">${employee.name }</td>
                            <td>${employee.salary }</td>
                            <td>${employee.age }</td>
                            <td>
                                ${employee.gender == "M"?"男":"女" }
                            </td>
                            <td>${employee.email }</td>
                            <td>
                                <fmt:formatDate value="${employee.hiredate }" pattern = "yyyy-MM-dd" />
                            </td>
                            <td>${employee.department.name }</td>
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

            <!--显示分页信息-->
            <div class="row">
            
                <!--分页文字信息-->
                <div class="col-md-6">
                    当前页数：${pageInfo.pageNum } 页/
                    总页数：${pageInfo.pages } 页/
                    总记录数：${pageInfo.total } 条
                </div>
                
                <!--分页条信息-->
                <div class="col-md-6">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${pageInfo.pageNum == 1 }">
                            <li class="disabled"><a href="#">首页</a></li>
                            <li class="disabled">
                                <a href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            </c:if>
                            <c:if test="${pageInfo.hasPreviousPage }">
                            <li><a href="${APP_PATH }/emps">首页</a></li>
                            <li>
                                <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum - 1 }" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                                <c:if test="${page_Num == pageInfo.pageNum }">
                                <li class="active"><a href="#">${page_Num }</a></li>
                                </c:if>
                                <c:if test="${page_Num != pageInfo.pageNum }">
                                <li><a href="${APP_PATH }/emps?pageNum=${page_Num }">${page_Num }</a></li>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.pageNum != pageInfo.pages }">
                            <li>
                                <a href="${APP_PATH }/emps?pageNum=${pageInfo.pageNum + 1 }" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li><a href="${APP_PATH }/emps?pageNum=${pageInfo.pages }">末页</a></li>
                            </c:if>
                            <c:if test="${pageInfo.isLastPage }">
                                 <li class="disabled">
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled"><a href="#">末页</a></li>
                            </c:if>
                            
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </body>
</html>