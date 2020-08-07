<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-07-09
  Time: 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/inc/headincludesfiles"/>
    <style>
        .fborder{
            border: 1px solid #ff253a;
            /*background: rgba(255,0,0,0.1);*/
        }
        .myerr{
            color: #ff253a;
        }
    </style>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="modalwintip" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">{{title}}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body"  v-html="tipcontent">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/inc/mainmenus"/>
<div class="body-width mt-5">
    <div class="row row-cols-1">
        <div class="col ck-content">
            ${categoryData.articleCategoryWithBLOBs.content}
        </div>
    </div>
    <div class="row row-cols-1 mt-5">
        <div class="col" >
            <div class="row">
                <div class="col text-center">
                    <h2 class="font-weight-bold text-white" style="font-size: calc(1em + 1vw);">马上申请加盟 开店享补贴</h2>
                    <h6 class="text-muted">请填写您的有效信息，招商经理将主动与您联系</h6>
                </div>
            </div>
            <div class="row mt-3" id="app_contact_leave_message">
                <form class="w-100">
                        <div class="form-group pt-3">
                            <label for="txtName" class="text-white">姓名<span class="text-danger">*</span>：</label>
                            <input :class="{fborder:t_name}" type="text" placeholder="请填写您的姓名" :title="t_name==true?'请填写您的姓名！':''" v-model.trim="f_name" class="form-control" id="txtName">
                        </div>
                        <div class="form-group pt-3">
                            <label for="txtemail" class="text-white">联系电话<span class="text-danger">*</span>：</label>
                            <input :class="{fborder:t_email}"  type="email" placeholder="请填写您的联系电话" :title="t_email==true?'请填写您的联系电话！':''" v-model.trim="f_email" class="form-control" id="txtemail">
                        </div>
                    <div class="form-group pt-3">
                        <label for="txttel" class="text-white">加盟区域<span class="text-danger">*</span>：</label>
                        <input :class="{fborder:t_tel}"  type="text" :title="t_tel==true?'请填写您的加盟区域！':''" class="form-control" v-model.trim="f_tel"  id="txttel" placeholder="请填写您的加盟区域，如福建省厦门思明区xxxx路">
                    </div>
                    <div class="form-group pt-3">
                        <label for="txtcontents" class="text-white">资金预算<span class="text-danger">*</span>：</label>
                        <input :class="{fborder:t_contents}"   :title="t_contents==true?'请填写您的资金预算！':''" id="txtcontents" v-model.trim="f_contents" class="form-control" placeholder="请填写您的资金预算">
                    </div>
                    <div class="form-group pt-3">
                        <div class="row">
                            <div class="col-5"><input :class="{fborder:t_codecheck}"   v-model.trim="f_codecheck" :title="t_codecheck==true?codecheckmsg:''" placeholder="验证码" class="form-control" type="text" id="txtCodeCheck"></div>
                            <div class="col-7 text-left align-self-center">
                                <img alt="点击刷新" src="/authCode.do"
                                     name="Image1"
                                     title="不清楚，点击获取新的验证码！"
                                     border="0"
                                     align="absmiddle"
                                     id="Image1"
                                     style="CURSOR: pointer"
                                     onclick="document.getElementById('Image1').src='/authCode.do?rdm='+Math.random();"/>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start pt-3">
                        <button type="button" @click="submitLeaveMessage()"  class="btn btn-warning">申请加盟</button>
                        <div class="align-self-center ml-5 myerr">{{msg_tip}}</div>
                    </div>
                </form>
            </div>
            <script type="text/javascript">
                let modalwintip=new Vue({
                    el:'#modalwintip',
                    data:{
                        tipcontent:'',
                        title:''
                    }
                });
                let leaveMessage=new Vue({
                    el:'#app_contact_leave_message',
                    data:{
                        f_name:'',
                        f_email:'',
                        f_tel:'',
                        f_contents:'',
                        f_codecheck:'',
                        t_name:false,
                        t_email:false,
                        t_tel:false,
                        t_contents:false,
                        t_codecheck:false,
                        codecheckmsg:'请填写验证码！',
                        msg_tip:''
                    },
                    watch:{
                        f_codecheck:function (val) {
                            this.f_codecheck=val;
                        }
                    },
                    methods:{
                        submitLeaveMessage:function () {
                            console.log('开始提交申请加盟');
                            let pthis=this;
                            if(this.f_name=='')this.t_name=true;
                            if(this.f_email=='')this.t_email=true;
                            if(this.f_tel=='')this.t_tel=true;
                            if(this.f_contents=='')this.t_contents=true;
                            if(this.f_codecheck=='')this.t_codecheck=true;
                            if(!this.t_name&&!this.t_email&&!this.t_tel&&!this.t_contents&&!this.t_codecheck)
                            {
                                this.msg_tip='';
                                var param=new URLSearchParams();
                                param.append('name', this.f_name);
                                param.append('email',this.f_email);
                                param.append('tel',this.f_tel);
                                param.append('contents',this.f_contents);
                                param.append('codecheck',this.f_codecheck);
                                axios({
                                    method: 'post',
                                    url: '/caseapi/saveLeaveMessage',
                                    data: param
                                }).then(function (res) {
                                    console.log("申请加盟保存结果：");
                                    console.log(res.data);
                                    if(res.data==null||res.data.length<=0)
                                    {
                                        pthis.msg_tip='';
                                        modalwintip.tipcontent='欢迎来到白大师<br/>您的申请加盟资料已提交，招商经理将主动与您联系！';
                                        modalwintip.title='申请加盟提示';
                                        let mwt=$('#modalwintip');
                                        mwt.modal('show');
                                        mwt.on('hidden.bs.modal', function (e) {
                                            window.location='/';
                                        })
                                    }
                                }).catch(function (error) { // 请求失败处理
                                    console.log(error);
                                });
                            }
                            else
                            {
                                this.msg_tip='申请加盟表单资料填写有误！';
                            }
                        }
                    }
                });
                leaveMessage.$watch('f_name',function (nv, ov) {
                    this.msg_tip='';
                    if(nv=='')leaveMessage.t_name=true;else leaveMessage.t_name=false;
                });
                leaveMessage.$watch('f_email',function (nv, ov) {
                    this.msg_tip='';
                    if(nv=='')leaveMessage.t_email=true;else leaveMessage.t_email=false;
                });
                leaveMessage.$watch('f_tel',function (nv, ov) {
                    this.msg_tip='';
                    if(nv=='')leaveMessage.t_tel=true;else leaveMessage.t_tel=false;
                });
                leaveMessage.$watch('f_contents',function (nv, ov) {
                    this.msg_tip='';
                    if(nv=='')leaveMessage.t_contents=true;else leaveMessage.t_contents=false;
                });
                leaveMessage.$watch('f_codecheck',function (nv, ov) {
                    leaveMessage.t_codecheck=false;
                    this.msg_tip='';
                    if(nv=='')
                    {
                        leaveMessage.t_codecheck=true;
                        leaveMessage.codecheckmsg='请填写验证码！';
                    }else
                    {
                        axios.get('/checkcode?vcode='+leaveMessage.f_codecheck).then(
                            function (res) {
                                console.log('验证码结课输出：')
                                console.log(res.data);
                                if(res.data=='0')
                                {
                                    leaveMessage.codecheckmsg='验证码填写有误！';
                                    leaveMessage.t_codecheck=true;
                                }
                                else
                                {
                                    leaveMessage.t_codecheck=false;
                                }
                            }
                        ).catch(function (error) { // 请求失败处理
                            console.log(error);
                        });
                    }
                });
            </script>
        </div>
    </div>
</div>
<jsp:include page="/inc/footer"/>
</body>
</html>
