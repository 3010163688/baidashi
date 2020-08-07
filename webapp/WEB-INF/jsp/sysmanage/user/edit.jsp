<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css">
    <style>
        ul.ztree {
            margin-top: 10px;
            border: 1px solid #617775;
            background: #f0f6e4;
            width: 220px;
            height: 200px;
            overflow-y: scroll;
            overflow-x: auto;
        }
    </style>
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
            <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                <div class="widget am-cf">
                    <div class="widget-body am-fr">
                        <c:if test="${not empty msg}">
                            <div class="message">${msg}</div>
                        </c:if>
                        <form:form class="am-form tpl-form-border-form" method="post" modelAttribute="user1">
                            <form:hidden path="id"/>
                            <form:hidden path="salt"/>
                            <form:hidden path="locked"/>
                            <form:hidden path="headicon"/>
                            <c:if test="${op ne '新增'}">
                                <form:hidden path="password"/>
                            </c:if>

                            <div class="am-form-group">
                                <form:label path="username"
                                            class="am-u-sm-12 am-form-label am-text-left">用户名*：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs"
                                                path="username"
                                                readonly="${op ne '新增'}"/>
                                    <small><form:errors cssStyle="color: #ff0000" delimiter="," path="username"/>
                                        用户名由长度在3到20之间长度的英文字符组！
                                    </small>
                                </div>
                            </div>

                            <c:if test="${op eq '新增'}">
                                <div class="am-form-group">
                                    <form:label path="password"
                                                class="am-u-sm-12 am-form-label am-text-left">密码*：</form:label>
                                    <div class="am-u-sm-12">
                                        <form:input class="tpl-form-input am-margin-top-xs" path="password"/>
                                        <small><form:errors cssStyle="color: #ff0000" delimiter="," path="password"/>密码由长度在6个以上的英文字符组成！</small>
                                    </div>
                                </div>
                            </c:if>

                            <div class="am-form-group">
                                <form:label path="email">邮箱：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="email" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="email" cssStyle="color: #FF0000;" delimiter=","/>
                                        填写常用邮箱，可用于登录或找回密码。
                                    </small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="mobilephone">手机：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="mobilephone" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="mobilephone" cssStyle="color: #FF0000;" delimiter=","/>
                                        填写常用手机，可用于密码或找回密码等。
                                    </small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="nickname">呢称：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="nickname" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="nickname"
                                                        cssStyle="color: #FF0000;"
                                                        delimiter=","/></small>
                                </div>
                            </div>
                            <c:if test="${user1.username ne null and not ''.equals(username)}">
                                <div class="am-form-group">
                                    <form:label path="headicon">头像：</form:label>
                                    <div class="am-u-sm-12">
                                        <small><form:errors path="headicon"
                                                            cssStyle="color: #FF0000;"
                                                            delimiter=","/></small>
                                        <div class="up-box">
                                            <div class="up-imgFileUploade">
                                                <div class="imgAll">
                                                    <div class="header" style="display: none;">
                                                        <span class="imgTitle"> 头像图片：</span>
                                                    </div>
                                                    <ul id="headPicList">
                                                        <input type="file"
                                                               name=""
                                                               id="upimages009"
                                                               class="imgFiles"
                                                               style="display: none;"
                                                               accept="image/*"/>
                                                        <li class="imgClick">
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <div class="am-form-group">
                                <form:label path="organizationId">所属组织：</form:label>
                                <form:hidden path="organizationId"/>
                                <div class="am-u-sm-12">
                                    <input class="tpl-form-input am-margin-top-xs"
                                           type="text"
                                           id="organizationName"
                                           name="organizationName"
                                           value="${zhangfn:organizationName(user1.organizationId)}"
                                           readonly>
                                    <small><a style="margin-top: 5px;"
                                              class="am-btn am-btn-warning am-round am-btn-sm"
                                              id="menuBtn">选择</a></small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="roleIds1"
                                            class="am-u-sm-12 am-form-label am-text-left">角色列表*：</form:label>
                                <div class="am-u-sm-12   am-margin-top-xs">
                                    <form:select path="roleIds1"
                                                 items="${roleList}"
                                                 itemLabel="description"
                                                 itemValue="id"
                                                 multiple="true"/>
                                    <small>(按住shift键多选)<form:errors cssStyle="color: #ff0000"
                                                                    delimiter=","
                                                                    path="roleIds1"/></small>
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
            view: {
                dblClickExpand: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: onClick
            }
        };

        var zNodes = [
            <c:forEach items="${organizationList}" var="o">
            <c:if test="${not o.rootNode}">
            {id:${o.id}, pId:${o.parentId}, name: "${o.name}"},
            </c:if>
            </c:forEach>
        ];

        function onClick(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree"),
                nodes = zTree.getSelectedNodes(),
                id = "",
                name = "";
            nodes.sort(function compare(a, b) {
                return a.id - b.id;
            });
            for (var i = 0, l = nodes.length; i < l; i++) {
                id += nodes[i].id + ",";
                name += nodes[i].name + ",";
            }
            if (id.length > 0) id = id.substring(0, id.length - 1);
            if (name.length > 0) name = name.substring(0, name.length - 1);
            $("#organizationId").val(id);
            $("#organizationName").val(name);
            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#organizationName");
            var cityOffset = $("#organizationName").offset();
            $("#menuContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");

            $("body").bind("mousedown", onBodyDown);
        }

        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }

        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu();
            }
        }

        $.fn.zTree.init($("#tree"), setting, zNodes);
        $("#menuBtn").click(showMenu);
    });
</script>
<script type="text/javascript">
    $("#upimages009").attr("savepath", "headPics");
    $("#upimages009").attr("unum", 1);
    $("#upimages009").attr("oid", "headicon");
    $("#upimages009").attr("uid", '${user1.username}');
    var up_upFiles =${hps==null or "".equals(hps)?[]:hps};
</script>
<script src="/static/js/upload.js"></script>
</body>
</html>
