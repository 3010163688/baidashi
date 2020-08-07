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
                    <table id="table">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${organizationList}" var="org">
                            <tr data-tt-id='${org.id}'
                                    <c:if test="${not org.rootNode}"> data-tt-parent-id='${org.parentId}'</c:if>>
                                <td>${org.name}</td>
                                <td>
                                    <shiro:hasPermission name="sys:*:organization">
                                        <a onclick="editOrgForm('${org.name}',${org.id},'${pageContext.request.contextPath}/sysmanage/organization/${org.id}/maintain?p=${p}')">编辑</a>
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
<div class="am-modal am-modal-no-btn" tabindex="-1" id="editorgform-modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><span id="modaltitle"></span>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd " id="cpwbd">

        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
<script src="${pageContext.request.contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
<script>
    $(function () {
        $("#table").treetable({expandable: true}).treetable("expandNode", 1);
    });
    function editOrgForm(orgname,orgid,url)
    {
        var eof=$('#editorgform-modal');
        $('#modaltitle').html('['+orgname+']节点编辑');
        $('#cpwbd').html('<iframe id="orgframe" style="width: 100%;height: 100%;" frameborder="0" scrolling="auto" src="'+url+'"></iframe>');
        eof.modal('open');
    }
</script>
</body>

</html>
