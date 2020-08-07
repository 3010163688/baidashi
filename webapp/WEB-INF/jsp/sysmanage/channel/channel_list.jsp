<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-06-20
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
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
                                    <a href="${pageContext.request.contextPath}/sysmanage/channel/0/add/channel_edit?p=${p}"
                                       class="am-btn am-btn-default"><span class="am-icon-plus"></span>
                                        新增</a>
                                    <a href="${pageContext.request.contextPath}/sysmanage/channel/channel_edit?p=${p}"
                                       class="am-btn am-btn-default am-btn-primary"><span class="am-icon-save"></span>
                                        保存</a>
                                    <a href="${pageContext.request.contextPath}/sysmanage/channel/channel_edit?p=${p}"
                                       class="am-btn am-btn-default am-btn-success"><span class="am-icon-check-square"></span>
                                        全选</a>
                                    <a href="${pageContext.request.contextPath}/sysmanage/channel/channel_edit?p=${p}"
                                       class="am-btn am-btn-default am-btn-danger"><span class="am-icon-minus-square"></span>
                                        删除</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty msg}">
                        <div class="message">${msg}</div>
                    </c:if>
                    <table id="table" class="am-u-sm-12">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>标题</th>
                            <th>所属站点</th>
                            <th>相册</th>
                            <th>附件</th>
                            <th>规格</th>
                            <th>排序</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${channelList}" var="item">
                            <tr  data-tt-id='${item.id}'>
                                <td>${item.name}</td>
                                <td>${item.title}</td>
                                <td>${item.site_id}</td>
                                <td>${item.is_albums}</td>
                                <td>${item.is_attach}</td>
                                <td>${item.is_spec}</td>
                                <td>${item.sort_id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/sysmanage/channel/${item.id}/edit/channel_edit?p=${p}">修改</a>
                                    <a class="deleteBtn" href="#"  data-id="${item.id}">删除</a>
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
            //initialState: "expanded",
            clickableNodeNames: true,//点击节点名称也打开子节点.
            indent: 30//每个分支缩进的像素数。
        });
    });
    $(".deleteBtn").click(function () {
        //alert($(this).parent().parent().attr('data-tt-parent-id'));
        //alert($(this).data("id"));
        if (confirm("确认删除吗?")) {
            location.href = "${pageContext.request.contextPath}/sysmanage/channel/" + $(this).data("id") + "/delete?p=${p}";
        }
    });
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
