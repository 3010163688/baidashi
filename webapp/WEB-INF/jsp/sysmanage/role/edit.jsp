<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
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
                        <form:form class="am-form tpl-form-border-form" method="post" modelAttribute="role">
                            <form:hidden path="id"/>

                            <div class="am-form-group">
                                <form:label path="role" class="am-u-sm-12 am-form-label am-text-left">角色名：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="role"/>
                                    <small><form:errors path="role" cssStyle="color: #FF0000;" delimiter=","/>由1到20个字母、数字、下划线、中划线或#组成 。</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="description" class="am-u-sm-12 am-form-label am-text-left">角色描述：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs" path="description"/>
                                    <small></small>
                                </div>
                            </div>


                            <div class="am-form-group">
                                <form:label path="resourceIds"  class="am-u-sm-12 am-form-label am-text-left">拥有的资源列表：</form:label>
                                <form:hidden path="resourceIds"/>
                                <div class="am-u-sm-12">
                                <input class="tpl-form-input am-margin-top-xs" type="text" id="resourceName" name="resourceName" value="${zhangfn:resourceNames(role.resourceIds1)}" readonly>
                                    <small><a style="margin-top: 5px;" class="am-btn am-btn-warning am-round am-btn-sm" id="menuBtn" href="#">选择</a>
                                        <form:errors path="resourceIds" cssStyle="color: #FF0000;" delimiter=","/>至少要选择一个资源。</small>
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
                                <div class="am-u-sm-12 am-u-sm-push-12">
                                    <form:button
                                            class="am-btn am-btn-primary tpl-btn-bg-color-success ">${op}</form:button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 9999999;">
    <ul id="tree" class="ztree" style="margin-top:0; width:160px;"></ul>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
<script src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.all-3.5.min.js"></script>
<script>
    $(function () {
        var setting = {
            check: {
                enable: true ,
                chkboxType: { "Y": "", "N": "" }
            },
            view: {
                dblClickExpand: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onCheck: onCheck
            }
        };

        var zNodes =[
            <c:forEach items="${resourceList}" var="r">
            <c:if test="${r.rootNode}">
            { id:${r.id}, pId:${r.parentId}, name:"${r.name}", checked:${zhangfn:in(role.resourceIds1, r.id)},nocheck:true},
            </c:if>
            <c:if test="${not r.rootNode}">
            { id:${r.id}, pId:${r.parentId}, name:"${r.name}", checked:${zhangfn:in(role.resourceIds1, r.id)}},
            </c:if>
            </c:forEach>
        ];

        function onCheck(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree"),
                nodes = zTree.getCheckedNodes(true),
                id = "",
                name = "";
            nodes.sort(function compare(a,b){return a.id-b.id;});
            for (var i=0, l=nodes.length; i<l; i++) {
                id += nodes[i].id + ",";
                name += nodes[i].name + ",";
            }
            if (id.length > 0 ) id = id.substring(0, id.length-1);
            if (name.length > 0 ) name = name.substring(0, name.length-1);
            $("#resourceIds").val(id);
            $("#resourceName").val(name);
//                hideMenu();
        }

        function showMenu() {
            var cityObj = $("#resourceName");
            var cityOffset = $("#resourceName").offset();
            $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

            $("body").bind("mousedown", onBodyDown);
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                hideMenu();
            }
        }

        $.fn.zTree.init($("#tree"), setting, zNodes);
        $("#menuBtn").click(showMenu);
    });
</script>
</body>

</html>
