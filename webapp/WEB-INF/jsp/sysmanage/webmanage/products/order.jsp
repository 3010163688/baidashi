<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
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
                <div class="am-u-sm-12 widget-body  widget-body-lg am-fr">
                        <table id="table"
                               class="am-u-sm-12 am-table am-table-bordered am-table-radius am-table-striped am-table-hover">
                            <thead>
                            <tr>
<%--                                <th>标题</th>--%>
                                <th>姓名</th>
<%--                                <th>公司名称</th>--%>
                                <th>加盟区域</th>
<%--                                <th>传真</th>--%>
<%--                                <th>地址</th>--%>
                                <th>联系电话</th>
                                <th>资金预算</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dataList.list}" var="rec">
                                <tr data-tt-id='${rec.id}'>
<%--                                    <td>${rec.title}</td>--%>
                                    <td>${rec.name}</td>
<%--                                    <td>${rec.ompanyName}</td>--%>
                                    <td>${rec.tel}</td>
<%--                                    <td>${rec.fax}</td>--%>
<%--                                    <td>${rec.ddr}</td>--%>
                                    <td>${rec.email}</td>
                                    <td>${rec.contents}</td>
                                    <td>
                                        <a class="deleteBtn" href="#" data-id="${rec.id}">删除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    <div class="am-u-sm-12">
                        <ul class="am-pagination am-pagination-centered">
                            <li <c:if test="${!dataList.hasPreviousPage}"> class="am-disabled" </c:if>>
                                <a href="/sysmanage/webmanage/products/order?currenPage=${dataList.pageNum-1}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">&laquo;</a>
                            </li>
                            <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
                            <c:forEach items="${dataList.navigatepageNums}" var="page_num">
                                <c:if test="${page_num == dataList.pageNum}">
                                    <li class="am-active">
                                        <a href="#">${page_num}</a>
                                    </li>
                                </c:if>
                                <c:if test="${page_num != dataList.pageNum}">
                                    <li>
                                        <a href="/sysmanage/webmanage/products/order?currenPage=${page_num}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">${page_num}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <li  <c:if test="${!dataList.hasNextPage}"> class="am-disabled" </c:if>>
                                <a href="/sysmanage/webmanage/products/order?currenPage=${dataList.pageNum+1}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">&raquo;</a>
                            </li>
                        </ul>
                    </div>
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
    });
    $(".deleteBtn").click(function () {
        //alert($(this).parent().parent().attr('data-tt-parent-id'));
        //alert($(this).data("id"));
        if (confirm("确认删除吗?")) {
            location.href = "${pageContext.request.contextPath}/sysmanage/webmanage/products/" + $(this).data("id") + "/orderdelete?p=${p}&channelid=${channelid}";
        }
    });
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
