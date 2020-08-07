<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-05-24
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid p-0" id="app_footer_copyright">
    <div class="container pb-5 text-center" style="font-size: 1.8rem;line-height: 1.8;z-index: 0!important;">
        <span v-html="content"></span>
    </div>
</div>
<div><a href="#" class="back-top btn btn-danger"><i class="fa fa-arrow-up" aria-hidden="true"></i></a></div>
<script>
    signcategoryinit('#app_footer_copyright',200,'底部版权资料');
    signcategoryinit('#app_header_logo',198,'顶部菜单左边logo未展开');
    signcategoryinit('#app_menu_logo',199,'顶部菜单左边logo展开');
    // BEGIN: 07 Back To top
    var backTotop = function(){
        var $backtotop = $('.back-top');
        $(window).on('scroll', function() {
            if ($(this).scrollTop() > 500) {
                $backtotop.addClass('btn-show');
            } else {
                $backtotop.removeClass('btn-show');
            }
        });
        $backtotop.on('click', function() {
            $('html,body').animate({scrollTop: 0}, 'slow');
            return false;
        });
    };
    // END: Back To top
    backTotop();
    window.addEventListener('scroll', function (e) {
        var fun;
        var beforeScrollTop=document.body.scrollTop;
        return function () {
            if (fun) clearInterval(fun);
            fun=setInterval(function () {
                var afterScrollTop=document.body.scrollTop,
                    delta=afterScrollTop-beforeScrollTop;
                if (delta===0) return false;
                if (delta>100) {
                    yc()
                } else {
                    xs()
                }
                beforeScrollTop=afterScrollTop;
            }, 30);
        }
    }());
    var yc=function () {
        $(".header").hide();
    }
    var xs=function () {
        $(".header").show();
    }
    $('#gotop').click(function () {
        $('html,body').animate({scrollTop: 0}, 'slow');
        $(".header").show();
    });
    $('.cd').click(function () {
        $(".menu").show();
    });
    $('.gb').click(function () {
        $(".menu").hide();
    });
    $('.menu_list li:not(.menu_list_news)').click(function () {
        var i=$(this).index();
        var h=0;
        if (i==0) {
            //h=$('#page_home').offset().top;
        }
        if (i==1) {
            h=$('#aboutus').offset().top;
        }
        if (i==2) {
            //h=$('#app_cases').offset().top;
        }
        if (i==3) {
            //h=$('#aboutitem').offset().top;
        }
        if (i==4) {
            //h=$('#contact').offset().top;
        }
        console.log('您选择的菜单项索引：'+i+',h值：'+h);
        $('.menu').hide();
        $('html,body').animate({scrollTop: h}, 'slow');
        $(".header").show();
    });
    $(window).scroll(function () {
        //回到顶部显示隐藏
        var windowTop=$(window).scrollTop();

        if (windowTop>2000) {
            $(".footer-dixian").css("z-index", "1");
        } else {
            $(".footer-dixian").css("z-index", "-1");
        }
    });
</script>
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
    });
</script>
<script language="javascript" for="window" event="onload">
    // let sival=setInterval(jcload,500);
    // var loadarg=true;
    // function jcload() {
    //     console.log('页面加载开始检测1：'+document.readyState);
    //     if(document.readyState=="complete"&&loadarg){
    //         console.log('页面加载开始检测2：'+document.readyState);
    //         clearInterval(sival);
    //         console.log('页面加载开始检测3：'+document.readyState);
    //         // BEGIN: 01 Preloader
    //         var preLoader=function () {
    //             if ($('.preloader').length) {
    //                 var $preloader=$('.preloader');
    //                 $preloader.delay(200).fadeOut(600);
    //             }
    //         };
    //         preLoader();
    //         loadarg=false;
    //     }
    // }
    var preLoader=function () {
        if ($('.preloader').length) {
            var $preloader=$('.preloader');
            $preloader.delay(200).fadeOut(600);
        }
    };
    preLoader();
</script>
