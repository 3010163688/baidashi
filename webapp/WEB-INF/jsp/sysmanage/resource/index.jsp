<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                    <shiro:hasPermission name="sys:create:user">
                                        <a href="${pageContext.request.contextPath}/sysmanage/resource/0/appendChild?p=${p}"
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
                            <th>名称</th>
                            <th>类型</th>
                            <th class="am-show-md-up">URL路径</th>
                            <th class="am-show-md-up">权限字符串</th>
                            <th class="am-show-md-up">序号</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach  items="${resourceList1}"   var="rs1">
                            <tr data-tt-id='${rs1.id}'
                                    <c:if test="${not rs1.rootNode}"> data-tt-parent-id='${rs1.parentId}'</c:if>>
                                <td>${rs1.name}</td>
                                <td>${rs1.type.info}</td>
                                <td class="am-show-md-up">${rs1.url}</td>
                                <td class="am-show-md-up">${rs1.permission}</td>
                                <td class="am-show-md-up">${rs1.sort_id}</td>
                                <td>
                                    <shiro:hasPermission name="	sys:create:resource">
                                        <c:if test="${rs1.type ne 'button'}">

                                            <a href="${pageContext.request.contextPath}/sysmanage/resource/${rs1.id}/appendChild?p=${p}">新增</a>
                                        </c:if>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="sys:update:resource">
                                        <a href="${pageContext.request.contextPath}/sysmanage/resource/${rs1.id}/update?p=${p}">修改</a>
                                    </shiro:hasPermission>
                                    <c:if test="${not resource.rootNode}">
                                        <shiro:hasPermission name="sys:delete:resource">
                                            <c:if test="${not rs1.hasChild}">
                                                <a class="deleteBtn" href="#" data-id="${rs1.id}">删除</a>
                                            </c:if>
                                        </shiro:hasPermission>
                                    </c:if>
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
<script src="${pageContext.request.contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
<script>
    $(function () {
        $("#table").treetable({
            expandable: true,
            initialState: "expanded",
            clickableNodeNames: true,//点击节点名称也打开子节点.
            indent: 30//每个分支缩进的像素数。
        });
        $(".deleteBtn").click(function () {
            if (confirm("确认删除吗?")) {
                location.href = "${pageContext.request.contextPath}/sysmanage/resource/" + $(this).data("id") + "/delete?p=${p}";
            }
        });
    });
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
