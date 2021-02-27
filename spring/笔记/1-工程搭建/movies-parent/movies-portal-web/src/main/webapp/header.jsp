<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="application/x-javascript">
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
function hideURLbar(){ window.scrollTo(0,1); }
</script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/contactstyle.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/faqstyle.css" type="text/css" media="all" />
<link href="css/single.css" rel='stylesheet' type='text/css' />
<link href="css/medile.css" rel='stylesheet' type='text/css' />
<!-- banner-slider -->
<link href="css/jquery.slidey.min.css" rel="stylesheet">
<!-- //banner-slider -->
<!-- pop-up -->
<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<!-- font-awesome icons -->
<link rel="stylesheet" href="css/font-awesome.min.css" />
<!-- //font-awesome icons -->
<!-- js -->
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<!-- //js -->
<!-- banner-bottom-plugin -->
<link href="css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
<script src="js/owl.carousel.js"></script>
<script>
    $(document).ready(function() {
        $("#owl-demo").owlCarousel({
            autoPlay: 3000, //Set AutoPlay to 3 seconds
            items : 5,
            itemsDesktop : [640,4],
            itemsDesktopSmall : [414,3]
        });
    });
</script>
<!-- //banner-bottom-plugin -->
<!---<link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700italic,700,400italic,300italic,300' rel='stylesheet' type='text/css'>--->
<!-- start-smoth-scrolling -->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<!-- header -->
<div class="header">
    <div class="container">
        <br/>
        <div class="w3layouts_logo">
            <a href="#"><h1>黑马<span>影视</span></h1></a>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>

<div class="movies_nav">
    <div class="container">
        <nav class="navbar navbar-default">
            <div class="navbar-header navbar-left">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right" id="bs-example-navbar-collapse-1">
                <nav>
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="/">首页</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">类型 <b class="caret"></b></a>
                            <ul class="dropdown-menu multi-column columns-3">
                                <li>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">动作</a></li>
                                            <li><a href="#">奇幻</a></li>
                                            <li><a href="#">犯罪</a></li>
                                            <li><a href="#">家庭</a></li>
                                            <li><a href="#">恐怖</a></li>
                                            <li><a href="#">浪漫</a></li>
                                            <li><a href="#">体育</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">冒险</a></li>
                                            <li><a href="#">喜剧</a></li>
                                            <li><a href="#">纪录</a></li>
                                            <li><a href="#">幻想</a></li>
                                            <li><a href="#">惊悚</a></li>
                                            <li><a href="#">战争</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">动画</a></li>
                                            <li><a href="#">戏剧</a></li>
                                            <li><a href="#">古装</a></li>
                                            <li><a href="#">历史</a></li>
                                            <li><a href="#">音乐剧</a></li>
                                            <li><a href="#">心理学</a></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </li>
                            </ul>
                        </li>
                        <li><a href="series.html">电视连续剧</a></li>
                        <li><a href="news.html">最新电影</a></li>
                        <li><a href="short-codes.html">最热电影</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">国家 <b class="caret"></b></a>
                            <ul class="dropdown-menu multi-column columns-3">
                                <li>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">亚洲</a></li>
                                            <li><a href="#">法国</a></li>
                                            <li><a href="#">台湾</a></li>
                                            <li><a href="#">美国</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">中国</a></li>
                                            <li><a href="#">洪聪</a></li>
                                            <li><a href="#">日本</a></li>
                                            <li><a href="#">泰国</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="multi-column-dropdown">
                                            <li><a href="#">欧洲</a></li>
                                            <li><a href="#">印度</a></li>
                                            <li><a href="#">韩国</a></li>
                                            <li><a href="#">英国</a></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#">A-Z 列表</a></li>
                    </ul>
                </nav>
            </div>
        </nav>
    </div>
</div>
<!-- //nav -->
