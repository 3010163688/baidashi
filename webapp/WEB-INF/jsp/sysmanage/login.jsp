<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title}</title>
    <meta name="description" content="${description}">
    <meta name="keywords" content="${keywords}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon"  href="${faviconPath}">
    <link rel="apple-touch-icon-precomposed" href="${faviconPath}">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/static/assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="/static/assets/css/amazeui.datatables.min.css" />
    <link rel="stylesheet" href="/static/assets/css/app.css">
    <script src="/static/assets/js/jquery.min.js"></script>
<style>
    .theme-white .tpl-login-logo {
        background: url(${logoPath}) center no-repeat;
    }
    .theme-black .tpl-login-logo {
        background: url(${logoPath}) center no-repeat;
    }
</style>
</head>

<body data-type="login">
    <script src="/static/assets/js/theme.js"></script>
    <div class="am-g tpl-g">
        <div class="tpl-login">
            <div class="tpl-login-content">
                <div class="tpl-login-logo">

                </div>



                <form action="" method="post" class="am-form tpl-form-line-form">
                    <div class="am-form-group">
                        <input type="text" class="tpl-form-input" id="username" name="username"  value="<shiro:principal/>" placeholder="请输入账号">

                    </div>

                    <div class="am-form-group">
                        <input type="password" class="tpl-form-input" id="password" name="password" placeholder="请输入密码">

                    </div>
                    <div class="am-form-group tpl-login-remember-me">
                        <input id="rememberMe" name="rememberMe" type="checkbox">
                        <label for="rememberMe">
                            自动登录
                         </label>

                    </div>
                    <div class="am-form-group">

                        <button type="submit" class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success  tpl-login-btn">提交</button>

                    </div>
                    <div class="am-form-group">
                        <div class="am-text-danger" style="text-align: center;">${error}</div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="/static/assets/js/amazeui.min.js"></script>
    <script src="/static/assets/js/app.js"></script>
</body>

</html>
