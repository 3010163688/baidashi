<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-24
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="modalwintip" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">{{title}}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body"  v-html="tipcontent">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="preloader">
    <img src="/static/assets/gifs/2.gif" alt="Pre-loader">
</div>
<div class="header" id="app_header_logo">
    <div class="box clear">
        <a href="/" class="logo"> <img :src="pic" :alt="subTitle"> </a>
        <div class="cd" style="display: block">
            <span></span>
            <span></span>
        </div>
    </div>
</div>
<div class="menu" id="app_menu_logo">
    <div class="box clear">
        <a href="/" class="logo">
            <img :src="pic" :alt="subTitle">
        </a>
        <div class="gb">
            <img src="/resources/hzvis/static/sj/img/gb.png" alt="">
        </div>
    </div>
    <div class="menu_list">
        <ul>
            <li><a href="/">我的首页</a></li>
            <li><a href="/#aboutus">关于我们</a></li>
            <li><a href="/case">案例资料</a></li>
            <li><a href="/news">行业动态</a></li>
            <li><a href="/designnews">设计资讯</a></li>
            <li><a href="/contact">联系我们</a></li>
        </ul>
    </div>
</div>
