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
            resdata:null
        },
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

function caseshow(elid, currenPage, size1, cid, chid) {
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
            showclist:false,
            showalist:false
        },
        mixins: [dtmixin],
        created: function () {
            let pthis=this;
            axios.get('/caseapi/selCaseDataList?currenPage='+pthis.currenPage+'&size='+pthis.size1+'&cid='+pthis.cid+'&chid='+pthis.chid).then(
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
                    pthis.showalist=true;
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
                    pthis.showclist=true;
                }
            ).catch(function (error) { // 请求失败处理
                console.log(error);
            });
        },
        methods: {
            page: function (cp) {
                let pthis=this;
                this.showclist=false;
                axios.get('/caseapi/selCaseDataList?currenPage='+cp+'&size='+pthis.size1+'&cid='+pthis.cid+'&chid='+pthis.chid).then(
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
                        pthis.showclist=true;
                    }
                ).catch(function (error) { // 请求失败处理
                    console.log(error);
                    pthis.showclist=true;
                    alert(error);
                });
            },
            cdc: function (cid) {
                let pthis=this;
                this.showclist=false;
                axios.get('/caseapi/selCaseDataList?currenPage=1&size='+pthis.size1+'&cid='+cid+'&chid='+pthis.chid).then(
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
                        pthis.showclist=true;
                    }
                ).catch(function (error) { // 请求失败处理
                    console.log(error);
                    pthis.showclist=true;
                    alert(error);
                });
            }
        }
    });
    return appcaseslist;
}
