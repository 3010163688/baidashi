<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="zhangfn" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
    <script src="/static/ck/ckeditor5/ckeditor.js"></script>
    <script src="/static/ck/ckeditor5/translations/zh-cn.js"></script>
    <script  src="/static/js/vue.min.js"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css">
    <style>
        ul.ztree {
            margin-top: 10px;
            border: 1px solid #617775;
            background: #f0f6e4;
            width: 220px;
            height: 200px;
            overflow-y: scroll;
            overflow-x: auto;
        }
    </style>
    <%--    <style>
            .ck-editor__editable {
                min-height: 300px;
            }
        </style>--%>
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

        <div class="container-fluid am-cf">
            <div class="row">
                <div class="am-u-sm-12 am-u-md-12 am-u-lg-9">
                    <div class="page-header-heading"><span class="am-icon-user page-header-heading-icon"></span>用户资料设置
                        <small>首页/用户资料设置</small>
                    </div>
                    <p class="page-header-description">可对当前登录用户进行密码、邮箱、手机、头像等进行修改。</p>
                </div>
            </div>

        </div>

        <div class="row-content  am-cf">
            <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                <div class="widget am-cf">
                    <div class="widget-body am-fr">
                        <c:if test="${not empty msg}">
                            <div class="message">${msg}</div>
                        </c:if>
                        <form:form class="am-form tpl-form-border-form" method="post" modelAttribute="user1">
                            <form:hidden path="id"/>
                            <form:hidden path="salt"/>
                            <form:hidden path="locked"/>
                            <form:hidden path="headicon"/>
                            <form:hidden path="organizationId"/>
                            <form:hidden path="roleIds"/>
                            <form:hidden path="password"/>
                            <form:hidden path="remark"/>

                            <div class="am-form-group">
                                <form:label path="username"
                                            class="am-u-sm-12 am-form-label am-text-left">用户名*：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input class="tpl-form-input am-margin-top-xs"
                                                path="username"
                                                readonly="${op ne '新增'}"/>
                                    <small><form:errors cssStyle="color: #ff0000" delimiter="," path="username"/>
                                        用户名由长度在3到20之间长度的英文字符组！
                                    </small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="password1"
                                            class="am-u-sm-12 am-form-label am-text-left">密码*：</form:label>
                                <div class="am-u-sm-12">
                                    <form:password class="tpl-form-input am-margin-top-xs" path="password1"/>
                                    <small><form:errors cssStyle="color: #ff0000" delimiter="," path="password1"/>密码由长度在6个以上的英文字符组成，不填则原来设置的密码不变！</small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label path="email" class="am-u-sm-12 am-form-label am-text-left">邮箱：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="email" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="email" cssStyle="color: #FF0000;" delimiter=","/>
                                        填写常用邮箱，可用于登录或找回密码。
                                    </small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label class="am-u-sm-12 am-form-label am-text-left" path="mobilephone">手机：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="mobilephone" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="mobilephone" cssStyle="color: #FF0000;" delimiter=","/>
                                        填写常用手机，可用于密码或找回密码等。
                                    </small>
                                </div>
                            </div>

                            <div class="am-form-group">
                                <form:label class="am-u-sm-12 am-form-label am-text-left" path="nickname">呢称：</form:label>
                                <div class="am-u-sm-12">
                                    <form:input path="nickname" class="tpl-form-input am-margin-top-xs"/>
                                    <small><form:errors path="nickname"
                                                        cssStyle="color: #FF0000;"
                                                        delimiter=","/></small>
                                </div>
                            </div>
                            <c:if test="${user1.username ne null and not ''.equals(username)}">
                                <div class="am-form-group">
                                    <form:label class="am-u-sm-12 am-form-label am-text-left" path="headicon">头像：</form:label>
                                    <div class="am-u-sm-12">
                                        <small><form:errors path="headicon"
                                                            cssStyle="color: #FF0000;"
                                                            delimiter=","/></small>
                                        <div class="up-box">
                                            <div class="up-imgFileUploade">
                                                <div class="imgAll">
                                                    <div class="header" style="display: none;">
                                                        <span class="imgTitle"> 头像图片：</span>
                                                    </div>
                                                    <ul id="headPicList">
                                                        <input type="file"
                                                               name=""
                                                               id="upimages009"
                                                               class="imgFiles"
                                                               style="display: none;"
                                                               accept="image/*"/>
                                                        <li class="imgClick" id="itmImgClick">
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <div class="am-form-group">
                                <label class="am-u-sm-12 am-form-label am-text-left" for="editor">备注：</label>
                                <div class="am-u-sm-12">
                                    <div class="editorBody">
                                        <div class="centered">
                                            <div class="document-editor">
                                                <div class="toolbar-container"></div>
                                                <div class="content-container">
                                                    <div id="editor" style="border: #EDEDED 1PX solid;min-height: 200px;">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    DecoupledEditor
                                        .create(document.querySelector('#editor'), {
                                            //toolbar: ['ckfinder', 'paragraph', 'heading', 'heading1', 'heading2', 'heading3', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'blockQuote', 'imageUpload'],
                                            ckfinder: {
                                                uploadUrl: '/admin/uploaddata/submitFormData?command=QuickUpload&type=Files&responseType=json&fdic=ckeditorFiles',
                                                // openerMethod: 'popup'
                                            },
                                            language: 'zh-cn'
                                        })
                                        .then(editor => {
                                            const toolbarContainer = document.querySelector('.editorBody .toolbar-container');
                                            toolbarContainer.prepend(editor.ui.view.toolbar.element);
                                            editor.setData($("#remark").val());
                                            editor.model.document.on('change:data', function () {
                                                $("#remark").val(editor.getData());
                                            });
                                            //CKFinder.setupCKEditor(editor, '/ckfinder/');
                                            window.editor = editor;
                                        })
                                        .catch(err => {
                                            console.error(err.stack);
                                        });
                                </script>
                            </div>
                            <div class="am-form-group">
                                <div class="am-u-sm-12 am-u-sm-push-12">
                                    <form:button
                                            class="am-btn am-btn-primary tpl-btn-bg-color-success ">保存</form:button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="msgtip">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">消息提示
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            {{message}}
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
<script src="/ckfinder/static/ckfinder.js"></script>
<%--<script src="/static/js/upload.js"></script>--%>
<script src="/static/js/ckselfile.js"></script>
<script type="text/javascript">
    var __msgtip = new Vue({
        el: '#msgtip',
        data: {
            message: ''
        }
    })
    function fileTypeErr(errmsg)
    {
        __msgtip.message=errmsg;
        $('#msgtip').modal('open');
        console.log('我的文件错误提示：');
        console.log(errmsg);
    }
    $("#upimages009").attr("savepath", "headPics");//图片上传文件夹
    $("#upimages009").attr("unum", 1);//文件上传数量
    $("#upimages009").attr("oid", "headicon");//返回值绑定的字段
    $("#upimages009").attr("fexts", '{"fext":"/^jpg|jpeg|png|bmp|gif$/i","msg":"您所选文件中有些文件不是jpg,jpeg,png,bmp,gif图片文件！"}');//验证所选文件类型,正则表过式
    $("#upimages009").attr("uid", '${user1.username}');
    var up_upFiles =${hps==null or "".equals(hps)?[]:hps};
    var fileUploadComponent00 = new ckselfile('#itmImgClick', '#upimages009', '/saveHeadPic', '/delFile', '/admin/uploaddata/submitFormData',up_upFiles,'','/static/imgs/uploaderimgs/login.gif');
    fileUploadComponent00.filetypefail(fileTypeErr);
    fileUploadComponent00.initheadPicList(up_upFiles,'#upimages009');
</script>
</body>
</html>
