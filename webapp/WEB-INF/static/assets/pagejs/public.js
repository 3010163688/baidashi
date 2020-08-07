function ckedit5init(initid) {
    console.log('Article content init ID:'+initid);
    var data;
    DecoupledEditor
        .create(document.querySelector(initid), {}).then(editor=>{
    editor.isReadOnly=true;
    window.editor=editor;
    data = editor.getData();
    console.log(data);
}).catch(err=>{
        console.error(err.stack);
});}
function ckedit5init_elo(elo) {
    var data;
    DecoupledEditor
        .create(elo, {}).then(editor=>{
        editor.isReadOnly=true;
    window.editor=editor;
    data = editor.getData();
    console.log(data);
}).catch(err=>{
        console.error(err.stack);
});}
let dtmixin={
    methods: {
        formatTime: function (number, format) {// 参数number为毫秒时间戳，format为需要转换成的日期格式
            let time=new Date(number)
            let newArr=[]
            let formatArr=['Y', 'M', 'D', 'h', 'm', 's']
            newArr.push(time.getFullYear())
            newArr.push(this.formatNumber(time.getMonth()+1))
            newArr.push(this.formatNumber(time.getDate()))

            newArr.push(this.formatNumber(time.getHours()))
            newArr.push(this.formatNumber(time.getMinutes()))
            newArr.push(this.formatNumber(time.getSeconds()))

            for (let i in newArr) {
                format=format.replace(formatArr[i], newArr[i])
            }
            return format;
        },
        formatNumber: function (n) {// 格式化日期，如月、日、时、分、秒保证为2位数
            n=n.toString()
            return n[1] ? n : '0'+n;
        },
        fileSignOrMul:function(files,arg1,arg2){
            let imgUrls=files;
            imgUrls=files==null||files==undefined?"":files.trim();
            let listImgUrls=[];
            if(imgUrls!="")
            {
                let imgs=imgUrls.split(',');
                for(let i=0;i<imgs.length;i++)
                {
                    listImgUrls.push(imgs[i]);
                }
            }
            else
            {
                if(arg2==0)
                {
                    listImgUrls.push("/static/imgs/uploaderimgs/placeholder.jpg");
                }
            }
            if(arg1==2)return listImgUrls;
            else return listImgUrls[0];
        }
    }
};


function categorydetaillist(elid, cp, size, pcid, chid, an, logmsg, funcreated) {
    let app_designs=new Vue({
        el: elid,
        data: {
            seldata: null,
            resdata:null
        },
        created: function () {
            let pthis=this;
            axios.get('/caseapi/queryCategoryAndDetails?currenPage='+cp+'&size='+size+'&pcid='+pcid+'&chid='+chid+'&articleNum='+an).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.seldata=res.data.list;
                    pthis.resdata=res.data;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        updated:function () {
            let pthis=this;
            if (funcreated) {
                funcreated(pthis.data);
            }
        }
    });
}

function signarticleinit(elid, aid, logmsg, funcreated) {
    let signarticlevue=new Vue({
        el: elid,
        data: {
            articledata: null,
            pic: '',
            subTitle: '',
            pics: null,
            content: '<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>',
            singAttachment: '',
            attachments: null,
            title: '',
            add_time: '',
            zhaiyao: '',
            id: aid,
            isHide: true,    //初始值为true，显示为折叠画面
            isFirstInit:true,
            isShowHideBtn:true, //是否显示收起内容按钮
            preDatas:null,
            nextDatas:null
        },
        mixins: [dtmixin],
        created: function () {
            let pthis=this;
            axios.get('/caseapi/queryArticleDetails?aid='+aid).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.articledata=res.data.articleWithBLOBs;
                    pthis.pic=res.data.singpic;
                    pthis.subTitle=res.data.articleWithBLOBs.subTitle;
                    pthis.content=res.data.articleWithBLOBs.contents;
                    pthis.pics=res.data.pics;
                    pthis.singAttachment=res.data.singAttachment;
                    pthis.attachments=res.data.attachments;
                    pthis.title=res.data.articleWithBLOBs.title;
                    pthis.add_time=pthis.formatTime(res.data.articleWithBLOBs.add_time, 'Y-M-D');
                    pthis.zhaiyao=res.data.articleWithBLOBs.zhaiyao;
                    console.log("上一条数据和下一条数据输出：");
                    console.log(res.data.preDatas);
                    console.log(res.data.nextDatas);
                    pthis.preDatas=res.data.preDatas;
                    pthis.nextDatas=res.data.nextDatas;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        updated:function () {
            let pthis=this;
            if (funcreated) {
                funcreated(pthis.articledata, pthis.pic, pthis.subTitle, pthis.content, pthis.pics, pthis.singAttachment, pthis.attachments,pthis);
            }
        },
        methods:{
            onShow: function(){
                this.isHide = false;    //点击onShow切换为false，显示为展开画面
            },
            onHide: function(){
                this.isHide = true;    //点击onHide切换为true，显示为折叠画面

            }
        }
    });
}

function signcategoryinit(elid, cid, logmsg, funcreated) {
    let appvue=new Vue({
        el: elid,
        data: {
            pic: '',
            articleCategoryWithBLOBs: null,
            subTitle: '',
            content: '<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>',
            zhaiyao: '',
            resdata:null,
            attachments:null
        },
        mixins: [dtmixin],
        created: function () {
            let pthis=this;
            axios.get('/caseapi/queryCategoryDetails?cid='+cid).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.articleCategoryWithBLOBs=res.data.articleCategoryWithBLOBs;
                    pthis.pic=res.data.singpic;
                    pthis.subTitle=res.data.articleCategoryWithBLOBs.subTitle;
                    pthis.content=res.data.articleCategoryWithBLOBs.content;
                    pthis.zhaiyao=res.data.articleCategoryWithBLOBs.zhaiyao;
                    pthis.resdata=res.data;
                    pthis.attachments=res.data.attachments;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        updated:function () {
            let pthis=this;
            if (funcreated) {
                funcreated(pthis.resdata);
            }
        }
    });
}

function categoryinit(elid, status, pcid, logmsg) {
    let app_footer_case=new Vue({
        el: elid,
        data: {
            tjdata: null
        },
        created: function () {
            let pthis=this;
            axios.get('/caseapi/queryCategoryBySatusAndPid?status='+status+'&pcid='+pcid).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.tjdata=res.data;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        }
    });
}


function articleinit(elid, status, categoryid, logmsg, funcreated) {
    let app_footer_case=new Vue({
        el: elid,
        data: {
            tjdata: null
        },
        created: function () {
            let pthis=this;
            axios.get('/caseapi/queryArticleByStatusAndCategoryId?status='+status+'&categoryid='+categoryid).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.tjdata=res.data;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        updated:function () {
            let pthis=this;
            if (funcreated) {
                funcreated(pthis.tjdata);
            }
        }
    });
}

function caseshow(elid, currenPage, size1, cid, chid,status1,tys1) {
    if(status1==null||status1==undefined) status1="";
    if(tys1==null||tys1==undefined) tys1="";
    let appcaseslist=new Vue({
        el: elid,
        data: {
            caselist: null,
            casecategory: null,
            casecategorylen: 0,
            dcid: cid,
            total: 0,
            size: 0,
            pages: 0,
            pageNum: 0,
            hasp: false,
            hasn: false,
            navigatepageNums: [],
            currenPage: currenPage,
            size1: size1,
            cid: cid,
            chid: chid,
            status:status1,
            tys:tys1
        },
        mixins: [dtmixin],
        created: function () {
            let pthis=this;
            axios.get('/caseapi/selCaseDataList?currenPage='+pthis.currenPage+'&size='+pthis.size1+'&cid='+pthis.cid+'&chid='+pthis.chid+'&status='+pthis.status+'&tys='+pthis.tys).then(
                function (res) {
                    console.log('案例数据');
                    console.log(res.data);
                    pthis.caselist=res.data.list;
                    pthis.total=res.data.total;
                    pthis.size=res.data.size;
                    pthis.pages=res.data.pages;
                    pthis.pageNum=res.data.pageNum;
                    pthis.hasp=res.data.hasPreviousPage;
                    pthis.hasn=res.data.hasNextPage;
                    pthis.navigatepageNums=res.data.navigatepageNums;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });

            axios.get('/caseapi/selCaseCategoryList?currenPage='+pthis.currenPage+'&size='+pthis.size1+'&pcid='+pthis.cid+'&chid='+pthis.chid).then(
                function (res) {
                    console.log('案例类别');
                    console.log(res.data);
                    pthis.casecategory=res.data.list;
                    pthis.casecategorylen=res.data.list.length;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        methods: {
            page: function (cp) {
                let pthis=this;
                axios.get('/caseapi/selCaseDataList?currenPage='+cp+'&size='+pthis.size1+'&cid='+pthis.cid+'&chid='+pthis.chid+'&status='+pthis.status+'&tys='+pthis.tys).then(
                    function (res) {
                        console.log('案例数据');
                        console.log(res.data);
                        pthis.caselist=res.data.list;
                        pthis.dcid=cid;
                        pthis.total=res.data.total;
                        pthis.size=res.data.size;
                        pthis.pages=res.data.pages;
                        pthis.pageNum=res.data.pageNum;
                        pthis.hasp=res.data.hasPreviousPage;
                        pthis.hasn=res.data.hasNextPage;
                        pthis.navigatepageNums=res.data.navigatepageNums;
                    }
                ).catch(function (error) { // 请求失败处理
                    console.log(error);
                });
            },
            cdc: function (cid) {
                let pthis=this;
                axios.get('/caseapi/selCaseDataList?currenPage=1&size='+pthis.size1+'&cid='+cid+'&chid='+pthis.chid+'&status='+pthis.status+'&tys='+pthis.tys).then(
                    function (res) {
                        console.log('案例数据');
                        console.log(res.data);
                        pthis.caselist=res.data.list;
                        pthis.dcid=cid;
                        pthis.total=res.data.total;
                        pthis.size=res.data.size;
                        pthis.pages=res.data.pages;
                        pthis.pageNum=res.data.pageNum;
                        pthis.hasp=res.data.hasPreviousPage;
                        pthis.hasn=res.data.hasNextPage;
                        pthis.navigatepageNums=res.data.navigatepageNums;
                    }
                ).catch(function (error) { // 请求失败处理
                    console.log(error);
                });
            }
        }
    });
}
function selCaseDataList(elid, currenPage, size1, cid, chid,logmsg,status1,tys1) {
    if(status1==null||status1==undefined) status1="";
    if(tys1==null||tys1==undefined) tys1="";
    let zzpz = new Vue({
        el: elid,
        data: {
            datalist: null,
            total: 0,
            size: 0,
            pages: 0,
            pageNum: 0,
            hasp: false,
            hasn: false,
            navigatepageNums: [],
            currenPage: currenPage,
            size1: size1,
            cid: cid,
            chid: chid,
            status:status1,
            tys:tys1
        },
        mixins: [dtmixin],
        created: function () {
            let pthis = this;
            axios.get('/caseapi/selCaseDataList?currenPage='+pthis.currenPage+'&size='+pthis.size1+'&cid='+pthis.cid+'&chid='+pthis.chid+'&status='+pthis.status+'&tys='+pthis.tys).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.datalist=res.data.list;
                    pthis.total=res.data.total;
                    pthis.size=res.data.size;
                    pthis.pages=res.data.pages;
                    pthis.pageNum=res.data.pageNum;
                    pthis.hasp=res.data.hasPreviousPage;
                    pthis.hasn=res.data.hasNextPage;
                    pthis.navigatepageNums=res.data.navigatepageNums;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        methods: {}
    });
}

function selCaseCategoryList(elid,currenPage,size1,cid,chid,logmsg) {
    let categoryList=new Vue({
        el:elid,
        data: {
            datalist: null,
            total: 0,
            size: 0,
            pages: 0,
            pageNum: 0,
            hasp: false,
            hasn: false,
            navigatepageNums: [],
            currenPage: currenPage,
            size1: size1,
            cid: cid,
            chid: chid
        },
        mixins: [dtmixin],
        created: function () {
            let pthis=this;
            axios.get('/caseapi/selCaseCategoryList?currenPage='+pthis.currenPage+'&size='+pthis.size1+'&pcid='+pthis.cid+'&chid='+pthis.chid).then(
                function (res) {
                    console.log(logmsg);
                    console.log(res.data);
                    pthis.datalist=res.data.list;
                    pthis.total=res.data.total;
                    pthis.size=res.data.size;
                    pthis.pages=res.data.pages;
                    pthis.pageNum=res.data.pageNum;
                    pthis.hasp=res.data.hasPreviousPage;
                    pthis.hasn=res.data.hasNextPage;
                    pthis.navigatepageNums=res.data.navigatepageNums;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        }
    });
}
// articleinit('#app_footer_about', 1, 14, '底部推荐导航数据：关于');
// categoryinit('#app_footer_contact', 1, 138, '底部推荐导航数据：联系');
// categoryinit('#app_footer_case', 1, 4, '底部推荐导航数据：案例');
// categoryinit('#app_footer_dynamic', 1, 25, '底部推荐导航数据：行业动态');
// signcategoryinit('#app_mainmenus', 50, '前端顶部菜单左边LOGO（图片140 x28）');
// signcategoryinit('#app_QRcode', 176, '前端底部左边二维码（图片102x102）');
// signcategoryinit('#app_footlogo', 175, '前端底部左边LOGO（图片125 x28）',function () {
//     ckedit5init('#app_footlogo_content');
// });
// signcategoryinit('#app_copyright', 60, '前端底部右边版权',function () {
//     ckedit5init('#app_copyright_content');
// });
