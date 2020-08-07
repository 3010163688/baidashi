
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-06-20
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css">
    <style>
        ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:200px;overflow-y:scroll;overflow-x:auto;}
    </style>
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
                        <form:form class="am-form tpl-form-border-form" method="post" modelAttribute="channel">
                            <form:hidden path="id"/>

                            <div class="am-form-group">
                                <form:label path="name" class="am-u-sm-12 am-form-label am-text-left">调用名称：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="name"/>
                                    <small><form:errors path="name" cssStyle="color: #FF0000;" delimiter=","/>调用名称，只允许使用英文、数字或下划线。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="title" class="am-u-sm-12 am-form-label am-text-left">频道标题：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="title"/>
                                    <small><form:errors path="title" cssStyle="color: #FF0000;" delimiter=","/>标题备注，允许中文。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="site_id" class="am-u-sm-12 am-form-label am-text-left">所属站点：</form:label>
                                <div class="am-u-sm-12   am-margin-top-xs">
                                    <form:select path="site_id" data-am-selected="{btnSize: 'sm'}" items="${itofweb}"
                                                 itemLabel="title" itemValue="id"  style="display: none;"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="sort_id" class="am-u-sm-12 am-form-label am-text-left">序号：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="sort_id"/>
                                    <small><form:errors path="sort_id" cssStyle="color: #FF0000;" delimiter=","><span style="color: #FF0000;">填写有误，</span></form:errors>请填写大于或等于0的整数，数字越小越向前。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="limitShowLevels" class="am-u-sm-12 am-form-label am-text-left">类别控制参数：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="limitShowLevels"/>
                                    <small><form:errors path="limitShowLevels" cssStyle="color: #FF0000;" delimiter=","><span style="color: #FF0000;">填写有误，</span></form:errors>请填写格式为："1,4,5,7,1,1,1,1,1,1,5,6,8,0,3"格式内容，分别为："顶级类添加,子级类添加开始层,子级类修改开始层,子级类删除开始层,类别显示状态(0或1),类别推荐类型(0或1),内容记录添加(0或1),内容显示状态(0或1),内容推荐类型(0或1),当前记录操作管理(0或1),子级类添加结束层,子级类修改结束层,子级类删除结束层,类别复制开始层,类别复制结束层"。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="is_albums" cssClass="am-u-sm-12 am-form-label am-text-left">开启相册：</form:label>
                                <div class="am-u-sm-12 am-margin-top-xs">
                                    <form:checkbox  path="is_albums"  data-on-color="success" data-off-color="default" data-off-text="关"   data-on-text="开" data-size="xs"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="is_attach" cssClass="am-u-sm-12 am-form-label am-text-left">开启附件：</form:label>
                                <div class="am-u-sm-12 am-margin-top-xs">
                                    <form:checkbox  path="is_attach"  data-on-color="success" data-off-color="default" data-off-text="关"   data-on-text="开" data-size="xs"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="is_spec" cssClass="am-u-sm-12 am-form-label am-text-left">开启规格：</form:label>
                                <div class="am-u-sm-12 am-margin-top-xs">
                                    <form:checkbox  path="is_spec"  data-on-color="success" data-off-color="default" data-off-text="关"   data-on-text="开" data-size="xs"/>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <div class="am-u-sm-12 am-u-sm-push-12">
                                    <form:button
                                            class="am-btn am-btn-primary tpl-btn-bg-color-success ">保存</form:button>
                                </div>
                            </div>
                        </form:form>
                        <script type="text/javascript">
                            $(function() {
                                $('[type="checkbox"]').bootstrapSwitch();
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
