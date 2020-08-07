function fileUploadComponent(imgClickTag, upimagesTag,saveUrlArg,delUrlArg,uploadUrlArg,up_upFilesArg,showTypeArg,loadingimgArg) {
    var imgClick = '';
    var upimages = '';
    var saveUrl='';
    var delUrl='';
    var uploadUrl='';
    var up_upFiles=[];
    var delimgid='';
    var showType='';
    var loadingimg='';

    var uploadImg = function (element) {
        var file = element.files[0];
        var $elemt = $(element);
        var $parent = $elemt.parent();
        var imgFileSize = file.size;
        var loadingImgSrc = loadingimg;
        if (imgFileSize > 10 * 1024 * 1024) {
            alert('上传的图片不超过10M');
        } else {
            var uploadComplete = function (evt) {
                console.log(evt.target.responseText);
                //alert(evt.target.responseText);
                var resJson = JSON.parse(evt.target.responseText).upFileInfos;
                if (resJson == null || resJson == undefined) resJson = JSON.parse(evt.target.responseText).result;
                if (resJson != null && resJson != undefined && resJson.length > 0)
                    for (var i = 0; i < resJson.length; i++) {
                        if (resJson[i].id != '') {
                            up_upFiles.push({
                                id: resJson[i].id,
                                size: resJson[i].size,
                                oName: resJson[i].oName,
                                nName: resJson[i].url,
                                msg: resJson[i].msg,
                                type:resJson[i].type
                            });

                            //对相应的对象进行赋值 开始
                            var objectOid = $('#' + $(element).attr("oid"));
                            if (objectOid != null && objectOid != undefined) {
                                var oNames = [];
                                for (var k = 0; k < up_upFiles.length; k++) {
                                    oNames.push(up_upFiles[k].nName);
                                }
                                objectOid.val(oNames.join(','));
                            }
                            //结束

                            $.ajax(
                                {
                                    type: "POST",
                                    url: saveUrl,
                                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                    data: {'uid': $(element).attr("uid"), 'oid': $('#' + $(element).attr("oid")).val()},
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

                            if (up_upFiles.length >= $(element).attr("unum")) {
                                $(imgClick).attr("style", "display:none");
                            } else {
                                $(imgClick).attr("style", "display:");
                            }
                            console.log('$(imgClick)>>'+imgClick);
                            console.log('up_upFiles.length>>'+up_upFiles.length);
                            if(showType=='type')
                            {
                                $(imgClick).prev().children(":first").attr("src", resJson[i].type);
                            }
                            else
                            {
                                $(imgClick).prev().children(":first").attr("src", resJson[i].url);
                            }
                            $(imgClick).prev().children(":first").attr("alt", resJson[i].url);
                            $(imgClick).prev().children(":first").attr("id", resJson[i].id);
                            $('#'+delimgid+'.up-delImg').off('click').on('click', function () {
                                console.log('$(imgClick)>>'+imgClick);
                                console.log('up_upFiles.length>>'+up_upFiles.length);
                                var $self = $(this);
                                for (var j = 0; j < up_upFiles.length; j++) {
                                    if (up_upFiles[j].id == $self.parent().children(":first").attr('id')) {
                                        up_upFiles.splice(j, 1);
                                    }
                                }
                                $self.parent().remove();

                                //对相应的对象进行赋值 开始
                                var objectOid = $('#' + $(element).attr("oid"));
                                if (objectOid != null && objectOid != undefined) {
                                    var oNames = [];
                                    for (var k = 0; k < up_upFiles.length; k++) {
                                        oNames.push(up_upFiles[k].nName);
                                    }
                                    objectOid.val(oNames.join(','));
                                }
                                //结束

                                if (up_upFiles.length >= $(element).attr("unum")) {
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
                                        'oid': $('#' + $(element).attr("oid")).val()
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
                    }
            };
            var uploadFailed = function (evt) {
                alert('Net error.');
            };
            $(imgClick).attr("style", "display:none");
            $(imgClick).before('<li><img alt="" class="imsg" src="' + loadingImgSrc + '"/><i id="'+delimgid+'" class="up-delImg">-</i></li>');
            var fd = new FormData();
            fd.append("refObj", "rescueorder");
            fd.append("refField", "refField");
            fd.append("refId", "refId");
            fd.append('metaFile', file);
            var xhr = new XMLHttpRequest();
            xhr.addEventListener('load', uploadComplete, false);
            xhr.addEventListener('error', uploadFailed, false);
            xhr.open('POST', uploadUrl+'?fdic=' + $(element).attr("savepath"), true);
            xhr.setRequestHeader('dataSource', '1');
            xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
            xhr.withCredentials = true;
            xhr.setRequestHeader("Accept", "*/*");
            xhr.send(fd);
        }
        element.value = '';
    };

    this.initheadPicList=function(upfiles, element) {
        if (upfiles != null && upfiles != undefined && upfiles.length > 0) {
            //$("#headPicList").children().filter("li").remove();
            for (var k = 0; k < upfiles.length; k++) {
                $(imgClick).before('<li><img id="' + upfiles[k].id + '" alt="' + upfiles[k].nName + '" class="imsg" src="' + (showType=='type'?upfiles[k].type:upfiles[k].url) + '"/><i id="'+delimgid+'" class="up-delImg">-</i></li>');
                if (up_upFiles.length >= $(element).attr("unum")) {
                    $(imgClick).attr("style", "display:none");
                } else {
                    $(imgClick).attr("style", "display:");
                }
            }
            $('#'+delimgid+'.up-delImg').off('click').on('click', function () {
                var $self = $(this);
                for (var j = 0; j < up_upFiles.length; j++) {
                    if (up_upFiles[j].id == $self.parent().children(":first").attr('id')) {
                        up_upFiles.splice(j, 1);
                    }
                }
                $self.parent().remove();

                //对相应的对象进行赋值 开始
                var objectOid = $('#' + $(element).attr("oid"));
                if (objectOid != null && objectOid != undefined) {
                    var oNames = [];
                    for (var k = 0; k < up_upFiles.length; k++) {
                        oNames.push(up_upFiles[k].nName);
                    }
                    objectOid.val(oNames.join(','));
                }
                //结束

                if (up_upFiles.length >= $(element).attr("unum")) {
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
                        'oid': $('#' + $(element).attr("oid")).val()
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

    var init = function () {
        imgClick = imgClickTag;
        upimages = upimagesTag;
        saveUrl=saveUrlArg;
        delUrl=delUrlArg;
        uploadUrl=uploadUrlArg;
        up_upFiles=up_upFilesArg;
        delimgid='del'+imgClick.replace('#','');
        showType=showTypeArg;
        loadingimg=loadingimgArg;
        $(imgClick).click(function () {
            $(upimages).click();
        });
        $(upimages).change(function () {
            uploadImg(this);
        });
    };
    init();
}
