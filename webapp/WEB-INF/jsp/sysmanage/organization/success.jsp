<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
</head>
<body>
<a href="${pageContext.request.contextPath}/sysmanage/organization?p=${p}" target="_parent"><span id="sp"></span></a>
    <form:form id="tourl" method="get" action="">

    </form:form>
<script type="text/javascript">
    $(function(){
        $("#sp").trigger("click");
    });
</script>
</body>
</html>
