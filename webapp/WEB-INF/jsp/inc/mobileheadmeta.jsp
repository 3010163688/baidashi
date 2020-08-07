<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-22
  Time: 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<title>${title}</title>
<meta name="keywords" content="${keywords}"/>
<meta name="description"
      content="${description}"/>
<meta name="location" content="province=福建;city=厦门">
<meta name="author" content="${title}" />
<meta name="viewport" content=" width=750, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="screen-orientation" content="portrait">
<meta name="x5-orientation" content="portrait">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<link rel="shortcut icon" href="${tIcon}" type="image/x-icon" />
<meta name="format-detection" content="telephone=no">
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
      crossorigin="anonymous">
<link rel="stylesheet" href="/resources/hzvis/static/sj/css/reset.css">
<link rel="stylesheet" href="/resources/hzvis/static/sj/css/newstyle.css">
<!-- Plugins CSS -->
<link rel="stylesheet" href="/resources/baseres/css/animate.min.css">
<%--这个要放在bootstrap.min.css后面，不然会导致一些图标显示问题--%>
<link rel="stylesheet" href="/resources/baseres/fontawesome-free-5.13.0-web/css/all.min.css">
<script src="/resources/hzvis/static/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/vue/2.4.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script src="/static/ck/ckeditor5/ckeditor.js"></script>
<script src="/static/ck/ckeditor5/translations/zh-cn.js"></script>
<script type="text/javascript" src="/static/assets/pagejs/videoplayer.js"></script>
<script type="text/javascript" src="/static/assets/pagejs/mobilepublic.js"></script>
<script src="/resources/hzvis/static/sj/js/fastclick.js"></script>
<style>
    * {
        touch-action: none;
    }
</style>
<script>
    $(function() {
// 在ready里面加入下面这句话
        FastClick.attach(document.body);

    });
    ! function(e) {
        function t() {
            if (/in/.test(e.readyState)) setTimeout(t, 9);
            else
                for (var s = 0; s < e.styleSheets.length; s++) {
                    var i = e.styleSheets[s];
                    "html4css" !== i.title && (i.disabled = !0)
                }
        }

        function s() {
            !e.readyState && e.addEventListener && (e.body ? setTimeout(function() {
                    e.readyState = "complete"
                },
                500) : setTimeout(s, 9))
        }
        var i, o = window.A17 || {},
            n = e.documentElement,
            c = window,
            a = e.getElementsByTagName("head")[0];
        o.browserSpec = "addEventListener" in c && c.history.pushState && e.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#BasicStructure", "1.1") ? "html5" : "html4",
            o.touch = !!("ontouchstart" in c || c.documentTouch && e instanceof DocumentTouch),
            o.objectFit = "objectFit" in n.style,
            o.iOS = /iPad|iPhone|iPod/.test(navigator.userAgent),
            window.A17 = o,
            n.className = n.className.replace(/\bno-js\b/, " js " + o.browserSpec + (o.touch ? " touch" : " no-touch") + (o.objectFit ? " objectFit" : " no-objectFit") + (o.iOS ? " ios" : " no-ios")),
        "html4" === o.browserSpec && (i = e.createElement("link"), i.rel = "stylesheet", i.title = "html4css", i.href = "/dist/styles/html4css.css", a.appendChild(i), i = e.createElement("script"), i.src = "//legacypicturefill.s3.amazonaws.com/legacypicturefill.min.js", a.appendChild(i), s(), t())
    }(document);
</script>
<link href="/resources/hzvis/static/sj/css/app.css?3" rel="stylesheet" />
<script src="/resources/hzvis/static/sj/js/app.js"></script>
<!--[if lt IE 9]>
<script src="/resources/hzvis/static/html5shiv.min.js"></script>
<![endif]-->
<!--[if IE]>
<script>var de = document.documentElement; de.className = de.className.replace('not-ie','ie');</script>
<![endif]-->
<style type="text/css">
    .pace-progress{display: none!important}
</style>
<style>
    .fborder{
        border: 1px solid #ff253a;
        background: rgba(255,0,0,0.1);
    }
    .myerr{
        color: #ff253a;
    }
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
<style>
    /*BACK TOP TOP*/
    .back-top {
        width: 60px;
        height:60px;
        line-height: 60px;
        padding: 13px 14px !important;
        position: fixed !important;
        bottom: 25px;
        right: 25px;
        border-radius: 3px;
        display: block;
        text-align: center;
        z-index: 999999;
        visibility: hidden;
        opacity: 0;
        transform: translateY(50%);
        -webkit-transition: all 0.3s ease-in-out;
        -moz-transition: all 0.3s ease-in-out;
        -ms-transition: all 0.3s ease-in-out;
        -o-transition: all 0.3s ease-in-out;
        transition: all 0.3s ease-in-out;
    }

    .back-top i {
        font-size: 1.8rem!important;
        color: #ffffff;
        margin: 0 !important;
        display: block;
    }

    .back-top.btn-show {
        visibility: visible;
        opacity: 1;
        transform: translateY(0%);
    }
</style>
