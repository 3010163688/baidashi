<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-12
  Time: 4:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>数据采集页面</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <!-- Plugins CSS -->
    <link rel="stylesheet" href="/resources/baseres/css/animate.min.css">

    <link rel="stylesheet" href="/resources/baseres/fontawesome-free-5.13.0-web/css/all.min.css">
    <script type="text/javascript" src="/resources/hzvis/static/jQuery.js"></script>
    <script src="https://cdn.staticfile.org/vue/2.4.2/vue.min.js"></script>
    <script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
</head>
<body>
<div class="container pt-5" id="data-collection">
    <form>

        <div class="form-group">
            <label for="dataurl">数据采集第一段地址</label>
            <input type="text" class="form-control" v-model="dataUrl" id="dataurl" aria-describedby="dataurlHelp">
            <small id="dataurlHelp" class="form-text text-muted">地址格式如：http://www.xmjrkj.com等</small>
        </div>
        <div class="form-group">
            <label for="dataurl2">数据采集第二段地址</label>
            <input type="text" class="form-control" v-model="dataUrl2" id="dataurl2" aria-describedby="dataurlHelp2">
            <small id="dataurlHelp2" class="form-text text-muted">地址格式如：/news/dynamic/等</small>
        </div>
        <div class="form-group">
            <label for="datapage">采集页数</label>
            <input type="text" class="form-control" v-model="dpnum" id="datapage" aria-describedby="dataurlHelp3">
            <small id="dataurlHelp3" class="form-text text-muted">地址格式如：正整数</small>
        </div>
        <div class="form-group">
            <label for="txtregex">匹配正帽表达式</label>
            <input type="text" v-model="regex" class="form-control" id="txtregex">
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="exampleCheck1">
            <label class="form-check-label" for="exampleCheck1">Check me out</label>
        </div>
        <button type="button" v-on:click="greet" class="btn btn-primary">开始采集</button>
    </form>
    <div>{{info}}</div>
</div>
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
        var wow=new WOW(
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
<script type="text/javascript">

    var app=new Vue({
        el: '#data-collection',
        data: {
            info: '采集数据信息',
            dataUrl: 'https://www.hzvis.com',
            dataUrl2: '/info/',
            regex: /[0-9]/gism,
            dpnum: 1
        },
        methods: {
            greet: function (event) {
                // if (event) {
                //     alert(event.target.tagName);
                // }
                this.dataCollection2(this.dpnum);
            },
            dataCollection2: function (j01) {

              /*  axios.get('/dcproxy?dataUrl=https://www.hzvis.com/info/page-'+j01+'.html')
                    .then(response=>{
                    var pthis=this;
                var patternAll=/<ul class="clear">.*?<\/ul>/gism;
                var patternItem=/<li>.*?<\/li>/gism;
                console.log('数据项长度：'+response.data.match(patternAll).length);
                var resultitems=response.data.match(patternAll)[1].match(patternItem);
                console.log('数据项长度1：'+resultitems.length);
                let arr_datacollection=[];
                if (resultitems!=null&&resultitems.length>0) {
                    resultitems.forEach(function (item, index) {
                        let reddetailurl=item.match(/href="\/info\/info[0-9]{1,}\/[0-9]{1,}\.html"/gism)[0];
                        console.log('数据详情地址：https://www.hzvis.com'+reddetailurl.replace('href=', '').replace(/"/gism, ''));
                        axios.get('/dcproxy?dataUrl=https://www.hzvis.com'+reddetailurl.replace('href=', '').replace(/"/gism, ''))
                            .then(
                                responsesub=>{
                            //处理详细页数据
                            var patternAllsub=/<div class="left sread-left">.*?<\/div>/gism;
                        console.log('处理详细内容：');
                        let arr_pics=[];
                        let mbody=responsesub.data.match(patternAllsub)[0];
                        let mtitle=mbody.match(/<p class="title">.*?<\/p>/gism)[0].replace('<p class="title">', '').replace('</p>', '').trim();
                        let mcontent=mbody.match(/<div class="sread-content">.*?<\/div>/gism)[0].trim();
                        let contentpicitems=mcontent.match(/<img\s.*?\s?src\s*=\s*['|"]?([^\s'"]+).*?>/gism)
                        let zhaiyao='';
                        let cid=reddetailurl.match(/info[0-9]{1,}/gism)[0];
                        if (cid=='info1') cid=155;
                        if (cid=='info2') cid=156;
                        if (cid=='info3') cid=157;
                        if (cid=='info4') cid=158;
                        if (cid=='info5') cid=159;
                        if (cid=='info6') cid=160;
                        if (cid=='info7') cid=161;
                        if (cid=='info8') cid=162;
                        if (cid=='info9') cid=163;
                        if (cid=='info10') cid=164;
                        if (cid=='info11') cid=165;
                        if (cid=='info12') cid=166;
                        if (cid=='info13') cid=167;
                        if (cid=='info14') cid=168;
                        if (cid=='info15') cid=169;
                        if (cid=='info16') cid=170;
                        if (cid=='info17') cid=171;
                        if (cid=='info18') cid=172;
                        let mpic00002='';
                        console.log("mtitle:"+mtitle);
                        if (contentpicitems!=null&&contentpicitems.length>0) {
                            console.log('内容图片匹配数据：');
                            contentpicitems.forEach(function (item001, index001) {
                                console.log(item001);
                                let rppic=item001.match(/\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}\/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0].trim();
                                let mpic00001=rppic.match(/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0];
                                arr_pics.push({'filename': mpic00001, 'url': 'https://www.hzvis.com'+rppic});
                                rppic=rppic.replace(/\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}/gism, '/uploadfile/images/designs');
                                console.log('匹配图片处理结果：'+rppic);
                                let newpicstr='<figure class="image image_resized"><img   src="'+rppic+'" alt="'+mtitle+'" ></figure>';
                                console.log('图片字符串处理结果：'+newpicstr);
                                mcontent=mcontent.replace(item001, newpicstr);
                            })
                            console.log('采集的图片：');
                            console.log(JSON.stringify(arr_pics));
                            console.log('去除所有的标签：')
                            zhaiyao=mcontent.replace(/<[^>]*>/gism, '').replace(/[\n\f\r\t\v]*!/gism, '').replace(/&nbsp;/gism, '').trim();
                            console.log(zhaiyao);
                            console.log('内容主体处理后的结果：')
                            console.log(mcontent);


                            //console.log('{"title":"'+mtitle+'","date":"'+mdate+'","mpic":"'+mpic+'","mpics":\''+JSON.stringify(arr_pics)+'\',"mcontent":\''+mcontent+'\'}');
                            arr_datacollection.push('{"cid":'+cid+',"title":"'+mtitle+'","mpic":"'+mpic00002+'","mpics":\''+JSON.stringify(arr_pics)+'\',"zhaiyao":"'+zhaiyao.substring(0, 100)+'"}');

                        }

                        if (arr_pics!=null&&arr_pics.length>0) mpic00002='/uploadfile/images/designs/'+arr_pics[0].filename;
                        var param=new URLSearchParams();
                        param.append('casedatas', '{"cid":'+cid+',"title":"'+mtitle+'","mpic":"'+mpic00002+'","mpics":\''+JSON.stringify(arr_pics)+'\',"zhaiyao":"'+zhaiyao.substring(0, 100)+'"}');
                        param.append('contentbody', mcontent)
                        axios({
                            method: 'post',
                            url: '/datacollectionsave',
                            data: param
                        })
                        pthis.info=JSON.stringify(arr_datacollection);
                        //处理详细页数据

                    }
                    )
                        ;
                    })
                }
            })*/
            },
            dataCollection: function () {
                axios.get('/dcproxy?dataUrl='+this.dataUrl+this.dataUrl2)
                    .then(response=>{
                    /*
                //description.replace(/<(?!img).*?>/g, "");如果保留img,p标签，则为：description.replace(/<(?!img|p|\/p).*?>/g, "");
                var pattern=/<div class="case-list">.*?<div class="footer">/gism;
            var result=response.data.match(pattern);
            var itemnfo=result[0].replace("<div class=\"footer\">", "");
            var result01=itemnfo.match(/<li class="c1 item".*?<\/li>/gism);
            console.log('匹配到的项数：'+result01.length);
            var dataItems=[];
            result01.forEach(function (item, index) {
                // console.log('数据项：');
                // console.log(item);
                var mtitle=item.match(/<p class="p1">.*?<\/p>/gism)[0].replace('<p class="p1">', '').replace('</p>', '').trim();
                var msubTitle=item.match(/<span class="syl">.*?<\/span>/gism)[0].replace('<span class="syl">', '').replace('</span>', '').trim();
                var mdsc=item.match(/<\/span>.*?<\/p>/gism)[0].replace('</p>', '').replace('</span>', '').replace('<br>', '').trim();
                var mpic=item.match(/[0-9]{6,}_[0-9]{2,}.(jpg|jpeg|gif|png)/gism)[0];
                dataItems.push('{"title":"'+mtitle+'","subTitle":"'+msubTitle+'","dsc":"'+mdsc+'","pic":"'+mpic+'"}');
                console.log("图片-"+index+"："+mpic);
            });
            this.info=JSON.stringify(dataItems);
            var param=new URLSearchParams();
            param.append('casedatas', this.info);
            // param.append('pwd', 'admin')
            axios({
                method: 'post',
                url: '/datacollectionsave',
                data: param
            })
            */

                    /*                    var pthis=this;
                                        var patternAll=/<div class="news-list" style="border:none">.*?<div class="footer">/gism;
                                    var patternItem=/<li class="clear">.*?<\/li>/gism;
                                    var resultitems=response.data.match(patternAll)[0].match(patternItem);
                                    console.log('数据项长度：'+resultitems.length);
                                    let arr_datacollection=[]
                                    resultitems.forEach(function (item, index) {
                                        console.log('数据项：');
                                        let mdetailurl=item.match(/\/news\/[0-9]{1,}\.html/gism)[0].trim();
                                        axios.get('/dcproxy?dataUrl='+pthis.dataUrl+mdetailurl)
                                            .then(responsesub=>{
                                            let mtitle=item.match(/class="syl" target="_blank">.*?<\/a>/gism)[0].replace('class="syl" target="_blank">', '').replace('</a>', '').trim();
                                        let mpic=item.match(/https:\/\/cdn1.hzvis.com\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}\/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0].trim();
                                        let mdate=item.match(/<h4>.*?<\/h4>/gism)[0].replace("<h4>", "").replace("</h4>", "").trim();
                                        let mcontent=responsesub.data.match(/<div class="content">.*?<\/div>/gism)[0].replace('\/static\/blank\.gif','/resources/hzvis/static//blank.gif');
                                        let mcontentpics=mcontent.match(/https:\/\/cdn1.hzvis.com\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}\/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism);
                                        //mcontent=mcontent.replace(/https:\/\/cdn1.hzvis.com\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}/gism,'/uploadfile/images/industries');
                                        let contentpicitems=mcontent.match(/<img\s.*?\s?src\s*=\s*['|"]?([^\s'"]+).*?>/gism)
                                        let zhaiyao='';
                                        if(contentpicitems!=null&&contentpicitems.length>0)
                                        {
                                            console.log('内容图片匹配数据：');
                                            contentpicitems.forEach(function (item001,index001) {
                                                console.log(item001);
                                                let rppic=item001.match(/https:\/\/cdn1.hzvis.com\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}\/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0].trim();
                                                rppic=rppic.replace(/https:\/\/cdn1.hzvis.com\/upfile(\/image)?\/[0-9]{4}\/[0-9]{2}/gism,'/uploadfile/images/industries');
                                                console.log('匹配图片处理结果：'+rppic);
                                                let newpicstr='<figure class="image image_resized"><img   src="'+rppic+'" alt="'+mtitle+'" ></figure>';
                                                console.log('图片字符串处理结果：'+newpicstr);
                                                mcontent=mcontent.replace(item001,newpicstr);
                                            })
                                            console.log('去除所有的标签：')
                                            zhaiyao=mcontent.replace(/<[^>]*>/gism,'').replace(/[\n\f\r\t\v]*!/gism,'').replace(/&nbsp;/gism,'').trim();
                                            console.log(zhaiyao);
                                            console.log('内容主体处理后的结果：')
                                            console.log(mcontent);
                                        }
                                        let arr_pics=[];
                                        // console.log(mtitle);
                                        // console.log(mdate);
                                        // console.log('https://www.hzvis.com'+mdetailurl);
                                        // console.log(mpic);
                                        let mpic00001=mpic.match(/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0];
                                        arr_pics.push({'filename':mpic00001,'url':mpic});
                                        if(mcontentpics!=null&&mcontentpics.length>0) {
                                            mcontentpics.forEach(function (subitem, subindex) {
                                                arr_pics.push({'filename':subitem.match(/[0-9_]{5,}\.(jpg|png|gif|bmp)/gism)[0],'url':subitem});
                                            });
                                        }
                                        // console.log(mcontent);
                                        var param=new URLSearchParams();
                                        param.append('casedatas', '{"title":"'+mtitle+'","date":"'+mdate+'","mpic":"'+mpic00001+'","mpics":\''+JSON.stringify(arr_pics)+'\',"zhaiyao":"'+zhaiyao.substring(0,100)+'"}');
                                        param.append('contentbody', mcontent)
                                        axios({
                                            method: 'post',
                                            url: '/datacollectionsave',
                                            data: param
                                        })
                                        //console.log('{"title":"'+mtitle+'","date":"'+mdate+'","mpic":"'+mpic+'","mpics":\''+JSON.stringify(arr_pics)+'\',"mcontent":\''+mcontent+'\'}');
                                        arr_datacollection.push('{"title":"'+mtitle+'","date":"'+mdate+'","mpic":"'+mpic+'","mpics":\''+JSON.stringify(arr_pics)+'\',"mcontent":\''+mcontent+'\',"zhaiyao":"'+zhaiyao.substring(0,100)+'"}');
                                        pthis.info=JSON.stringify(arr_datacollection);
                                    });
                                    })*/
                }
            ).
                catch(function (error) { // 请求失败处理
                    console.log(error);
                })
            }
        }
    });
    // // 也可以用 JavaScript 直接调用方法
    // app.greet() // -> 'Hello Vue.js!'
</script>
</body>
</html>
