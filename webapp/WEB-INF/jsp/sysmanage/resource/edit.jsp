<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
</head>

<body data-type="index">
<script src="/static/assets/js/theme.js"></script>
<div class="am-g tpl-g">
    <!-- 头部 -->
    <%@include file="/WEB-INF/jsp/includes/page_head.jsp"%>

    <!-- 侧边导航栏 -->
    <jsp:include page="/includes/page_nav"/>


    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">

        <jsp:include page="/includes/inpage_cpath"></jsp:include>

        <div class="row-content  am-cf">
            <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                <div class="widget am-cf">
                    <div class="widget-body am-fr">
                        <c:if test="${not empty msg}">
                            <div class="message">${msg}</div>
                        </c:if>
                        <form:form class="am-form tpl-form-border-form" method="post" commandName="resource">
                            <form:hidden path="id"/>
                            <form:hidden path="picicon"/>
                            <form:hidden path="parentId"/>
                            <form:hidden path="parentIds"/>

                            <c:if test="${not empty parent}">
                                <div class="am-form-group">
                                    <div class="am-u-sm-12">父节点名称：${parent.name}</div>
                                </div>
                            </c:if>

                            <div class="am-form-group">
                                <form:label path="name" class="am-u-sm-12 am-form-label am-text-left"><c:if
                                        test="${not empty parent}">子</c:if>名称：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="name"/>
                                    <small><form:errors path="name" cssStyle="color: #FF0000;" delimiter=","/>请填写名称。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="nameCode" cssClass="am-u-sm-12 am-form-label am-text-left">名称代码：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="nameCode" cssClass="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="nameCode" cssStyle="color: #FF0000;" delimiter=","/><span style="color: #ff0000;">${nameCodeErr}</span>由1到255之间长度的字母、数字、下划线或中划线组成。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="channel_id" class="am-u-sm-12 am-form-label am-text-left">所属频道：</form:label>
                                <div class="am-u-sm-12   am-margin-top-xs">
                                    <form:select path="channel_id" data-am-selected="{btnSize: 'sm'}"  items="${channels}"
                                                 itemLabel="title" itemValue="id">
                                    </form:select>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="type" class="am-u-sm-12 am-form-label am-text-left">类型：</form:label>
                                <div class="am-u-sm-12   am-margin-top-xs">
                                    <form:select path="type" data-am-selected="{btnSize: 'sm'}" items="${types}"
                                                 itemLabel="info" style="display: none;"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label class="am-u-sm-12 am-form-label am-text-left">图标：
                                    <button data-am-modal="{target: '#resourceicons-modal', closeViaDimmer: 0}"
                                            type="button" class="am-btn am-btn-success am-round am-btn-xs">选择图标
                                    </button>
                                </label>
                                <div id="resource-icon"  class="am-u-sm-12   am-margin-top-xs">
                                    <i class="${resource.picicon}"></i>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <form:label path="url" class="am-u-sm-12 am-form-label am-text-left">URL路径：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="url" cssClass="tpl-form-input am-margin-top-xs"/>
                                    <small>请填写URL路径，如：/organization等。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="permission"
                                            class="am-u-sm-12 am-form-label  am-text-left">权限字符串：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="permission" class="am-margin-top-xs"/>
                                    <small>请填写权限字符串，如：user:create、organization:*等。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="dsc" class="am-u-sm-12 am-form-label  am-text-left">描述：</form:label>
                                <div class="am-u-sm-12">
                                    <form:textarea rows="3" path="dsc" class="am-margin-top-xs"/>
                                    <small>相关模块功能描述。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="available"
                                            class="am-u-sm-12 am-form-label  am-text-left">启用</form:label>
                                <div class="am-u-sm-12">
                                    <form:checkbox path="available"
                                                   class="ios-switch bigswitch tpl-switch-btn am-margin-top-xs"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="sort_id" class="am-u-sm-12 am-form-label  am-text-left">序号：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input  path="sort_id" class="am-margin-top-xs"/>
                                    <small><form:errors path="sort_id"><span style="color: #FF0000;">必须填整数，</span></form:errors>请填写整数。</small>
                                </div>
                            </div>


                            <div class="am-form-group">
                                <div class="am-u-sm-12 am-u-sm-push-12">
                                    <form:button
                                            class="am-btn am-btn-primary tpl-btn-bg-color-success">${op}</form:button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="resourceicons-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">系统图标
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-g" id="iconslist">

            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
<script type="text/javascript">
    $(function () {
        $.ajax({
            type: 'POST',
            url: '/sysmanage/resource/seliconsdata',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            data: {},//上线时用：obj.addressComponent.adcode
            dataType: 'json',
            success: function (msgdatas) {
                //alert(JSON.stringify(msgdatas));
                if (msgdatas != null && msgdatas.length > 0)
                    for (var i = 0; i < msgdatas.length; i++) {
                        $('#iconslist').append('<div onclick="setrResIcon(\''+msgdatas[i].iconclass+'\')" style="cursor:pointer;" class="am-u-lg-3 am-u-md-4 am-u-sm-6 '+(i==msgdatas.length-1?"am-u-end":"")+'"><i class="' + msgdatas[i].iconclass + '"></i><br/>'+msgdatas[i].iconname+'</div>');
                    }
            }
        })
    });
    function setrResIcon(resclass)
    {
        $('#picicon').val(resclass);
        $('#resource-icon').html("<i class="+resclass+"></i>");
        var resicon=$('#resourceicons-modal');
        resicon.modal('close');
    }
</script>
</body>

</html>
