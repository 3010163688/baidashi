<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
</head>
<body>
<div class="am-g tpl-g">
    <form:form id="form" class="am-form tpl-form-border-form" method="post" modelAttribute="organization">
        <fieldset>
            <form:hidden path="id"/>
            <form:hidden path="available"/>
            <form:hidden path="parentId"/>
            <form:hidden path="parentIds"/>

            <div class="am-form-group">
                <form:label path="name" class="am-u-sm-12 am-form-label am-text-left">名称：</form:label>
                <div class="am-u-sm-12">
                    <form:input path="name" cssClass="tpl-form-input am-margin-top-xs"/>
                    <small><form:errors path="name" delimiter="," cssStyle="color: #ff0000"/>请输入1个以上的字符名称。</small>
                </div>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-12 am-u-sm-push-12" style="margin-top: 10px;">

                    <shiro:hasPermission name="sys:update:organization">
                        <form:button class="am-btn-warning" id="updateBtn">修改</form:button>
                    </shiro:hasPermission>


                    <shiro:hasPermission name="sys:delete:organization">
                        <c:if test="${not organization.rootNode}">
                            <form:button class="am-btn-danger" id="deleteBtn">删除</form:button>
                        </c:if>
                    </shiro:hasPermission>


                    <shiro:hasPermission name="sys:create:organization">
                        <form:button class="am-btn-success" id="appendChildBtn">添加子节点</form:button>
                    </shiro:hasPermission>

                    <shiro:hasPermission name="sys:update:organization">
                        <c:if test="${not organization.rootNode}">
                            <form:button class="am-btn-secondary" id="moveBtn">移动节点</form:button>
                        </c:if>
                    </shiro:hasPermission>

                </div>
            </div>
        </fieldset>
    </form:form>
</div>
<script src="${pageContext.request.contextPath}/static/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/amazeui.datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/dataTables.responsive.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>
<script>
    $(function () {
        $("#updateBtn").click(function () {
            $("#form")
                .attr("action", "${pageContext.request.contextPath}/sysmanage/organization/${organization.id}/update?p=${p}")
                .submit();
            return false;
        });
        $("#deleteBtn").click(function () {
            if (confirm("确认删除吗？")) {
                $("#form")
                    .attr('target', '_parent')
                    .attr("action", "${pageContext.request.contextPath}/sysmanage/organization/${organization.id}/delete?p=${p}")
                    .submit();
            }
            return false;
        });

        $("#appendChildBtn").click(function () {
            location.href = "${pageContext.request.contextPath}/sysmanage/organization/${organization.id}/appendChild?p=${p}";
            return false;
        });

        $("#moveBtn").click(function () {
            location.href = "${pageContext.request.contextPath}/sysmanage/organization/${organization.id}/move?p=${p}";
            return false;
        });
    });
</script>
<script type="text/javascript">
    //注意：下面的代码是放在iframe引用的子页面中调用
    $(window.parent.document).find("#orgframe").load(function () {
        var main = $(window.parent.document).find("#orgframe");
        var thisheight = $(document).height();
        main.height(thisheight);
    });
</script>
</body>
</html>
