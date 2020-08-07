<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="xmjrkj" uri="http://github.com/zhangkaitao/tags/zhang-functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-11
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid body-width border-dds-top mt-5">
    <div class="container-fluid pt-5">
        <div class="row row-cols-2 row-cols-lg-4">
            <c:forEach items="${hzs.list}" var="item">
                <div class="col text-nowrap text-center"
                     style="line-height: 2.5"
                        <c:if test="${item.attachment_url!=null&&!''.equals(item.attachment_url)}">
                            data-toggle="tooltip"
                            data-placement="top"
                            data-html="true"
                            title="<img class='img-fluid' src='${xmjrkj:articleImgUrl(item.attachment_url)}'/>"
                        </c:if>
                ><a class="text-white"
                        <c:choose>
                            <c:when test="${item.link_url!=null&&!''.equals(item.link_url.trim())}">
                                target="_blank"
                                href="${item.link_url}"
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                ><img src="${item.img_url}"/><br/>${item.title}</a></div>
            </c:forEach>
        </div>
        <div class="d-flex flex-wrap justify-content-center" id="dbdh">
            <div v-for="item in datalist" class="text-center mb-4 text-bm-menuitem mx-4">
                <a :target="item.link_url==''?'_self':'_blank'"
                   :href="item.link_url==''?'/footdh/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                    {{item.title}}
                </a>
            </div>
        </div>
        <div class="row row-cols-1 mb-5">
            <div class="col ck-content">
                ${copyright.content}
            </div>
        </div>
    </div>
</div>
<a href="javascript:;" class="back2top"></a>
<!--[if lt IE 9]>
<script src="/resources/hzvis/static/html5.js"></script>
<![endif]-->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
<!-- Plugins js -->
<script src="/resources/baseres/js/wow.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".back2top").click(function () {
            return $("body,html").animate({
                    scrollTop: 0
                },
                500),
                !1
        });
        var wow = new WOW(
            {
                boxClass: 'wow',      // animated element css class (default is wow)
                animateClass: 'animated', // animation css class (default is animated)
                offset: 0,          // distance to the element when triggering the animation (default is 0)
                mobile: true,       // trigger animations on mobile devices (default is true)
                live: true,       // act on asynchronously loaded content (default is true)
                callback: function (box) {
                    // the callback is fired every time an animation is started
                    // the argument that is passed in is the DOM node being animated
                },
                scrollContainer: null // optional scroll container selector, otherwise use window
            }
        );
        wow.init();
    })

</script>
<script type="text/javascript" src="/static/assets/pagejs/public.js"></script>
<script language="javascript" for="window" event="onload">
    let sival = setInterval(jcload, 500);
    var loadarg = true;

    function jcload() {
        console.log('页面加载开始检测1：' + document.readyState);
        if (document.readyState == "complete" && loadarg) {
            console.log('页面加载开始检测2：' + document.readyState);
            clearInterval(sival);
            console.log('页面加载开始检测3：' + document.readyState);
            // BEGIN: 01 Preloader
            var preLoader = function () {
                if ($('.preloader').length) {
                    var $preloader = $('.preloader');
                    $preloader.delay(200).fadeOut(600);
                }
            };
            preLoader();
            loadarg = false;
        }
    }
</script>
<script type="text/javascript">
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
    selCaseDataList('#dbdh', 1, 50, 177, 7, '底部导航', null, null);
</script>
