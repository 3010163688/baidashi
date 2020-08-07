<%@page pageEncoding="UTF-8"%>
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/static/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/amazeui.datetimepicker.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/app.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/amazeui.switch.css" />
<script src="${pageContext.request.contextPath}/static/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/amazeui.switch.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/amazeui.datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/js/locales/amazeui.datetimepicker.zh-CN.js"></script>
<script  src="${pageContext.request.contextPath}/static/js/vue.min.js"></script>
<style>
    a{
        cursor: pointer;
    }
    /*上传组件样式开始*/
    .up-box {
        width: 100%;
        clear: both;
        display: block;
    }

    .up-imgFileUploade {
        width: 100%;
    }

    .up-imgFileUploade .header {
        height: 50px;
        width: 100%;
        line-height: 50px;
        clear: both;
    }

    .up-imgFileUploade .header span {
        display: block;
        float: left;
    }

    .up-imgFileUploade .header span.imgTitle {
        line-height: 50px;
        color: #999999;
    }

    .up-imgFileUploade .imgAll span {
        display: block;
        float: left;
    }

    .up-imgFileUploade .imgAll .imgClick {
        border:none;
        width: 48px;
        height: 48px;
        margin: 8px 5px;
        cursor: pointer;
        background: url(/static/imgs/uploaderimgs/addpics.png) no-repeat center center;
        background-size: cover;
    }

    .up-imgFileUploade .imgAll {
        width: 100%;
        clear: both;
        display: block;
        min-height: 68px;
    }

    .up-imgFileUploade .imgAll ul {
        padding-left: 0px;
        list-style: none;
    }

    .up-imgFileUploade .imgAll ul:after {
        visibility: hidden;
        display: block;
        font-size: 0;
        content: ".";
        clear: both;
        height: 0;
        list-style: none;
    }

    .up-imgFileUploade .imgAll li {
        width: 48px;
        height: 48px;
        border: solid 1px #ccc;
        margin: 8px 5px;
        float: left;
        position: relative;
        box-shadow: 0 0 10px #eee;
        list-style: none;
    }

    .up-imgFileUploade .imgAll li img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: block;
    }

    .up-delImg {
        position: absolute;
        top: -5px;
        right: -5px;
        width: 10px;
        height: 10px;
        background: #FFF;
        border-radius: 50%;
        border: #666666 1px solid;
        display: block;
        text-align: center;
        line-height: 3px;
        color: #FF0000;
        font-weight:bolder;
        font-style: normal;
        cursor: pointer;
    }
    /*上传组件样式结束*/
</style>
