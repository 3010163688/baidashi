<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-07-09
  Time: 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/inc/headincludesfiles"/>
</head>
<body>
<jsp:include page="/inc/mainmenus"/>
<div class="body-width">
    <c:if test="${!''.equals(categoryData.articleCategoryWithBLOBs.subTitle)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">${categoryData.articleCategoryWithBLOBs.subTitle}</div>
            </div>
        </div>
    </c:if>
    <div class="row row-cols-1  mt-5">
        <div class="col mt-5 ck-content" >
${categoryData.articleCategoryWithBLOBs.content}
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
</body>
</html>
