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
                                    <c:if test="${tal>0}">
                                        <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/0/add/categoryedit?p=${p}&channelid=${channelid}"
                                           class="am-btn am-btn-default am-btn-success"><span
                                                class="am-icon-plus"></span>
                                            新增</a>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty msg}">
                        <div class="message">${msg}</div>
                    </c:if>
                    <table id="table" class="am-u-sm-12 am-table am-table-bordered am-table-radius am-table-striped am-table-hover">
                        <thead>
                        <tr>
                            <th>类别名称</th>
<%--                            <th>英文名称</th>--%>
                            <th class="am-show-md-up">封面图</th>
                            <th class="am-show-md-up">序号</th>
                            <th>操作</th>
                            <th>备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${articleCategoryList}" var="ac">
                            <c:set var="__lrop" value="${ac.localRecOP==null||''.equals(ac.localRecOP.trim())||ac.localRecOP.trim().length()!=12?'111111010100':ac.localRecOP.trim()}"/>
                            <tr data-tt-id='${ac.id}'
                                    <c:if test="${not ac.rootNode}"> data-tt-parent-id='${ac.parent_id}'</c:if>
                                hasChild="${ac.hasChild}">
                                <td class="am-text-nowrap">${ac.title}</td>
<%--                                <td>${ac.titleEn}</td>--%>
                                <td class="am-show-md-up"><img  data-am-popover="{content: '<img style=\'height:100px;\' src=\'${"".equals(ac.img_url)||ac.img_url==null?"/static/assets/img/pictureplaceholder.png":ac.img_url.split(",")[0]}\'/>', trigger: 'hover focus'}" style="height: 20px;cursor: pointer;" src="${''.equals(ac.img_url)||ac.img_url==null?'/static/assets/img/pictureplaceholder.png':ac.img_url.split(",")[0]}"/></td>
                                <td class="am-show-md-up">${ac.sort_id}</td>
                                <td  class="am-text-nowrap">
                                    <c:if test="${ac.class_layer>=sal&&ac.class_layer<salend}">
                                        <c:if test="${'1'.equals(__lrop.substring(0,1))}">
                                            <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${ac.id}/add/categoryedit?p=${p}&channelid=${channelid}">新增子类</a>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${ac.class_layer>=copyStart&&ac.class_layer<copyEnd}">
                                    <c:if test="${'1'.equals(__lrop.substring(0,1))}">
                                        <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${ac.id}/edit/categoryedit?p=${p}&channelid=${channelid}&action=copy">复制</a>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${ac.class_layer>=sml&&ac.class_layer<smlend}">
                                    <c:if test="${'1'.equals(__lrop.substring(2,3))}">
                                        <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${ac.id}/edit/categoryedit?p=${p}&channelid=${channelid}">修改</a>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${not ac.hasChild}">
                                        <c:if test="${ac.class_layer>=sdl&&ac.class_layer<sdlend}">
                                            <c:if test="${'1'.equals(__lrop.substring(1,2))}">
                                            <a class="deleteBtn" href="#" data-id="${ac.id}">删除</a>
                                            </c:if>
                                        </c:if>
                                    </c:if>
                                </td>
                                <td class="am-show-md-up">${ac.remarks}</td>
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
            indent: 10//每个分支缩进的像素数。
        });
    });
    $(".deleteBtn").click(function () {
        //alert($(this).parent().parent().attr('data-tt-parent-id'));
        //alert($(this).data("id"));
        if (confirm("确认删除吗?")) {
            location.href = "${pageContext.request.contextPath}/sysmanage/webmanage/products/" + $(this).data("id") + "/delete?p=${p}&channelid=${channelid}";
        }
    });
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
