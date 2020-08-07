<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-06-25
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/includes/headmetaconfig"/>
    <%@include file="/WEB-INF/jsp/includes/amazeconfig_f.jsp" %>
    <script src="/static/ck/ckeditor5/ckeditor.js"></script>
    <script src="/ckfinder/static/ckfinder.js"></script>
    <script src="/static/ck/ckeditor5/translations/zh-cn.js"></script>
    <style>
        .ck-editor__editable {
            min-height: 200px;
        }

        .am-tabs-bd {
            border: none;
        }

        .page-footer {
            padding: 10px 0;
            height: 32px;
            font-size: 12px;
        }

        .page-footer .btn-wrap {
            position: fixed;
            margin: 0;
            padding: 10px 0;
            top: auto;
            left: 0;
            right: 0;
            bottom: 0;
            background: #fff;
            z-index: 1000;
        }

        .page-footer .btn-wrap:after {
            clear: both;
            content: ".";
            display: block;
            height: 0;
            visibility: hidden;
        }
    </style>
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

            <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
                <div class="widget am-cf">
                    <div class="widget-body am-fr">
                        <form:form class="am-form tpl-form-border-form"
                                   method="post"
                                   modelAttribute="articleWithBLOBs">
                            <div class="am-tabs" data-am-tabs="{noSwipe: 1}">
                                <ul class="am-tabs-nav am-nav am-nav-tabs">
                                    <li class="am-active"><a href="#tab1">基本信息</a></li>
                                    <li><a href="#tab2">详细描述</a></li>
                                    <li><a href="#tab3">SEO选项</a></li>
                                </ul>

                                <div class="am-tabs-bd">
                                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                                        <form:hidden path="id"/>
                                        <form:hidden path="channel_id"/>
                                        <form:hidden path="img_url"/>
                                        <form:hidden path="contents"/>
                                        <form:hidden path="contentsEn"/>
                                        <form:hidden path="attachment_url"/>

                                        <div class="am-form-group">
                                            <form:label path="category_id"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">所属类别：</form:label>
                                            <div class="am-u-sm-12 am-margin-top-xs">
                                                <form:select path="category_id"
                                                             data-am-selected="{btnSize: 'sm',maxHeight: 300}"
                                                             items="${articleCategoryList}"
                                                             itemLabel="title"
                                                             itemValue="id"
                                                             style="display: none;"/>
                                                <small>
                                                    <form:errors path="category_id"
                                                                 cssStyle="color:#FF0000;"
                                                                 delimiter=","><span style="color:#FF0000;">必选</span></form:errors>
                                                </small>
                                            </div>
                                        </div>
                                        <c:set var="__lrop" value="${articleWithBLOBs.localRecOP==null||''.equals(articleWithBLOBs.localRecOP.trim())||articleWithBLOBs.localRecOP.trim().length()!=12?'111111010100':articleWithBLOBs.localRecOP.trim()}"/>

                                        <div class="am-form-group"
                                             style="display:
                                             <c:choose>
                                             <c:when test="${astatus==0}">none</c:when>
                                             <c:otherwise>
                                             <c:if test="${'0'.equals(__lrop.substring(4,5))}">
                                                     none
                                             </c:if>
                                             </c:otherwise>
                                             </c:choose>;">
                                            <label class="am-u-sm-12 am-form-label am-text-left">显示状态：</label>
                                            <div class="am-u-sm-12">
                                                <div class="am-btn-group am-margin-top-xs" data-am-button>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:radiobutton  path="status" value="0"/> 正常
                                                    </label>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:radiobutton path="status" value="1"/> 推荐
                                                    </label>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:radiobutton path="status" value="2"/> 不显示
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="am-form-group"
                                             style="display:
                                             <c:choose>
                                             <c:when test="${atjtype==0}">none</c:when>
                                             <c:otherwise>
                                             <c:if test="${'0'.equals(__lrop.substring(5,6))}">
                                                     none
                                             </c:if>
                                             </c:otherwise>
                                             </c:choose>;">
                                            <label class="am-u-sm-12 am-form-label am-text-left">推荐类型：</label>
                                            <div class="am-u-sm-12">
                                                <div class="am-btn-group am-margin-top-xs" data-am-button>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:checkbox path="is_top" value="0"/> 正常
                                                    </label>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:checkbox path="is_red" value="0"/> 推荐
                                                    </label>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:checkbox path="is_hot" value="0"/> 热销
                                                    </label>
                                                    <label class="am-btn am-btn-secondary">
                                                        <form:checkbox path="is_slide" value="0"/> 品牌
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="am-form-group" <c:if test="${lrop==0}">style="display:none;"</c:if>>
                                            <form:label path="localRecOP"
                                                        class="am-u-sm-12 am-form-label am-text-left">本记录操作管理：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="localRecOP"/>
                                                <small><form:errors path="localRecOP"
                                                                    cssStyle="color: #FF0000;"
                                                                    delimiter="，"/>本条记录操作管理，分为删,改,复制,查,状态,类型,上传封面数量,上传相关文件数量,封面图，相关文件，启用封面，启用相关文件，前六位为二进制、第七和十位为十进制表示、第十一和第十二位为二进制，二进制1为启用0为禁用，如:101000010100,启用删、复制，改、查、状态、类型禁用，上传封面数量一张、上传相关文件数量一张，封面图、相关文件禁用，值为NULL值或空字符串时，封面图，相关文件禁用其它为全部启用。
                                                </small>
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <form:label path="title"
                                                        class="am-u-sm-12 am-form-label am-text-left">中文内容标题：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="title"/>
                                                <small><form:errors path="title"
                                                                    cssStyle="color: #FF0000;"
                                                                    delimiter=","/>内容标题，允许中文。
                                                </small>
                                            </div>
                                        </div>

                                        <div class="am-form-group" style="display: none;">
                                            <form:label path="titleEn"
                                                        class="am-u-sm-12 am-form-label am-text-left">英文内容标题：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="titleEn"/>
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <form:label path="subTitle"
                                                        class="am-u-sm-12 am-form-label am-text-left">中文副标题：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="subTitle"/>
                                                <small><form:errors path="subTitle"
                                                                    cssStyle="color: #FF0000;"
                                                                    delimiter=","/>副标题，允许中文。
                                                </small>
                                            </div>
                                        </div>

                                        <div class="am-form-group"  style="display: none;">
                                            <form:label path="subTitleEn"
                                                        class="am-u-sm-12 am-form-label am-text-left">英文副标题：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="subTitleEn"/>
                                            </div>
                                        </div>

                                        <div class="am-form-group am-form-icon">

                                            <form:label path="add_time"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">发布日期：</form:label>
                                            <div class="am-u-sm-12 am-margin-top-xs">
                                                <fmt:formatDate value="${article.add_time}" pattern="yyyy-MM-dd" var="formatDate"/>
                                                  <i style="padding-left: 10px;" class="am-icon-calendar"></i>
                                                <form:input path="add_time" id="add_timedatetimepicker" class="am-form-field" data-date-format="yyyy-mm-dd hh:ii:ss" placeholder=""  readonly="true"/>
                                            </div>
                                            <small><form:errors path="add_time"
                                                                cssStyle="color:#FF0000;"
                                                                delimiter=","/>请填写如：2020-01-05格式。
                                            </small>
                                            <script type="text/javascript">
                                                $('#add_timedatetimepicker').datetimepicker({
                                                    language:  'zh-CN'
                                                });
                                            </script>
                                            </div>

                                        <div class="am-form-group">
                                            <form:label path="sort_id"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">序号：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input path="sort_id"
                                                            cssClass="tpl-form-input am-margin-top-xs"></form:input>
                                                <small><form:errors path="sort_id"
                                                                    cssStyle="color:#FF0000;"
                                                                    delimiter=","><span style="color:#FF0000;">填写有误</span>，</form:errors>请填写大于或等于0整数。
                                                </small>
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <form:label path="remarks"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">备注说明：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input path="remarks"
                                                            cssClass="tpl-form-input am-margin-top-xs"></form:input>
                                            </div>
                                        </div>

                                        <div class="am-form-group"  style="display: ${albums=="1" or '1'.equals(__lrop.substring(10,11))?"block":"none"};">
                                            <form:label path="img_url"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">封面图（不超过${__lrop.substring(6,8)}张）：</form:label>
                                            <div class="am-u-sm-12">
                                                <small><form:errors path="img_url"
                                                                    cssStyle="color: #FF0000;"
                                                                    delimiter=","/></small>






<%--                                                <div class="up-box">--%>
<%--                                                    <div class="up-imgFileUploade">--%>
<%--                                                        <div class="imgAll">--%>
<%--                                                            <div class="header" style="display: none;">--%>
<%--                                                                <span class="imgTitle"> 头像图片：</span>--%>
<%--                                                            </div>--%>
<%--                                                            <ul id="headPicList">--%>
<%--                                                                <input type="file"--%>
<%--                                                                       name=""--%>
<%--                                                                       id="upimages009"--%>
<%--                                                                       class="imgFiles"--%>
<%--                                                                       style="display: none;"--%>
<%--                                                                       accept="image/*"/>--%>
<%--                                                                <li  id="itmImgClick"  class="imgClick">--%>
<%--                                                                </li>--%>
<%--                                                            </ul>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>




                                                <div class="up-box">
                                                    <div class="up-imgFileUploade">
                                                        <div class="imgAll">
                                                            <div class="header" style="display: none;">
                                                                <span class="imgTitle"> 头像图片：</span>
                                                            </div>
                                                            <ul id="headPicList">
                                                                <input type="text"
                                                                       name=""
                                                                       id="upimages009"
                                                                       class="imgFiles"
                                                                       style="display: none;"/>
                                                                <li  id="itmImgClick"  class="imgClick">
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>


                                        <div class="am-form-group"  style="display: ${attach=="1" and '1'.equals(__lrop.substring(11,12))?"block":"none"};">
                                            <form:label path="attachment_url"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">相关文件(不超过${__lrop.substring(8,10)}个文件)：</form:label>
                                            <div class="am-u-sm-12">
                                                <small><form:errors path="attachment_url"
                                                                    cssStyle="color: #FF0000;"
                                                                    delimiter=","/></small>
                                                <div class="up-box">
                                                    <div class="up-imgFileUploade">
                                                        <div class="imgAll">
                                                            <div class="header" style="display: none;">
                                                                <span class="imgTitle"> 相册附件：</span>
                                                            </div>
                                                            <ul>
                                                                <input type="file"
                                                                       name=""
                                                                       id="upimages01"
                                                                       class="imgFiles"
                                                                       style="display: none;"/>
                                                                <li id="itmImgClick01" class="imgClick">
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="am-tab-panel am-fade" id="tab2">
                                        <div class="am-form-group">
                                            <form:label path="link_url"
                                                        class="am-u-sm-12 am-form-label am-text-left">URL链接：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input class="tpl-form-input am-margin-top-xs" path="link_url"/>
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <form:label path="zhaiyao"
                                                        class="am-u-sm-12 am-form-label am-text-left">中文摘要：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:textarea rows="5" class="tpl-form-input am-margin-top-xs" path="zhaiyao"/>
                                            </div>
                                        </div>

                                        <div class="am-form-group" style="display: none;">
                                            <form:label path="zhaiyaoEn"
                                                        class="am-u-sm-12 am-form-label am-text-left">英文摘要：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:textarea rows="5" class="tpl-form-input am-margin-top-xs" path="zhaiyaoEn"/>
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="editor"
                                                   class="am-u-sm-12 am-form-label am-text-left">中文描述：</label>
                                            <div class="am-u-sm-12 am-margin-top-xs">
                                                <div class="editorBody" style="max-width: 1185px;">
                                                    <div class="centered">
                                                        <div class="document-editor">
                                                            <div class="toolbar-container"></div>
                                                            <div class="content-container">
                                                                <div id="editor" style="border: #999999 1PX solid;font-size:14px;">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <script>

                                                DecoupledEditor
                                                    .create(document.querySelector('#editor'), {
                                                        // toolbar:["heading","|","fontsize","fontfamily","fontcolor","fontbackgroundcolor","|","bold","italic","underline","strikethrough","highlight","|","alignment","|","numberedList","bulletedList","|","link","blockquote","imageUpload","insertTable","mediaEmbed","xbutton","|","undo","redo"],
                                                        //toolbar:["heading","|","fontsize","fontfamily","|","bold","italic","underline","strikethrough","highlight","|","alignment","|","numberedList","bulletedList","|","link","blockquote","imageUpload","insertTable","mediaEmbed","ckfinder","|","undo","redo"],
                                                        //toolbar: ['ckfinder', 'paragraph', 'heading', 'heading1', 'heading2', 'heading3', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'blockQuote', 'imageUpload'],
                                                        ckfinder: {
                                                            //uploadUrl: '/admin/uploaddata/submitFormData?command=QuickUpload&type=Files&responseType=json&fdic=ckeditorFiles',
                                                            uploadUrl:'/ckfinder/connector?command=QuickUpload&type=Files&responseType=json',
                                                            // openerMethod: 'popup'
                                                        },
                                                        language: 'zh-cn',
                                                        //extraPlugins:["colorbutton"],
                                                        // // 自定字号列表
                                                        // fontSize: {options: [10,12,14,16,18,20,24]},
                                                        // // 自定字体列表
                                                        // fontFamily:{
                                                        //     options: [
                                                        //         'default',
                                                        //         'Arial, Helvetica, sans-serif',
                                                        //         'Courier New, Courier, monospace',
                                                        //         'Georgia, serif',
                                                        //         'Lucida Sans Unicode, Lucida Grande, sans-serif',
                                                        //         'Tahoma, Geneva, sans-serif',
                                                        //         'Times New Roman, Times, serif',
                                                        //         'Trebuchet MS, Helvetica, sans-serif',
                                                        //         'Verdana, Geneva, sans-serif',
                                                        //         '黑体'
                                                        //     ]},
                                                        // // 自定heading列表
                                                        // heading: {
                                                        //     options: [
                                                        //         { model: 'paragraph', title: '正文', class: 'ck-heading_paragraph' },
                                                        //         { model: 'heading1', view: 'h1', title: '标题1', class: 'ck-heading_heading1' },
                                                        //         { model: 'heading2', view: 'h2', title: '标题2', class: 'ck-heading_heading2' },
                                                        //         { model: 'heading3', view: 'h3', title: '标题3', class: 'ck-heading_heading3' },
                                                        //         { model: 'heading4', view: 'h4', title: '标题4', class: 'ck-heading_heading4' },
                                                        //     ]
                                                        // }
                                                    })
                                                    .then(editor => {
                                                        // 选择toolbar所在标签
                                                        const toolbarContainer = document.querySelector('.editorBody .toolbar-container');
                                                        toolbarContainer.prepend(editor.ui.view.toolbar.element);
                                                        editor.setData($("#contents").val());
                                                        // 内容变更时触发，获取内容
                                                        editor.model.document.on('change:data', function () {
                                                            $("#contents").val(editor.getData());
                                                        });
                                                        window.editor = editor;
                                                    })
                                                    .catch(err => {
                                                        console.error(err.stack);
                                                    });

                                            </script>
                                        </div>

                                        <div class="am-form-group" style="display: none;">
                                            <label for="editoren"
                                                   class="am-u-sm-12 am-form-label am-text-left">英文描述：</label>
                                            <div class="am-u-sm-12 am-margin-top-xs">
                                                <div class="editorBodyen" style="max-width: 1185px;">
                                                    <div class="centered">
                                                        <div class="document-editor">
                                                            <div class="toolbar-containeren"></div>
                                                            <div class="content-container">
                                                                <div id="editoren" style="border: #999999 1PX solid;font-size:14px;">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <script>
                                                DecoupledEditor
                                                    .create(document.querySelector('#editoren'), {
                                                        // toolbar:["heading","|","fontsize","fontfamily","fontcolor","fontbackgroundcolor","|","bold","italic","underline","strikethrough","highlight","|","alignment","|","numberedList","bulletedList","|","link","blockquote","imageUpload","insertTable","mediaEmbed","xbutton","|","undo","redo"],
                                                        //toolbar:["heading","|","fontsize","fontfamily","|","bold","italic","underline","strikethrough","highlight","|","alignment","|","numberedList","bulletedList","|","link","blockquote","imageUpload","insertTable","mediaEmbed","ckfinder","|","undo","redo"],
                                                        //toolbar: ['ckfinder', 'paragraph', 'heading', 'heading1', 'heading2', 'heading3', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'blockQuote', 'imageUpload'],
                                                        ckfinder: {
                                                            //uploadUrl: '/admin/uploaddata/submitFormData?command=QuickUpload&type=Files&responseType=json&fdic=ckeditorFiles',
                                                            uploadUrl:'/ckfinder/connector?command=QuickUpload&type=Files&responseType=json',
                                                            // openerMethod: 'popup'
                                                        },
                                                        language: 'zh-cn'
                                                    })
                                                    .then(editor => {
                                                        const toolbarContainer = document.querySelector('.editorBodyen .toolbar-containeren');
                                                        toolbarContainer.prepend(editor.ui.view.toolbar.element);
                                                        editor.setData($("#contentsEn").val());
                                                        editor.model.document.on('change:data', function () {
                                                            $("#contentsEn").val(editor.getData());
                                                        });
                                                        //CKFinder.setupCKEditor(editor, '/ckfinder/');
                                                        window.editor = editor;
                                                    })
                                                    .catch(err => {
                                                        console.error(err.stack);
                                                    });
                                            </script>
                                        </div>

                                    </div>
                                    <div class="am-tab-panel am-fade" id="tab3">
                                        <div class="am-form-group">
                                            <form:label path="seo_title"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">SEO标题：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input path="seo_title"
                                                            cssClass="tpl-form-input am-margin-top-xs"></form:input>
                                                <small><form:errors path="seo_title"
                                                                    cssStyle="color:#FF0000;"
                                                                    delimiter=","/>255个字符以内。
                                                </small>
                                            </div>
                                        </div>
                                        <div class="am-form-group">
                                            <form:label path="seo_keywords"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">SEO关健字：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:input path="seo_keywords"
                                                            cssClass="tpl-form-input am-margin-top-xs"></form:input>
                                                <small><form:errors path="seo_keywords"
                                                                    cssStyle="color:#FF0000;"
                                                                    delimiter=","/>以“,”逗号区分开，255个字符以内。
                                                </small>
                                            </div>
                                        </div>
                                        <div class="am-form-group">
                                            <form:label path="seo_description"
                                                        cssClass="am-u-sm-12 am-form-label am-text-left">SEO描述：</form:label>
                                            <div class="am-u-sm-12">
                                                <form:textarea rows="3"
                                                               path="seo_description"
                                                               cssClass="tpl-form-input am-margin-top-xs"></form:textarea>
                                                <small><form:errors path="seo_description"
                                                                    cssStyle="color:#FF0000;"
                                                                    delimiter=","/>255个字符以内。
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <div class="am-u-sm-12 am-u-sm-push-12">
                                    <form:button
                                            class="am-btn am-btn-primary tpl-btn-bg-color-success ">提交保存</form:button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/jsp/includes/amazeconfig_l.jsp" %>
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
    $("#upimages009").attr("savepath", "productPics");//图片上传文件夹
    $("#upimages009").attr("unum", ${__lrop.substring(6,8)});//文件上传数量
    $("#upimages009").attr("oid", "img_url");//返回值绑定的字段
    $("#upimages009").attr("fexts", '{"fext":"/^jpg|jpeg|png|bmp|gif$/i","msg":"您所选文件中有些文件不是jpg,jpeg,png,bmp,gif图片文件！"}');//验证所选文件类型,正则表过式
    $("#upimages009").attr("uid", '');
    var up_upFiles =${hps==null or "".equals(hps)?[]:hps};
    var fileUploadComponent00 = new ckselfile('#itmImgClick', '#upimages009', '/saveHeadPic', '/delFile', '/admin/uploaddata/submitFormData',up_upFiles,'','/static/imgs/uploaderimgs/login.gif');
    fileUploadComponent00.filetypefail(fileTypeErr);
    fileUploadComponent00.initheadPicList(up_upFiles,'#upimages009');

    $("#upimages01").attr("savepath", "productCategoryAttachment");//图片上传文件夹
    $("#upimages01").attr("unum", ${__lrop.substring(8,10)});//文件上传数量
    $("#upimages01").attr("oid", "attachment_url");//返回值绑定的字段
    $("#upimages01").attr("uid", '');
    var up_upFiles_attachmentattachment =${attachments==null or "".equals(attachments)?[]:attachments};
    var fileUploadComponentattachment = new ckselfile('#itmImgClick01', '#upimages01', '/saveHeadPic', '/delFile', '/admin/uploaddata/submitFormData',up_upFiles_attachmentattachment,'type','/static/imgs/uploaderimgs/login.gif');
    fileUploadComponentattachment.initheadPicList(up_upFiles_attachmentattachment,'#upimages01');
</script>
</body>
</html>
