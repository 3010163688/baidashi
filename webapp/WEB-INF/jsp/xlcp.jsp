<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-07-09
  Time: 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/inc/headincludesfiles"/>
</head>
<body>
<jsp:include page="/inc/mainmenus"/>
<div class="container-fluid body-width">
    <div class="row">
        <div class="col mt-5">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 text-center" id="cplb">
                <div class="col py-5" style="background: #1b1b1b;border: 1px #050301 solid;" v-for="item in datalist">
                    <a :href="'/categorydetails?cid='+item.id+'&pid=4&picid=178&p=0/185/'+item.id+'&channelid=6&ut=categorydetails'">
                        <img class="mt-5 pt-5" :src="item.attachment_url"/>
                        <div class="txtoverlay-p text-bds-subtitle-p">
                            {{item.title}}
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="row row-cols-1  mt-5" style="background: #fff;border: 1px #050301 solid;">
        <div class="col ">
            <div class="d-flex justify-content-between">
                <div style="font-size: 1.7rem">热销产品</div>
                <div style="font-size: 1.7rem">
                    <a href="/cpxldatalist?cid=4&pid=4&picid=${picid}&p=0/4&channelid=6&ut=cpxldatalist&ty=2212">>></a>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 text-center" id="lxcp">
                <div class="col py-5" style="background: #fff;border: 1px #050301 solid;" v-for="item in caselist">
                    <a :target="item.link_url==''?'_self':'_blank'"
                       :href="item.link_url==''?'/xlcpdetails/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                        <img class="mb-5 pb-5" :src="item.img_url"/>
                        <div class="row row-cols-1 txtoverlay-p-b">
                            <div class="col text-bds-subtitle-p1">{{item.title}}</div>
                            <div class="col mt-2"><img src="/static/imgs/btntmall.png"/></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="row row-cols-1  mt-5" style="background: #fff;border: 1px #050301 solid;">
        <div class="col ">
            <div class="d-flex justify-content-between">
                <div style="font-size: 1.7rem">品牌精选</div>
                <div style="font-size: 1.7rem">
                    <a href="/cpxldatalist?cid=4&pid=4&picid=${picid}&p=0/4&channelid=6&ut=cpxldatalist&ty=2221">>></a>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 text-center" id="ppjx">
                <div class="col py-5" style="background: #fff;border: 1px #050301 solid;" v-for="item in caselist">
                    <a :target="item.link_url==''?'_self':'_blank'"
                       :href="item.link_url==''?'/xlcpdetails/'+item.id+'?cid=${cid}&pid=${pid}&picid=${picid}&p=0/185&channelid=${channelid}&ut=${ut}':item.link_url">
                    <img class="mb-5 pb-5" :src="item.img_url"/>
                    <div class="row row-cols-1 txtoverlay-p-b">
                        <div class="col text-bds-subtitle-p1">{{item.title}}</div>
                        <div class="col mt-2"><img src="/static/imgs/btntmall.png"/></div>
                    </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
<script type="text/javascript">
    selCaseCategoryList('#cplb', 1, 50, 4, 6, '系列产品类别');
    caseshow('#lxcp', 1, 4, 4, 6, null, '2212');
    caseshow('#ppjx', 1, 8, 4, 6, null, '2221');
</script>
</body>
</html>
