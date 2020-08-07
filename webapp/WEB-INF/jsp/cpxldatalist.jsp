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
    <c:if test="${'2212'.equals(ty)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">热销产品</div>
            </div>
        </div>
    </c:if>
    <c:if test="${'2221'.equals(ty)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">品牌精选</div>
            </div>
        </div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 text-center my-5">
        <c:forEach items="${newsList.list}" var="item">
            <div class="col py-5" style="background: #fff;border: 1px #050301 solid;">
                <a
                        <c:choose>
                            <c:when test="${item.link_url!=null&&!''.equals(item.link_url.trim())}">
                                target="_blank"
                                href="${item.link_url}"
                            </c:when>
                            <c:otherwise>
                                href='/xlcpdetails/${item.id}?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}'
                            </c:otherwise>
                        </c:choose>
                >
                <img class="mb-5 pb-5" src="${zhangfn:articleImgUrl(item.img_url)}"/>
                <div class="row row-cols-1 txtoverlay-p-b">
                    <div class="col text-bds-subtitle-p1">${item.title}</div>
                    <div class="col mt-2"><img src="/static/imgs/btntmall.png"/></div>
                </div>
                </a>
            </div>
        </c:forEach>
    </div>
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center ">
            <li class="page-item ${newsList.hasPreviousPage?"":"disabled"}">
                <a class="page-link"
                   href="/cpxldatalist?cp=${newsList.pageNum-1}&cid=${cid}&pid=4&picid=4&p=0/4&channelid=6&ut=cpxldatalist&ty=${ty}"
                   tabindex="-1" ${newsList.hasPreviousPage?"":"aria-disabled=\"true\""}>上一页</a>
            </li>
            <c:forEach items="${newsList.navigatepageNums}" var="item">
                <li class="page-item ${newsList.pageNum==item?"disabled":""}">
                    <a href="/cpxldatalist?cp=${item}&cid=${cid}&pid=4&picid=4&p=0/4&channelid=6&ut=cpxldatalist&ty=${ty}"
                       class="page-link">${item}</a>
                </li>
            </c:forEach>
            <li class="page-item  ${newsList.hasNextPage?"":"disabled"}">
                <a class="page-link"
                   href="/cpxldatalist?cp=${newsList.pageNum+1}&cid=${cid}&pid=4&picid=4&p=0/4&channelid=6&ut=cpxldatalist&ty=${ty}">下一页</a>
            </li>
        </ul>
    </nav>
</div>
<jsp:include page="/inc/footer"/>
</body>
</html>
