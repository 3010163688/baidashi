function ckselfile(imgClickTag, upimagesTag, saveUrlArg, delUrlArg, uploadUrlArg, up_upFilesArg, showTypeArg, loadingimgArg) {
    var imgClick='';
    var upimages='';
    var saveUrl='';
    var delUrl='';
    var uploadUrl='';
    var up_upFiles=[];
    var delimgid='';
    var showType='';
    var loadingimg='';
    var fftf=null;
    this.filetypefail=function (__o_fftf) {
        fftf=__o_fftf;
    };

    var selckf=function (element) {
        CKFinder.modal({
            chooseFiles: true,
            width: 800,
            height: 500,
            onInit: function (finder) {
                finder.on('files:choose', function (evt) {
                    var loadingImgSrc=loadingimg;
                    var files=evt.data.files;
                    var errMsg='';
                    var fextMsg='';
                    var err_upFiles=[];
                    //获取要验证的文件扩展名
                    //console.log('valiteFext数据类型：'+(typeof valiteFext=='string'));
                    var valiteFextStr=$(element).attr("fexts");
                    console.log(valiteFextStr);
                    if (typeof valiteFextStr=='string') valiteFextStr=valiteFextStr.trim();
                    else valiteFextStr='';
                    if (valiteFextStr!='') {
                        try {
                            var valiteFextObj=JSON.parse(valiteFextStr);
                            if (valiteFextObj!=null||valiteFextObj!=undefined) {
                                fextMsg=eval(valiteFextObj.fext);
                                errMsg=valiteFextObj.msg;
                            }
                        } catch (e) {
                            console.log('验证扩展名异常：')
                            console.log(e.message);
                            fextMsg='';
                            errMsg='';
                        }
                    }

                    console.log('标签对象：'+element);
                    console.log('要验证的文件扩展名信息：'+valiteFextStr);
                    console.log('验证字符串处理信息：');
                    console.log(fextMsg);
                    console.log(errMsg);

                    try {
                        files.forEach(
                            function (f, i) {
                                console.log(f.get('name')+','+f.get('date')+','+f.get('url')+','+f.get('size')+','+f._extenstion);
                                var __rds0001=parseInt(Math.random()*(100000+1));//获取0-N的随机数
                                var _p_id=f.get('date')+'-'+__rds0001+'-'+f.get('size');
                                var _p_size=f.get('size');
                                var _p_oName=f.get('name');
                                var _p_nName=f.get('url');
                                var _p_msg='从ckfinder选择文件';
                                var _p_type='/static/icons/48/'+f._extenstion+'.png';
                                if (fextMsg==''||fextMsg.test(f._extenstion)) {
                                    console.log("合格的扩展名文件"+f._extenstion);
                                    $(imgClick).attr("style", "display:none");
                                    $(imgClick).before('<li><img alt="" class="imsg" src="'+loadingImgSrc+'"/><i id="'+delimgid+'" class="up-delImg">-</i></li>');
                                    if (_p_id!=''&&_p_id!=null&&_p_id!=undefined) {
                                        up_upFiles.push({
                                            id: _p_id,
                                            size: _p_size,
                                            oName: _p_oName,
                                            nName: _p_nName,
                                            msg: _p_msg,
                                            type: _p_type
                                        });

                                        //对相应的对象进行赋值 开始
                                        var objectOid=$('#'+$(element).attr("oid"));
                                        if (objectOid!=null&&objectOid!=undefined) {
                                            var oNames=[];
                                            for (var k=0; k<up_upFiles.length; k++) {
                                                oNames.push(up_upFiles[k].nName);
                                            }
                                            objectOid.val(oNames.join(','));
                                        }
                                        //结束


                                        if (up_upFiles.length>=$(element).attr("unum")) {
                                            $(imgClick).attr("style", "display:none");
                                        } else {
                                            $(imgClick).attr("style", "display:");
                                        }
                                        console.log('$(imgClick)>>'+imgClick);
                                        console.log('up_upFiles.length>>'+up_upFiles.length);
                                        if (showType=='type') {
                                            $(imgClick).prev().children(":first").attr("src", _p_type);
                                        } else {
                                            $(imgClick).prev().children(":first").attr("src", _p_nName);
                                        }
                                        $(imgClick).prev().children(":first").attr("alt", _p_nName);
                                        $(imgClick).prev().children(":first").attr("id", _p_id);
                                        $('#'+delimgid+'.up-delImg').off('click').on('click', function () {
                                            console.log('$(imgClick)>>'+imgClick);
                                            console.log('up_upFiles.length>>'+up_upFiles.length);
                                            var $self=$(this);
                                            for (var j=0; j<up_upFiles.length; j++) {
                                                if (up_upFiles[j].id==$self.parent().children(":first").attr('id')) {
                                                    up_upFiles.splice(j, 1);
                                                }
                                            }
                                            $self.parent().remove();

                                            //对相应的对象进行赋值 开始
                                            var objectOid=$('#'+$(element).attr("oid"));
                                            if (objectOid!=null&&objectOid!=undefined) {
                                                var oNames=[];
                                                for (var k=0; k<up_upFiles.length; k++) {
                                                    oNames.push(up_upFiles[k].nName);
                                                }
                                                objectOid.val(oNames.join(','));
                                            }
                                            //结束
                                            if (up_upFiles.length>=$(element).attr("unum")) {
                                                $(imgClick).attr("style", "display:none");
                                            } else {
                                                $(imgClick).attr("style", "display:");
                                            }
                                            $.ajax({
                                                type: "POST",
                                                url: delUrl,
                                                contentType: "application/x-www-form-urlencoded; charset=utf-8",//application/json;charset=utf-8或application/x-www-form-urlencoded; charset=utf-8
                                                data: {
                                                    'defFileName': $self.parent().children(":first").attr('alt'),
                                                    'uid': $(element).attr("uid"),
                                                    'oid': $('#'+$(element).attr("oid")).val()
                                                },
                                                dataType: "json",
                                                success: function (message) {
                                                    console.log("提交数据成功11：")
                                                    console.log(message);
                                                },
                                                error: function (message) {
                                                    console.log("提交数据失败：")
                                                    console.log(message);
                                                }
                                            });
                                            //alert($self.parent().children(":first").attr('id'));
                                        });
                                    }
                                } else {
                                    console.log('文件：'+_p_oName+'类型有误！');
                                    err_upFiles.push(_p_oName)
                                }
                                if (up_upFiles.length>=$(element).attr("unum")) {
                                    throw new Error("ending");//报错，就跳出循环
                                }
                            }
                        );
                    } catch (e) {
                        console.log(e.message);
                    }
                    $.ajax(
                        {
                            type: "POST",
                            url: saveUrl,
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            data: {'uid': $(element).attr("uid"), 'oid': $('#'+$(element).attr("oid")).val()},
                            dataType: "json",
                            success: function (message) {
                                console.log("提交数据成功：")
                                console.log(message);
                            },
                            error: function (message) {
                                console.log("提交数据失败：")
                                console.log(message);
                            }
                        }
                    );
                    if (err_upFiles.length>0) {
                        if(fftf==null||fftf==undefined||fftf=='')
                        {
                            alert(errMsg+":\r\n"+err_upFiles.join(',\r\n'));
                        }
                        else
                        {
                            fftf(errMsg+":\r\n"+err_upFiles.join(',\r\n'));
                        }

                    }
                });

                finder.on('file:choose:resizedImage', function (evt) {
                    var output=document.getElementById(elementId);
                    output.value=evt.data.resizedUrl;
                });
            }
        });
    };

    this.initheadPicList=function (upfiles, element) {
        if (upfiles!=null&&upfiles!=undefined&&upfiles.length>0) {
            //$("#headPicList").children().filter("li").remove();
            for (var k=0; k<upfiles.length; k++) {
                $(imgClick).before('<li><img id="'+upfiles[k].id+'" alt="'+upfiles[k].nName+'" class="imsg" src="'+(showType=='type' ? upfiles[k].type : upfiles[k].url)+'"/><i id="'+delimgid+'" class="up-delImg">-</i></li>');
                if (up_upFiles.length>=$(element).attr("unum")) {
                    $(imgClick).attr("style", "display:none");
                } else {
                    $(imgClick).attr("style", "display:");
                }
            }
            $('#'+delimgid+'.up-delImg').off('click').on('click', function () {
                var $self=$(this);
                for (var j=0; j<up_upFiles.length; j++) {
                    if (up_upFiles[j].id==$self.parent().children(":first").attr('id')) {
                        up_upFiles.splice(j, 1);
                    }
                }
                $self.parent().remove();

                //对相应的对象进行赋值 开始
                var objectOid=$('#'+$(element).attr("oid"));
                if (objectOid!=null&&objectOid!=undefined) {
                    var oNames=[];
                    for (var k=0; k<up_upFiles.length; k++) {
                        oNames.push(up_upFiles[k].nName);
                    }
                    objectOid.val(oNames.join(','));
                }
                //结束

                if (up_upFiles.length>=$(element).attr("unum")) {
                    $(imgClick).attr("style", "display:none");
                } else {
                    $(imgClick).attr("style", "display:");
                }
                $.ajax({
                    type: "POST",
                    url: delUrl,
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",//application/json;charset=utf-8或application/x-www-form-urlencoded; charset=utf-8
                    data: {
                        'defFileName': $self.parent().children(":first").attr('alt'),
                        'uid': $(element).attr("uid"),
                        'oid': $('#'+$(element).attr("oid")).val()
                    },
                    dataType: "json",
                    success: function (message) {
                        console.log("提交数据成功11：")
                        console.log(message);
                    },
                    error: function (message) {
                        console.log("提交数据失败：")
                        console.log(message);
                    }
                });
                //alert($self.parent().children(":first").attr('id'));
            });
        }
    };

    var init=function () {
        imgClick=imgClickTag;
        upimages=upimagesTag;
        saveUrl=saveUrlArg;
        delUrl=delUrlArg;
        uploadUrl=uploadUrlArg;
        up_upFiles=up_upFilesArg;
        delimgid='del'+imgClick.replace('#', '');
        showType=showTypeArg;
        loadingimg=loadingimgArg;
        $(imgClick).click(function () {
            selckf(upimages);
        });
    };
    init();
}
