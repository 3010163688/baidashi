<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <div class="am-u-sm-12 widget-body  widget-body-lg am-fr">
                    <form:form class="am-form tpl-form-border-form"
                               method="post"
                               modelAttribute="article">
                        <div class="am-u-sm-12 am-u-md-6 am-u-lg-6">
                            <div class="am-form-group">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-sm">
                                        <a style="display: ${aadd!=1?"none":""};" href="${pageContext.request.contextPath}/sysmanage/webmanage/products/0/add/articleedit?p=${p}&channelid=${channelid}"
                                           class="am-btn am-btn-default am-btn-success"><span
                                                class="am-icon-plus"></span>
                                            新增</a>
                                        <a href="/sysmanage/webmanage/products/article_list?p=${p}&channelid=${channelid}"
                                           class="am-btn am-btn-secondary"><span class="am-icon-th">&nbsp;</span>显示全部</a>
                                    </div>
                                    <div class="am-btn-group am-btn-group-sm">
                                        <a href="/sysmanage/webmanage/products/list/setvt?p=${p}&channelid=${channelid}"
                                           class="am-btn am-btn-warning"><span class="am-icon-th-list">&nbsp;</span>文字列表</a>
                                        <a href="/sysmanage/webmanage/products/img/setvt?p=${p}&channelid=${channelid}"
                                           class="am-btn am-btn-primary"><span class="am-icon-th-large">&nbsp;</span>图片列表</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
                            <div class="am-form-group tpl-table-list-select">
                                <form:select path="category_id"
                                             data-am-selected="{btnSize: 'sm',maxHeight: 300}"
                                             items="${articleCategoryList}"
                                             itemLabel="title"
                                             itemValue="id"
                                             style="display: none;"/>
                            </div>
                        </div>
                        <div class="am-u-sm-12 am-u-md-12 am-u-lg-3">
                            <div class="am-input-group  am-input-group-sm tpl-form-border-form cl-p">
                                <form:input path="title" class="am-form-field"/>
                                <span class="am-input-group-btn">
            <form:button class="am-btn  am-btn-default am-btn-success tpl-table-list-field am-icon-search"></form:button>
                      </span>
                            </div>
                        </div>

                    </form:form>
                    <c:if test="${not empty msg}">
                        <div class="message">${msg}</div>
                    </c:if>
                    <c:if test="${not 'img'.equals(viewType)}">
                        <table id="table"
                               class="am-u-sm-12 am-table am-table-bordered am-table-radius am-table-striped am-table-hover">
                            <thead>
                            <tr>
                                <th>标题</th>
                                <th>所属类别</th>
                                <th>发布时间</th>
                                <th>排序</th>
                                <th>操作</th>
                                <th>备注</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dataList.list}" var="rec">
                                <c:set var="__lrop" value="${rec.localRecOP==null||''.equals(rec.localRecOP.trim())||rec.localRecOP.trim().length()!=10?'1111110100':rec.localRecOP.trim()}"/>
                                <tr data-tt-id='${rec.id}'>
                                    <td>${rec.title}</td>
                                    <td>${rec.category_title}</td>
                                    <td><fmt:formatDate value="${rec.add_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${rec.sort_id}</td>
                                    <td>
                                        <c:if test="${'1'.equals(__lrop.substring(0,1))}">
                                            <a class="deleteBtn" href="#" data-id="${rec.id}">删除</a>
                                        </c:if>
                                        <a  style="display: ${'0'.equals(__lrop.substring(2,3))?"none":""};"  href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}&action=copy">复制</a>
                                        <c:if test="${'1'.equals(__lrop.substring(1,2))}">
                                        <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}">修改</a>
                                        </c:if>
                                        <c:if test="${'1'.equals(__lrop.substring(3,4))}">
                                            <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}">查看</a>
                                        </c:if>
                                    </td>
                                    <td>${rec.remarks}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${'img'.equals(viewType)}">
                        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2
  am-avg-md-4 am-avg-lg-5 am-gallery-bordered" data-am-gallery="{pureview: true}">
                            <c:forEach items="${dataList.list}" var="rec">
                                <c:set var="__lrop" value="${rec.localRecOP==null||''.equals(rec.localRecOP.trim())||rec.localRecOP.trim().length()!=12?'111111010100':rec.localRecOP.trim()}"/>
                                <li>
                                    <div class="am-gallery-item">
                                        <a href="${zhangfn:articleImgUrl(rec.img_url)}" class="">
                                            <img src="${zhangfn:articleImgUrl(rec.img_url)}"
                                                 alt="${rec.title}"/>
                                            <h3 class="am-gallery-title">${rec.title}</h3>
                                        </a>
                                        <div class="am-gallery-desc">
                                            <fmt:formatDate value="${rec.add_time}" pattern="yyyy-MM-dd"/>
                                            <div class="am-fr">
                                                <c:if test="${'1'.equals(__lrop.substring(0,1))}">
                                                    <a class="deleteBtn" href="#" data-id="${rec.id}">删除</a>
                                                </c:if>
                                                <c:if test="${'1'.equals(__lrop.substring(1,2))}">
                                                <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}">修改</a>
                                                </c:if>
                                                <a  style="display: ${'0'.equals(__lrop.substring(2,3))?"none":""};"  href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}&action=copy">复制</a>
                                                <c:if test="${'1'.equals(__lrop.substring(3,4))}">
                                                    <a href="${pageContext.request.contextPath}/sysmanage/webmanage/products/${rec.id}/edit/articleedit?p=${p}&channelid=${channelid}">查看</a>
                                                </c:if>
                                            </div>

                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>

                    </c:if>
                    <div class="am-u-sm-12">
                        <ul class="am-pagination am-pagination-centered">
                            <li <c:if test="${!dataList.hasPreviousPage}"> class="am-disabled" </c:if>>
                                <a href="/sysmanage/webmanage/products/article_list?currenPage=${dataList.pageNum-1}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">&laquo;</a>
                            </li>
                            <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
                            <c:forEach items="${dataList.navigatepageNums}" var="page_num">
                                <c:if test="${page_num == dataList.pageNum}">
                                    <li class="am-active">
                                        <a href="#">${page_num}</a>
                                    </li>
                                </c:if>
                                <c:if test="${page_num != dataList.pageNum}">
                                    <li>
                                        <a href="/sysmanage/webmanage/products/article_list?currenPage=${page_num}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">${page_num}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <li  <c:if test="${!dataList.hasNextPage}"> class="am-disabled" </c:if>>
                                <a href="/sysmanage/webmanage/products/article_list?currenPage=${dataList.pageNum+1}&size=${dataList.pageSize}&p=${p}&channelid=${channelid}">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
<script>
    $(function () {
        $("#table").treetable({
            expandable: true,
            initialState: "expanded",
            clickableNodeNames: true,//点击节点名称也打开子节点.
            indent: 30//每个分支缩进的像素数。
        });
    });
    $(".deleteBtn").click(function () {
        //alert($(this).parent().parent().attr('data-tt-parent-id'));
        //alert($(this).data("id"));
        if (confirm("确认删除吗?")) {
            location.href = "${pageContext.request.contextPath}/sysmanage/webmanage/products/" + $(this).data("id") + "/articledelete?p=${p}&channelid=${channelid}";
        }
    });
</script>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
</body>

</html>
