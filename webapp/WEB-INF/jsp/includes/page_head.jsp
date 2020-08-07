<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/18
  Time: 7:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header style="z-index: 1110">
    <!-- logo -->
    <div class="am-fl tpl-header-logo">
        <jsp:include page="/includes/bklogo"/>
    </div>
    <!-- 右侧内容 -->
    <div class="tpl-header-fluid">
        <!-- 侧边切换 -->
        <div class="am-fl tpl-header-switch-button am-icon-list">
                    <span>
                </span>
        </div>
        <!-- 搜索 -->
        <div class="am-fl tpl-header-search">
        </div>
        <!-- 其它功能-->
        <div class="am-fr tpl-header-navbar">
            <ul>
                <!-- 欢迎语 -->
                <li class="am-text-sm tpl-header-navbar-welcome">
                    <a href="javascript:;">欢迎你, <span><shiro:principal/></span> </a>
                </li>

                <li class="am-dropdown tpl-dropdown" data-am-dropdown>
                    <a href="javascript:;" class="am-dropdown-toggle tpl-dropdown-toggle" data-am-dropdown-toggle>
                        <i class="am-icon-cog"></i>
                    </a>
                    <ul class="am-dropdown-content tpl-dropdown-content">
                        <li class="tpl-dropdown-menu-notifications">
                            <a href="javascript:;" class="tpl-dropdown-menu-notifications-item am-cf">
                                <div class="tpl-dropdown-menu-notifications-title">
                                    <!-- 风格切换 -->
                                        <div class="tpl-skiner-content-bar">
                                            <span class="skiner-color skiner-white" data-color="theme-white"></span>
                                            <span class="skiner-color skiner-black" data-color="theme-black"></span>
                                        </div>
                                </div>
                                <div class="tpl-dropdown-menu-notifications-time" style="margin-top: 10px;">
                                    风格设置
                                </div>
                            </a>
                        </li>
                        <li class="tpl-dropdown-menu-notifications">
                            <a href="/sysmanage/user/userinfo" class="tpl-dropdown-menu-notifications-item am-cf">
                                <div class="tpl-dropdown-menu-notifications-title">
                                    <i class="am-icon-user"></i>
                                    <span> 用户资料设置</span>
                                </div>
                                <div class="tpl-dropdown-menu-notifications-time">
                                    密码修改等
                                </div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 退出 -->
                <li class="am-text-sm">
                    <a href="${pageContext.request.contextPath}/logout">
                        <span class="am-icon-sign-out"></span> 退出
                    </a>
                </li>
            </ul>
        </div>
    </div>

</header>
