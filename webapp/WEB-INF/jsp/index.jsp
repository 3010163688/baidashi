<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-07-02
  Time: 7:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/inc/headincludesfiles"/>
</head>
<body>
<jsp:include page="/inc/mainmenus"/>
<div class="container-fluid body-width p-0">
    <div class="row row-cols-1" id="zzpz">
        <div class="col">
            <div class="row row-cols-1" v-for="item in datalist">
                <a :target="item.link_url==''?'_self':'_blank'" :href="item.link_url==''?'/indexzzpz/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                    <div class="col text-center text-bds-title mt-5">{{item.title}}</div>
                    <div class="col text-center text-bds-subtitle mt-3">{{item.subTitle}}</div>
                    <div class="col mt-5">
                        <img :src="item.img_url" class="img-fluid" :alt="item.title">
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="row row-cols-1" id="ythms">
        <div class="col text-center text-bds-title mt-5">${category_ythms.title}</div>
        <div class="col text-center text-bds-subtitle mt-3">${category_ythms.subTitle}</div>
        <div class="col mt-5">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 text-center">
                <div class="col" v-for="item in datalist">
                    <div>
                        <a :target="item.link_url==''?'_self':'_blank'" :href="item.link_url==''?'/indexythms/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                            <img :src="item.img_url" :alt="item.title"/>
                            <div class="txtoverlay text-bds-subtitle">
                                {{item.title}}
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row row-cols-1" id="cst">
        <div class="col mt-5" v-for="item in datalist">
            <a item.link_url==''?'_self':'_blank'" :href="item.link_url==''?'/indexcst/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                <img :src="item.img_url" class="img-fluid" alt="Responsive image">
                <div class="row  row-cols-1 txtoverlaybig text-center">
                    <div class="col text-bds-titlebig">{{item.title}}</div>
                    <div class="col text-bds-subtitlebig">{{item.subTitle}}</div>
                </div>
            </a>
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
<script type="text/javascript">
    selCaseDataList('#zzpz', 1, 50, 14, 9, '专注品种', null, null);
    selCaseDataList('#ythms', 1, 50, 183, 9, '一体化模式', null, null);
    selCaseDataList('#cst', 1, 50, 184, 9, '茶山图', null, null);
</script>
</body>
</html>
