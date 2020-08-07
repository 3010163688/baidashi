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
<body>
<div class="am-g tpl-g">
    <form:form id="form" class="am-form tpl-form-border-form" method="post" modelAttribute="organizationMove">
        <fieldset>
            <div class="am-form-group">
                <label class="am-u-sm-12 am-form-label am-text-left">源节点名称：</label>
                <div class="am-u-sm-12">
                    <form:hidden path="sourceId"/>
                    <form:input path="sourceName" type="text" Class="tpl-form-input am-margin-top-xs"/>
                    <form:errors path="sourceId" cssStyle="color: #ff0000" delimiter=","/>
                    <form:errors path="sourceName" cssStyle="color: #ff0000" delimiter=","/>
                </div>
            </div>

            <div class="am-form-group">
                <label class="am-u-sm-12 am-form-label am-text-left">目标节点名称：</label>
                <div class="am-u-sm-12">
                    <form:input path="targetName" type="text" Class="tpl-form-input am-margin-top-xs" readonly="true"/>
                    <form:hidden path="targetId"/>
                    <form:errors path="targetId" cssStyle="color: #ff0000" delimiter=","/>
                    <form:errors path="targetName" cssStyle="color: #ff0000" delimiter=","/>
                    <a id="menuBtn" href="#">选择</a>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-12 am-u-sm-push-12" style="margin-top: 10px;">
                    <form:button class="am-btn am-btn-primary tpl-btn-bg-color-success ">移动</form:button>
                </div>
            </div>
        </fieldset>
    </form:form>

    <div id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99999999;">
        <ul id="tree" class="ztree" style="margin-top:0; width:160px;"></ul>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>
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
            <c:forEach items="${targetList}" var="o">
            {id:${o.id}, pId:${o.parentId}, name: "${o.name}", open:${o.rootNode}},
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
            $("#targetId").val(id);
            $("#targetName").val(name);
            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#targetName");
            var cityOffset = $("#targetName").offset();
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
    //注意：下面的代码是放在iframe引用的子页面中调用
    $(window.parent.document).find("#orgframe").load(function () {
        var main = $(window.parent.document).find("#orgframe");
        var thisheight = $(document).height();
        main.height(thisheight);
    });
</script>
</body>
</html>
