<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <form:form id="form"  class="am-form tpl-form-border-form" method="post" modelAttribute="organization">
        <fieldset>
            <form:hidden path="id"/>
            <form:hidden path="available"/>
            <form:hidden path="parentId"/>
            <form:hidden path="parentIds"/>

            <div class="am-form-group">
                <label class="am-u-sm-12 am-form-label am-text-left">父节点名称：</label>
                <div class="am-u-sm-12">
                    <form:input path="pName" type="text" Class="tpl-form-input am-margin-top-xs"/>
                </div>
            </div>

            <div class="am-form-group">
                <form:label path="name" class="am-u-sm-12 am-form-label am-text-left">子节点名称：</form:label>
                <div class="am-u-sm-12">
                    <form:input path="name" cssClass="tpl-form-input am-margin-top-xs"/>
                    <small><form:errors cssStyle="color:#FF0000;" delimiter="," path="name"/>子节点名称必须输入。</small>
                </div>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-12 am-u-sm-push-12" style="margin-top: 10px;">
                    <form:button class="am-btn-warning">新增子节点</form:button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>
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
