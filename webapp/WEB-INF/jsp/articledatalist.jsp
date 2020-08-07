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
    <c:if test="${!''.equals(category.subTitle)}">
        <div class="row row-cols-1">
            <div class="col mt-5">
                <div class="col text-bds-subtitlebig text-center">${category.subTitle}</div>
            </div>
        </div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 mt-5">
        <c:forEach items="${newsList.list}" var="item">
            <div class="col mb-4">
                <div class="card border-0 h-100 shadow">
                    <div class="row no-gutters p-2">
                        <div class="col-md-4">
                            <a
                                    <c:choose>
                                        <c:when test="${item.link_url!=null&&!''.equals(item.link_url.trim())}">
                                            target="_blank"
                                            href="${item.link_url}"
                                        </c:when>
                                        <c:otherwise>
                                            href='/newdetails/${item.id}?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}'
                                        </c:otherwise>
                                    </c:choose>
                            >
                                <img src="${zhangfn:articleImgUrl(item.img_url)}" class="card-img" alt="${item.title}">
                            </a>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body pt-1">
                                <h5 class="card-title text-center  h5 font-weight-bold border-bottom pb-3 line-20"><a
                                        class="text-black-50"
                                        <c:choose>
                                            <c:when test="${item.link_url!=null&&!''.equals(item.link_url.trim())}">
                                                target="_blank"
                                                href="${item.link_url}"
                                            </c:when>
                                            <c:otherwise>
                                                href='/newdetails/${item.id}?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}'
                                            </c:otherwise>
                                        </c:choose>
                                >${item.title}</a>
                                </h5>
                                <p class="card-text"><a class="text-secondary"
                                        <c:choose>
                                            <c:when test="${item.link_url!=null&&!''.equals(item.link_url.trim())}">
                                                target="_blank"
                                                href="${item.link_url}"
                                            </c:when>
                                            <c:otherwise>
                                                href='/newdetails/${item.id}?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}'
                                            </c:otherwise>
                                        </c:choose>
                                >${item.zhaiyao}</a>
                                </p>
                            </div>
                            <div class="card-footer text-right border-0 bg-transparent pt-0">
                                <small class="text-muted">2020-04-22</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center ">
            <li class="page-item ${newsList.hasPreviousPage?"":"disabled"}">
                <a class="page-link" href="/articledatalist?cp=${newsList.pageNum-1}&cid=${cid}&pid=25&picid=180&p=0/25&channelid=11&ut=articledatalist" tabindex="-1" ${newsList.hasPreviousPage?"":"aria-disabled=\"true\""}>上一页</a>
            </li>
            <c:forEach items="${newsList.navigatepageNums}" var="item">
                <li class="page-item ${newsList.pageNum==item?"disabled":""}">
                    <a href="/articledatalist?cp=${item}&cid=${cid}&pid=25&picid=180&p=0/25&channelid=11&ut=articledatalist"
                       class="page-link">${item}</a>
                </li>
            </c:forEach>
            <li class="page-item  ${newsList.hasNextPage?"":"disabled"}">
                <a class="page-link" href="/articledatalist?cp=${newsList.pageNum+1}&cid=${cid}&pid=25&picid=180&p=0/25&channelid=11&ut=articledatalist">下一页</a>
            </li>
        </ul>
    </nav>
</div>
<jsp:include page="/inc/footer"/>
</body>
</html>
