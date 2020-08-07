let app_solution=new Vue({
    el: '#app_solution',
    data: {
        solution: null
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/selCaseDataList?currenPage=1&size=4&cid=149&chid=7').then(
            function (res) {
                console.log('全方位包装解决方案');
                console.log(res.data);
                pthis.solution=res.data.list;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    },
    methods: {}
});
let app_team=new Vue({
    el: '#app_team',
    data: {
        team: null
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/selCaseDataList?currenPage=1&size=6&cid=150&chid=7').then(
            function (res) {
                console.log('团队协作是一门艺术');
                console.log(res.data);
                pthis.team=res.data.list;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    },
    methods: {}
});


let app_dynamic=new Vue({
    el: '#app_dynamic',
    data: {
        dynamicdata: null
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/queryCategoryAndDetails?currenPage=1&size=3&pcid=25&chid=11&articleNum=9').then(
            function (res) {
                console.log('动态');
                console.log(res.data);
                pthis.dynamicdata=res.data.list;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});
let app_designs=new Vue({
    el: '#app_designs',
    data: {
        designsdata: null
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/queryCategoryAndDetails?currenPage=1&size=30&pcid=29&chid=8&articleNum=6').then(
            function (res) {
                console.log('设计资讯');
                console.log(res.data);
                pthis.designsdata=res.data.list;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});
let app_partner=new Vue({
    el: '#app_partner',
    data: {
        partnerdata: null
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/selCaseDataList?currenPage=1&size=42&cid=151&chid=7').then(
            function (res) {
                console.log('合作伙伴');
                console.log(res.data);
                pthis.partnerdata=res.data.list;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});
let app_about=new Vue({
    el: '#app_about',
    data: {
        articledata: null,
        pic: '',
        subTitle: '',
        title:'',
        pics: null,
        content: '<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>',
        singAttachment: '',
        attachments: null,
        id:0,
        isHide: true,    //初始值为true，显示为折叠画面
        isFirstInit:true,
        isShowHideBtn:true //是否显示收起内容按钮
    },
    created: function () {
        let pthis=this;
        axios.get('/caseapi/queryArticleDetails?aid=221').then(
            function (res) {
                console.log('关于');
                console.log(res.data);
                pthis.articledata=res.data.articleWithBLOBs;
                pthis.pic=res.data.singpic;
                pthis.subTitle=res.data.articleWithBLOBs.subTitle;
                pthis.title=res.data.articleWithBLOBs.title;
                pthis.content=res.data.articleWithBLOBs.contents;
                pthis.pics=res.data.pics;
                pthis.singAttachment=res.data.singAttachment;
                pthis.attachments=res.data.attachments;
                pthis.id=res.data.articleWithBLOBs.id;
                playbodymodal(pthis.attachments,pthis.subTitle,'/about/221.html');
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    },
    methods:{
        onShow: function(){
            this.isHide = false;    //点击onShow切换为false，显示为展开画面
        },
        onHide: function(){
            this.isHide = true;    //点击onHide切换为true，显示为折叠画面

        }
    },
    updated:function () {
        if(this.isFirstInit) {
            if (document.getElementById('aboutuscontent')) {
                console.log('要显示的关于我们的内容高度：'+document.getElementById('aboutuscontent').offsetHeight);
                if (document.getElementById('aboutuscontent').offsetHeight>190) {
                    this.isHide=true;
                }
                else
                {
                    this.isHide=false;
                    this.isShowHideBtn=false;
                }
            }
        }
        if(document.getElementById('aboutuscontent1'))
        ckedit5init('#aboutuscontent1');
        if(document.getElementById('aboutuscontent'))
            ckedit5init('#aboutuscontent');
        this.isFirstInit=false;
    }
});

let bigBanners=new Vue({
    el:'#bigBanners',
    data:{
        bigBannersData:null
    },
    created:function () {
        let pthis=this;
        axios.get('/caseapi/selCaseDataList?currenPage=1&size=10&cid=40&chid=7').then(
            function (res) {
                console.log(res.data);
                pthis.bigBannersData=res.data.list;
                console.log('首页大图变换数据'+pthis.bigBannersData.length);
                let arr_indextranbigpic=[];
                if(pthis.bigBannersData!=null&&pthis.bigBannersData.length>0)
                {
                    console.log('有变换大图数据');
                    for(let i=0;i<pthis.bigBannersData.length;i++)
                    {
                        let __img_url='';
                        if(pthis.bigBannersData[i].img_url!=null&&pthis.bigBannersData[i].img_url!=''&&pthis.bigBannersData[i].img_url.length>0)
                        {
                            __img_url=pthis.bigBannersData[i].img_url.split(',')[0];
                        }
                        let __link_url='/banner/'+pthis.bigBannersData[i].id+'.html';
                        if(pthis.bigBannersData[i].link_url!=null&&pthis.bigBannersData[i].link_url!='')__link_url=pthis.bigBannersData[i].link_url;
                        arr_indextranbigpic.push('<li  data-bg="'+__img_url+'"  data-load="no"><a href="'+__link_url+'" target="_blank"></a></li>');
                    }
                }
                console.log('要插入的大图变换：');
                console.log(arr_indextranbigpic);
                if(arr_indextranbigpic.length>0)
                {
                    console.log('开始插入数据到页面');
                    let bigBannersBody='    <div class="hd">\n'+
                        '        <ul class="clear"></ul>\n'+
                        '    </div>\n'+
                        '    <div class="bd">\n'+
                        '        <ul>'+arr_indextranbigpic.join('')+'</ul>\n'+
                        '    </div>\n'+
                        '    <a class="btn-prev arrow"><span></span></a>\n'+
                        '    <a class="btn-next arrow"><span></span></a>';
                    console.log('要插入数据的HTML代码：');
                    console.log(bigBannersBody);
                    document.getElementById('bigBanners').innerHTML=bigBannersBody;
                    $(".banner").slide({
                        mainCell: ".bd ul",
                        prevCell: ".btn-prev",
                        nextCell: ".btn-next",
                        titCell: ".hd ul",
                        autoPlay: !0,
                        autoPage: !0,
                        effect: "fold",
                        interTime: 3e3,
                        delayTime: 1e3,
                        mouseOverStop: !1,
                        mouseOverStop: !0,
                        startFun: function(a) {
                            var c = $(".banner .bd li").eq(a);
                            "no" == c.attr("data-load") && (c.css("backgroundImage", "url(" + c.attr("data-bg") + ")"), c.attr("data-load", "yes"))
                        },
                        endFun: function(a) {
                            var c = $(".banner .bd li").eq(a + 1);
                            "no" == c.attr("data-load") && setTimeout(function() {
                                    c.attr("data-load", "yes"),
                                        c.css("backgroundImage", "url(" + c.attr("data-bg") + ")")
                                },
                                3e3)
                        }
                    })
                }
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});

let app_slide=new Vue({
    el:'#app_slide',
    data:{
        smallSlideData:null
    },
    created:function () {
        let pthis=this;
        axios.get('/caseapi/selCaseDataList?currenPage=1&size=10&cid=174&chid=7').then(
            function (res) {
                console.log(res.data);
                pthis.smallSlideData=res.data.list;
                console.log('首页小图变换数据'+pthis.smallSlideData.length);
                let arr_indextransmallpic=[];
                if(pthis.smallSlideData!=null&&pthis.smallSlideData.length>0)
                {
                    console.log('有变换小图数据');
                    for(let i=0;i<pthis.smallSlideData.length;i++)
                    {
                        let __img_url='';
                        if(pthis.smallSlideData[i].img_url!=null&&pthis.smallSlideData[i].img_url!=''&&pthis.smallSlideData[i].img_url.length>0)
                        {
                            __img_url=pthis.smallSlideData[i].img_url.split(',')[0];
                        }
                        arr_indextransmallpic.push('<li><a href="'+pthis.smallSlideData[i].link_url+'" target="_blank"><img src="'+__img_url+'"/></a></li>');
                    }
                }
                console.log('要插入的小图变换：');
                console.log(arr_indextransmallpic);
                if(arr_indextransmallpic.length>0)
                {
                    console.log('开始插入数据到页面');
                    let smallSlideBody='    <div class="bd">\n'+
                        '        <ul>'+arr_indextransmallpic.join('')+'</ul>\n'+
                        '    </div>\n'+
                        '    <div class="hd">\n'+
                        '        <ul></ul>\n'+
                        '    </div>\n'+
                        '    <a class="prev" href="javascript:void(0)"></a>\n'+
                        '    <a class="next" href="javascript:void(0)"></a>';
                    console.log('要插入数据的HTML代码：');
                    console.log(smallSlideBody);
                    document.getElementById('app_slide').innerHTML=smallSlideBody;
                    $(".slide").slide({
                        titCell: ".hd ul",
                        mainCell: ".bd ul",
                        effect: "fade",
                        vis: "auto",
                        autoPlay: !0,
                        autoPage: !0,
                        trigger: "mouseover",
                        switchLoad: "_src",
                        interTime: 5e3,
                        delayTime: 800,
                        mouseOverStop: !0
                    })
                }
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});

let app_indexMiddleAD=new Vue({
    el:'#app_indexMiddleAD',
    data:{
        pic:'',
        articleCategoryWithBLOBs:null,
        subTitle:'',
        content:'<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>',
        bg:'',
        zhaiyao:'',
        id:0
    },
    created:function () {
        let pthis=this;
        axios.get('/caseapi/queryCategoryDetails?cid=177').then(
            function (res) {
                console.log('首页中部广告图（图片2560x1155）');
                console.log(res.data);
                pthis.articleCategoryWithBLOBs=res.data.articleCategoryWithBLOBs;
                pthis.pic=res.data.singpic;
                pthis.subTitle=res.data.articleCategoryWithBLOBs.subTitle;
                pthis.content=res.data.articleCategoryWithBLOBs.content;
                pthis.bg=res.data.singpic;
                pthis.zhaiyao=res.data.articleCategoryWithBLOBs.zhaiyao;
                pthis.id=res.data.articleCategoryWithBLOBs.id;
            }
        ).catch(function (error) { // 请求失败处理
            console.log(error);
        });
    }
});
