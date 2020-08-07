<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-11
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="xmjrkj" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<style>
    /*PRE LOADER*/
    .preloader {
        background-color: #ffffff;
        position: fixed;
        z-index: 999999;
        height: 100vh;
        width: 100%;
        top: 0;
        left: 0;
    }

    .preloader img {
        position: absolute;
        top: 50%;
        left: 50%;
        text-align: center;
        -webkit-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
    }
</style>
<div class="preloader">
    <img src="/static/assets/gifs/2.gif" alt="Pre-loader">
</div>
<div class="container-fluid body-width p-0" style="height: 103px;background: #73503c;">
    <nav class="navbar navbar-expand-lg navbar-light"
         style="background: #73503c; z-index: 100000!important;">
        <button class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target="#navbarTogglerDemo03"
                aria-controls="navbarTogglerDemo03"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="/">
            <img src="${logoPath}"/>
        </a>

        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
            <ul class="navbar-nav mx-auto mt-2 mt-lg-0">
                <li class="nav-item mx-3 h5">
                    <a class="nav-link ${"185".equals(pid)?"text-menuitem-active":"text-menuitem"}"
                       href="/?cid=185&pid=185&picid=179&p=0/185&channelid=9&ut=articlelistaboutbds">关于白大师</a>
                </li>
                <li class="nav-item mx-3  h5">
                    <a class="nav-link ${"4".equals(pid)?"text-menuitem-active":"text-menuitem"}"
                       href="/xlcp?cid=4&pid=4&picid=178&p=0/4&channelid=6&ut=categorydetails">系列产品</a>
                </li>
                <li class="nav-item mx-3  h5">
                    <a class="nav-link ${"25".equals(pid)?"text-menuitem-active":"text-menuitem"}"
                       href="/articledatalist?cid=25&pid=25&picid=180&p=0/25&channelid=11&ut=articledatalist">品牌资讯</a>
                </li>
                <li class="nav-item mx-3  h5">
                    <a class="nav-link ${"209".equals(pid)?"text-menuitem-active":"text-menuitem"}"
                       href="/attract?cid=209&pid=209&picid=181&p=0/209&channelid=12&ut=categorydetails">招商</a>
                </li>
                <li class="nav-item mx-3  h5">
                    <a class="nav-link ${"207".equals(pid)?"text-menuitem-active":"text-menuitem"}"
                       href="/categorydetails?cid=207&pid=207&picid=208&p=0/207&channelid=13&ut=categorydetails">私人定制</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <a href="${tmShop.link_url}" target="_blank"><img src="${xmjrkj:articleImgUrl(tmShop.img_url)}" class="mr-5 img-fluid my-3"/></a>
                <a href="${jdShop.link_url}" target="_blank"><img src="${xmjrkj:articleImgUrl(jdShop.img_url)}" class="mr-5 img-fluid my-3"/></a>
                <a href="${kf.link_url}" title="${kf.link_url}" target="_blank"><img src="${xmjrkj:articleImgUrl(kf.img_url)}" class="my-2 my-sm-0"/></a>
            </form>
        </div>
    </nav>
</div>
<c:if test="${issubmenu}">
    <div class="sticky-top body-width p-0" style="background: rgba(50,50,50,0.6);">
        <div class="d-flex flex-wrap  justify-content-end text-menuitem">
            <c:forEach items="${submenulist}" var="rec">
                <div class="p-2 bd-highlight mx-2 h6">
                    <a class=" ${rec.id.toString().equals(cid)?"text-menuitem-active":"text-menuitem"}"
                       href="/${ut}?cid=${rec.id}&pid=${pid}&picid=${rec.id}&p=0/185/${rec.id}&channelid=${channelid}&ut=${ut}">${rec.title}</a>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<c:if test="${pictranList!=null&&pictranList.size()>=1}">
    <div class="body-width p-0">
        <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
            <c:if test="${pictranList.size()>1}">
                <ol class="carousel-indicators">
                    <c:forEach items="${pictranList}" var="rec" varStatus="recStatus">
                        <li data-target="#carouselExampleCaptions" data-slide-to="${recStatus.index}"
                                <c:if test="${recStatus.index==0}"> class="active"</c:if>></li>
                    </c:forEach>
                </ol>
            </c:if>
            <div class="carousel-inner">
                <c:forEach items="${pictranList}" var="rec" varStatus="recStatus">
                    <div class="carousel-item <c:if test="${recStatus.index==0}">active</c:if>">
                        <img src="${rec}" class="d-block w-100" alt="...">
                            <%--                    <div class="carousel-caption d-none d-md-block">--%>
                            <%--                        <h5 class="text-white">First slide label</h5>--%>
                            <%--                        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>--%>
                            <%--                    </div>--%>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${pictranList.size()>1}">
                <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </c:if>
        </div>
    </div>
    <div class="body-width my-1 border-dds-top mt-5 p-0"></div>
</c:if>
