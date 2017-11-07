<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-5
  Time: 上午8:01
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <!-- Site Properties -->
    <title>手百网</title>
    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/js/active.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
    <link rel="stylesheet" href="<%=path%>/css/tourist.css">
    <link rel="stylesheet" href="<%=path%>/css/detail.css">

</head>
<body>

<div class="ui fixed inverted menu">
    <div class="ui container">
        <a href="#" class="header item">
            <i class="myLogo mobile icon"></i>
            手百网
        </a>
        <a href="<%=path%>/tourist/index" class="item">主页</a>
        <div class="ui item right">
            <div class="ui icon input">
                <input type="text" placeholder="搜索...">
                <i class="inverted circular search link icon"></i>
            </div>
        </div>
    </div><c:if test="${sessionScope.TOURIST_ID==null}">
    <a class="ui item right floated" href="<%=path%>/tourist/welcome">登录</a></c:if><c:if test="${sessionScope.TOURIST_ID!=null}">
    <div class="menu right">
        <div class="ui dropdown fluid item">
            <img class="ui avatar image" src="<%=path%>/upload/admin/${sessionScope.TOURIST_ID}.jpg?a" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
            <span id="userName">${sessionScope.TOURIST_NAME}</span>
            <div class="menu">
                <a class="item" modal="personalInformation"><i class="icon setting"></i> 个人信息</a>
                <a class="item" href="<%=path%>/tourist/cancel"><i class="icon sign out"></i> 注销</a>
            </div>
        </div>
    </div></c:if>
</div>

<div class="ui main container">
    <div class="ui grid">
        <div class="sixteen wide column">
            <div class="ui grid" id="context">
                <div class="eleven wide column">
                    <div class="ui fluid card">
                        <div class="content">
                            <span class="right floated">收藏</span>
                            <i class="right floated star icon <c:if test="${requestScope.detail.isCollected>0}">yellow</c:if> "></i>
                            <div class="header">${requestScope.detail.mobilePhone.name}</div>
                        </div>
                    </div>
                    <div class="ui vertical segment">
                            <div class="ui grid">
                                <div class="seven wide column">
                                    <img class="ui centered medium image" src='<%=path%>/upload/mobilePhone/${requestScope.detail.mobilePhone.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/mobilePhone/timg.jpg'">
                                </div>
                                <div class="nine wide column">
                                    <div class="row">
                                        <h2 class="ui header">
                                            <div class="content" style="width: 100%">
                                                <div class="sub header">参考报价:<span style="color: red">￥<span style="font-size: 2em">${requestScope.detail.mobilePhone.price}</span></span></div>
                                            </div>
                                        </h2>
                                    </div>
                                    <div class="row">
                                        <table class="ui teal celled table">
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon browser"></i></p>
                                                    <p>基本信息</p>
                                                </td>
                                                <td>
                                                    <p>上市时间：${fn:substring(requestScope.detail.mobilePhone.listTime, 0, 10)}</p>
                                                    <p>手机尺寸：${requestScope.detail.mobilePhone.length}mm*${requestScope.detail.mobilePhone.width}mm*${requestScope.detail.mobilePhone.height}mm</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon desktop"></i></p>
                                                    <p>屏幕信息</p>
                                                </td>
                                                <td>
                                                    <p>屏幕尺寸：${requestScope.detail.mobilePhone.size}寸</p>
                                                    <p>屏幕分辨率：${requestScope.detail.mobilePhone.pixel}p</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon camera retro"></i></p>
                                                    <p>拍照信息</p>
                                                </td>
                                                <td>
                                                    <p>相机像素：${requestScope.detail.mobilePhone.cameraPixel}像素</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon certificate"></i></p>
                                                    <p>硬件信息</p>
                                                </td>
                                                <td>
                                                    <p>cpu型号:${requestScope.detail.mobilePhone.cpu}</p>
                                                    <p>运行内存:${requestScope.detail.mobilePhone.memory}</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="ui vertical segment">
                        <div class="row">
                            <h3 class="ui header">评论</h3>
                        </div>
                        <div class="ui comments" style="width: 100%;"><c:forEach items="${requestScope.detail.comment}" var="bean">
                            <div class="comment ui grid">
                                <div class="user-face two wide column">
                                    <a href="javascript:void(0);">
                                        <img class="ui bordered avatar image" src='<%=path%>/upload/user/${bean.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/user/timg.jpg'">
                                    </a>
                                </div>
                                <div class="con fourteen wide column">
                                    <div class="user">
                                        <a href="javascript:void(0);" class="userName">${bean.name}</a>
                                        <a href="javascript:void(0);">
                                            <i class="level l4"></i>
                                        </a>
                                    </div>
                                    <p class="text">${bean.content}</p>
                                    <div class="commentInfo ui grid">
                                        <span class="floor two wide column">#${bean.storey}</span>
                                        <span class="time six wide column">${bean.created}</span>
                                        <span class="like one wide column">
                                            <i class="icon thumbs outline up"></i>
                                            <span></span>
                                        </span>
                                        <span class="hate one wide column">
                                           <i class="icon thumbs outline down"></i>
                                        </span>
                                    </div>
                                    <div class="reply-box">

                                    </div>
                                    <div class="paging-box">

                                    </div>

                                    <div class="ui divider"></div>
                                </div>
                            </div>
                            </c:forEach>
                            <form id="comment" class="ui reply form">
                                <div class="field">
                                    <textarea name="content" <c:if test="${sessionScope.TOURIST_ID==null}"> readonly placeholder="请先登录才能进行评论。" </c:if>></textarea>
                                    <input name='mobilePhone.id' value="${requestScope.detail.mobilePhone.id}" style="display:none" />
                                </div>
                                <div class="ui primary<c:if test="${sessionScope.TOURIST_ID==null}"> disabled</c:if> labeled icon button" id="submit">
                                    <i class="icon edit"></i>评论
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="five wide column ui rail">
                    <div class="ui vertical segment ui sticky">
                        <div class="row" style="margin-top: 100px">
                            <h2 class="ui header">
                                <div class="content">
                                    有售商家
                                    <div class="sub header">参考列表</div>
                                </div>
                            </h2>
                            <div class="ui relaxed divided list"><c:forEach items="${requestScope.detail.sale}" var="bean">
                                <div class="item">
                                    <img class="ui middle aligned avatar bordered image"  src="<%=path%>/upload/sale/${bean.id}.jpg" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
                                    <div class="content">
                                        <a class="header" style="color: #333!important;font-weight: 100" href="${bean.address}">
                                                ${bean.name}
                                            <span  style="color: red">￥${bean.price}</span>
                                        </a>
                                        <div class="description">
                                            <p><i class="icon mobile"></i>${bean.phone}</p>
                                        </div>
                                    </div>
                                </div></c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="ui inverted vertical footer segment">
    <div class="ui center aligned container">
        <div class="ui stackable inverted divided grid">
            <div class="three wide column">
                <h4 class="ui inverted header">合作厂商</h4>
                <div class="ui inverted link list">
                    <a href="javascript:void(0);" class="item">暂无</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">友情链接</h4>
                <div class="ui inverted link list">
                    <a href="javascript:void(0);" class="item"><i class="icon qq"></i>QQ</a>
                    <a href="javascript:void(0);" class="item"><i class="icon weibo"></i>weibo</a>
                    <a href="javascript:void(0);" class="item"><i class="icon wechat"></i>wechat</a>
                    <a href="javascript:void(0);" class="item"><i class="icon twitter"></i>twitter</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">联系方式</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item"><i class="icon qq"></i>1056358034</a>
                    <a href="https://github.com/ShichijoAria" class="item"><i class="icon github"></i>shichijoaria</a>
                </div>
            </div>
            <div class="seven wide column">
                <h4 class="ui inverted header">声明</h4>
                <p>本网站做学习用途</p>
            </div>
        </div>
        <div class="ui inverted section divider"></div>
        <div class="ui horizontal inverted small divided link list">
            <a class="item" href="#">Site Map</a>
            <a class="item" href="#">Contact Us</a>
            <a class="item" href="#">Terms and Conditions</a>
            <a class="item" href="#">Privacy Policy</a>
        </div>
    </div>
</div>
</body>
<script>

    $('.ui.dropdown').dropdown()

    $('#submit').click(function(){
        $.post("<%=path%>/tourist/add?"+serializeNotNull($('#comment').serialize()),
            function (data, status) {
                if (status != "success") {
                    showError(["无法连接服务器"]);
                }else {
                    if(data.msg=="success"){
                        location.reload();
                    }else {
                        showError([data.msg]);
                    }
                }
            });
    });

    $('.right.floated.star.icon').click(function () {
        $.post("<%=path%>/tourist/collect?id=${requestScope.detail.mobilePhone.id}",
            function (data, status) {
                if (status != "success") {
                    showError(["无法连接服务器"]);
                }else {
                    if(data.msg=="success"){
                        if($('.right.floated.star.icon').hasClass('yellow'))
                            $('.right.floated.star.icon').removeClass('yellow');
                        else
                            $('.right.floated.star.icon').addClass('yellow');
                    }else {
                        showError([data.msg]);
                    }
                }
            });
    })

    alterSize();

    window.onresize=alterSize();

    function alterSize(){
        $('.ui.fluid.image').outerHeight(5/4*$('.ui.fluid.image').outerWidth());
        $('.comment .ui.avatar.image').outerHeight($('.comment .ui.avatar.image').outerWidth());
        $('.ui.mini.image .ui.avatar.image').outerHeight($('.ui.mini.image .ui.avatar.image').outerWidth());
    }

    $('.ui.sticky')
        .sticky({
            context: '#context',
            pushing: true
        })
    ;
</script>
</html>