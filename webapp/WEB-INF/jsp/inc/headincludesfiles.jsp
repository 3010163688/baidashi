<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-11
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8"/>
<title>${title}</title>
<meta name="keywords" content="${keywords}"/>
<meta name="description"
      content="${description}"/>
<meta name="location" content="province=福建;city=厦门">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
      content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, target-densitydpi=medium-dpi">
<link rel="shortcut icon" href="${tIcon}" type="image/x-icon"/>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link rel="stylesheet"  href="/static/bootstrap4.4.1/css/bootstrap.css">
<!-- Plugins CSS -->
<link rel="stylesheet" href="/resources/baseres/css/animate.min.css">
<%--这个要放在bootstrap.min.css后面，不然会导致一些图标显示问题--%>
<link rel="stylesheet" href="/resources/baseres/fontawesome-free-5.13.0-web/css/all.min.css">

<link rel="stylesheet" href="/resources/hzvis/static/style.css" type="text/css">
<link rel="stylesheet" href="/resources/hzvis/static/public.css" type="text/css">
<link rel="stylesheet" href="/static/assets/css/custom.css" type="text/css">
<link rel="stylesheet" href="/static/ck/ck5content.css">
<script type="text/javascript" src="/resources/hzvis/static/jQuery.js"></script>
<script type="text/javascript" src="/resources/hzvis/static/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="/resources/hzvis/static/jquery.lazyload.js"></script>
<script type="text/javascript" src="/resources/hzvis/static/jquery.superslide.js"></script>
<script src="https://cdn.staticfile.org/vue/2.4.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script type="text/javascript" src="/static/assets/pagejs/videoplayer.js"></script>
<style>
    /* 摘要背景板 */
    .hideBg {
        width: 100%;
        margin:0;
        padding:0;
        padding-bottom: 0;    /* 方便渐变层遮挡 */
        position: relative;    /* 用于子元素定位 */
    }
    /* 全文背景板，基本与摘要相同 */
    .showBg {
        width: 100%;

        margin: 0;
        padding: 0;
    }
    /* 摘要内容 */
    .summary {
        overflow: hidden!important;    /* 隐藏溢出内容 */
        height: 190px;
    }
    /* 展开按钮 */
    .showBtn {
        width: 100%;    /* 与背景宽度一致 */
        height: 6rem;
        position: absolute;    /* 相对父元素定位 */
        top: 6rem;    /* 刚好遮挡在最后两行 */
        left: 0;
        z-index: 0;    /* 正序堆叠，覆盖在p元素上方 */
        text-align: center;
        background: linear-gradient(rgba(255,255,255,.5), white);    /* 背景色半透明到白色的渐变层 */
        padding-top:6rem;
    }
    /* 收起按钮 */
    .hideBtn {
        text-align: right;
    }
    /* 向下角箭头 */
    .downArrow {
        display: inline-block;
        width: 8px;    /* 尺寸不超过字号的一半为宜 */
        height: 8px;
        border-right: 1px solid;    /* 画两条相邻边框 */
        border-bottom: 1px solid;
        transform: rotate(45deg);    /* 顺时针旋转45° */
        margin-bottom: 3px;
    }
    /* 向上角箭头，原理与下箭头相同 */
    .upArrow {
        display: inline-block;
        width: 8px;
        height: 8px;
        border-left: 1px solid;
        border-top: 1px solid;
        transform: rotate(45deg);
        margin-top: 3px;
    }
</style>
