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
                                    <shiro:hasPermission name="sys:create:user">
                                        <a href="${pageContext.request.contextPath}/sysmanage/user/create?p=${p}"
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
                            <th>用户名</th>
                            <th class="am-show-md-up">所属组织</th>
                            <th class="am-show-md-up">角色列表</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr data-tt-id='${user.id}' <c:if
                                    test="${not user.rootNode}"> data-tt-parent-id='${user.parentids}'</c:if>>
                                <td>${user.username}</td>
                                <td class="am-show-md-up">${zhangfn:organizationName(user.organizationId)}</td>
                                <td class="am-show-md-up">${zhangfn:roleNames(user.roleIds1)}</td>
                                <td>
                                    <shiro:hasPermission name="sys:update:user">
                                        <a href="${pageContext.request.contextPath}/sysmanage/user/${user.id}/update?p=${p}">修改</a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="sys:delete:user">
                                        <a href="${pageContext.request.contextPath}/sysmanage/user/${user.id}/delete?p=${p}">删除</a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="sys:update:user">
                                        <a onclick="changeform('${user.username}',${user.id})">改密</a>
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
<div class="am-modal am-modal-no-btn" tabindex="-1" id="changepwdform-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><span id="modaltitle"></span>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd " id="cpwbd">

        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
<script>
    $(function () {
        $("#table").treetable({expandable: true}).treetable("expandNode", 1);
    });

    function changeform(userloginid, id) {
        $('#modaltitle').html(userloginid + '密码修改');
        $('#cpwbd').html('             <form class="am-form" action="/sysmanage/user/' + id + '/changePassword" method="post">\n' +
            '                <fieldset><div class="am-form-group">\n' +
            '                    <flabel for="newPassword" class="am-u-sm-12 am-form-label am-text-left">新密码：</flabel>\n' +
            '                    <div class="am-u-sm-12">\n' +
            '                        <input  type="text" id="newPassword" name="newPassword" class="tpl-form-input am-margin-top-xs"/>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="am-form-group">\n' +
            '                    <div class="am-u-sm-12 am-u-sm-push-12">\n' +
            '                        <br/><button\n' +
            '                                class="am-btn am-btn-primary tpl-btn-bg-color-success ">确认修改</button>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '             </fieldset></form>')
        var cpwd = $('#changepwdform-modal');
        cpwd.modal('open');
    }
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>
</html>
