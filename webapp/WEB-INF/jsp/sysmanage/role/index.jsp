<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
    <%@include file="/WEB-INF/jsp/includes/headmetatreetableconfig_f.jsp" %>
</head>
<body data-type="index">
<script src="/static/assets/js/theme.js"></script>
<div class="am-g tpl-g">
    <!-- 头部 -->
    <%@include file="/WEB-INF/jsp/includes/page_head.jsp" %>

    <!-- 侧边导航栏 -->
    <jsp:include page="/includes/page_nav"/>


    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">

        <jsp:include page="/includes/inpage_cpath"></jsp:include>

        <div class="row-content  am-cf">
            <div class="row widget am-cf">
                <div class="am-u-sm-12 am-u-md-12 am-u-lg-12 widget-body  widget-body-lg am-fr">

                    <div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
                        <div class="am-form-group">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <shiro:hasPermission name="sys:create:role">
                                        <a href="${pageContext.request.contextPath}/sysmanage/role/create?p=${p}"
                                           class="am-btn am-btn-default am-btn-success"><span class="am-icon-plus"></span>
                                            新增</a>
                                    </shiro:hasPermission>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty msg}">
                        <div class="message">${msg}</div>
                    </c:if>
                    <table id="table">
                        <thead>
                        <tr>
                            <th>角色名称</th>
                            <th class="am-show-md-up">角色描述</th>
                            <th class="am-show-md-up">拥有的资源</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${roleList}" var="role">
                            <tr data-tt-id='${role.id}'>
                                <td>${role.role}</td>
                                <td class="am-show-md-up">${role.description}</td>
                                <td class="am-show-md-up">${zhangfn:resourceNames(role.resourceIds1)}</td>
                                <td>
                                    <shiro:hasPermission name="sys:update:role">
                                        <a href="${pageContext.request.contextPath}/sysmanage/role/${role.id}/update?p=${p}">修改</a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="	sys:delete:role">
                                        <a href="${pageContext.request.contextPath}/sysmanage/role/${role.id}/delete?p=${p}">删除</a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
<script src="${pageContext.request.contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
<script>
    $(function () {
        $("#table").treetable({expandable: true});
    });
</script>
</body>
</html>
