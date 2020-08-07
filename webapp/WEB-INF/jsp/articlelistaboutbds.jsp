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
<div class="body-width" id="data_list">
    <c:if test="${!''.equals(category.subTitle)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">${category.subTitle}</div>
            </div>
        </div>
    </c:if>
    <div class="row row-cols-1" v-for="item in caselist">
        <div class="col mt-5">
            <a :target="item.link_url==''?'_self':'_blank'"
               :href="item.link_url==''?'/indexitem/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                <img :src="item.img_url" class="img-fluid" alt="Responsive image">
                <div class="row  row-cols-1 txtoverlaybig text-center">
                    <div class="col text-bds-titlebig">{{item.title}}</div>
                    <div class="col text-bds-subtitlebig">{{item.subTitle}}</div>
                </div>
            </a>
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
<script type="text/javascript">
    caseshow('#data_list', 1, 51, '${cid}', '${channelid}');
</script>
</body>
</html>
