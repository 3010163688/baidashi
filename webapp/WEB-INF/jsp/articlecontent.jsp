<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-07-09
  Time: 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<html>
<head>
    <jsp:include page="/inc/headincludesfiles"/>
</head>
<body>
<jsp:include page="/inc/mainmenus"/>
<div class="body-width" id="data_list">
    <c:if test="${!''.equals(articleData.articleWithBLOBs.title)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">${articleData.articleWithBLOBs.title}</div>
            </div>
        </div>
    </c:if>
    <div class="row row-cols-1" v-for="item in caselist">
        <div class="col ck-content mt-5">
            ${articleData.articleWithBLOBs.contents}
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
</body>
</html>
