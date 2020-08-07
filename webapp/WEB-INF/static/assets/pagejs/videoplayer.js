let currplayurl=0;
function play(video,vList) {
    video.src = vList[currplayurl];
    console.log('当前播放视频：'+video.src);
    video.load();
    video.play();
       //必须在微信Weixin JSAPI的WeixinJSBridgeReady才能生效
        document.addEventListener("WeixinJSBridgeReady", function () {
        video.play();
    }, false);
    currplayurl++;
    if(currplayurl >= vList.length){
        currplayurl = 0; //重新循环播放
    }
}
function playbodymodal(playVideoList,title,url) {
    console.log('播放窗口开始调用');
    if (playVideoList!=null&&playVideoList.length>0) {
        let arr_videofiles=[];
        for (let i=0; i<playVideoList.length; i++) {
            arr_videofiles.push(playVideoList[i]);
        }
        if(!document.getElementById('playwin')) {
            console.log('playwin被调用');
            let playwinmodal=document.createElement("div");
            playwinmodal.innerHTML='<div class="modal fade" id="playwin" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true">\n'+
                '    <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">\n'+
                '        <div class="modal-content bg-dark">\n'+
                '            <div class="modal-header text-white border-0">\n'+
                '                <h5 class="modal-title" id="exampleModalCenterTitle2">'+title+'</h5>\n'+
                '                <button   type="button" class="close" data-dismiss="modal" aria-label="Close">\n'+
                '                    <span  aria-hidden="true">&times;</span>\n'+
                '                </button>\n'+
                '            </div>\n'+
                '            <div class="modal-body" id="__modalbody__01">\n'+
                '                <video id="__video_01"  controls="controls" style="width: 100%;object-fit:fill;" preload="auto"  x5-video-player-type="h5" preload="metadata" playsinline="true"    webkit-playsinline="true"  x-webkit-airplay="true" x5-video-orientation="portraint" x5-video-player-fullscreen="true"></video>\n'+
                '            </div>\n'+
                '            <div class="modal-footer border-0">\n'+
                '                <button type="button" class="btn btn-outline-light border-0" data-dismiss="modal">关闭</button>\n'+
                '                <button type="button" onclick="window.location=\''+url+'\'" class="btn btn-outline-light border-0">更多详情</button>\n'+
                '            </div>\n'+
                '        </div>\n'+
                '    </div>\n'+
                '</div>';
            document.body.append(playwinmodal);
            console.log('开始给播放窗口赋值标题：'+title);
            document.getElementById('exampleModalCenterTitle2').innerHTML=title;
            let myVid=document.getElementById('__video_01');

            myVid.addEventListener('ended', function(){
                console.log("已播放完成，继续下一个视频")
                play(myVid,arr_videofiles);
            });
            $('#playwin').on('hidden.bs.modal', function (e) {
                console.log('窗口隐藏')
                myVid.pause();
            })
            $('#playwin').on('shown.bs.modal', function (e) {
                console.log('窗口显示')
                currplayurl=0;
                play(myVid,arr_videofiles);
            })
        }
    }
}
