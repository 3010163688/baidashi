<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-04-22
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav aria-label="breadcrumb">
    <i class="fa fa-home" aria-hidden="true"></i> <a href="/">首页</a>
        <c:forEach items="${categorypath}" var="rec">
            <i class="fa fa-angle-double-right" aria-hidden="true"></i> <a href="/${pageth}?cid=${rec.id}&channelid=${rec.channel_id}&p=${rec.class_list}${rec.id}">${rec.title}</a>
        </c:forEach>
</nav>
