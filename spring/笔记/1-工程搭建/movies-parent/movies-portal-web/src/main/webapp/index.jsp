<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html >
<head>
    <title>黑马影视-online</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="" />
</head>

<body>
<%@ include file="header.jsp"%>
<!-- banner -->
<div id="slidey" style="display:block;">
    <ul id="moviesList">
            <li><img src="/images/5.jpg" alt=" "><p class="title">泰山</p><p class="description"> 泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。</p></li>
            <li><img src="/images/4.jpg" alt=" "><p class="title">泰山</p><p class="description"> 泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。</p></li>
            <li><img src="/images/3.jpg" alt=" "><p class="title">泰山</p><p class="description"> 泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。</p></li>
            <li><img src="/images/2.jpg" alt=" "><p class="title">泰山</p><p class="description"> 泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。</p></li>
            <li><img src="/images/6.jpg" alt=" "><p class="title">泰山</p><p class="description"> 泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。</p></li>
    </ul>
</div>
<script src="js/jquery.slidey.js"></script>
<script src="js/jquery.dotdotdot.min.js"></script>
<script type="text/javascript">
    $("#slidey").slidey({
        interval: 8000,
        listCount: 5,
        autoplay: false,
        showList: true
    });
    $(".slidey-list-description").dotdotdot();
</script>

<!-- general -->
<div class="general" id="generalContent">
    <h4 class="latest-text w3_latest_text">影视列表</h4>
    <div class="container">
        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
            <ul id="myTab" class="nav nav-tabs" role="tablist">
                 <li role="presentation" class="active">
                    <a href="#home0" role="tab" data-toggle="tab" >特色的</a>
                </li>
                <li role="presentation">
                    <a href="#home1" role="tab" data-toggle="tab" >高观看率</a>
                </li>
                <li role="presentation">
                    <a href="#home2" role="tab" data-toggle="tab">高评分</a>
                </li>
                <li role="presentation">
                    <a href="#home3" role="tab" data-toggle="tab" >最新上映</a>
                </li>
            </ul>
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane fade active in" id="home0" aria-labelledby="home-tab">
                    <div class="w3_agile_featured_movies">
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal">
							<img src="images/m15.jpg" title="album-name" style="width: 150px;height: 200px"  style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                                <div class="w3l-action-icon">
									<i class="fa fa-play-circle" aria-hidden="true"></i>
								</div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">God’s Compass</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m2.jpg" title="album-name" style="width: 150px;height: 200px"  style="width: 150px;height: 200px" class="img-responsive" alt=" "  />
                                <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">Bad Moms</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m5.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                                <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">Jason Bourne</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m16.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                                <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">Rezort</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m17.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                                <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">Peter</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="col-md-2 w3l-movie-gride-agile">
                            <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m18.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                                <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                            </a>
                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                <div class="w3l-movie-text">
                                    <h6><a href="single.html">ISRA 88</a></h6>
                                </div>
                                <div class="mid-2 agile_mid_2_home">
                                    <p> 2020-10-10</p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="ribben">
                                <p>NEW</p>
                            </div>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="home1" aria-labelledby="profile-tab">
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m22.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Assassin's Creed 3</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m2.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Bad Moms</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m9.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Central Intelligence</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="home2" aria-labelledby="rating-tab">
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m7.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Light B/t Oceans</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m11.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">X-Men</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m8.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">The BFG</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m17.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Peter</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="home3" aria-labelledby="imdb-tab">
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m22.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Assassin's Creed 3</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m2.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Bad Moms</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m9.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Central Intelligence</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m10.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Don't Think Twice</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="col-md-2 w3l-movie-gride-agile">
                        <a href="视频播放页面" class="hvr-shutter-out-horizontal"><img src="images/m23.jpg" title="album-name" style="width: 150px;height: 200px" class="img-responsive" alt=" " />
                            <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i></div>
                        </a>
                        <div class="mid-1 agileits_w3layouts_mid_1_home">
                            <div class="w3l-movie-text">
                                <h6><a href="single.html">Dead Island 2</a></h6>
                            </div>
                            <div class="mid-2 agile_mid_2_home">
                                <p> 2020-10-10</p>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="ribben">
                            <p>NEW</p>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/axios-0.18.0.js"></script>
<script type="text/javascript" src="/js/vuejs-2.5.16.js"></script>
<%--Vue的代码写到这里--%>
<script type="text/javascript">
    const app = new Vue({
        el:'#generalContent',
        data:{},
        methods:{}
    })
</script>
<%@ include file="footer.jsp"%>
</body>
</html>
