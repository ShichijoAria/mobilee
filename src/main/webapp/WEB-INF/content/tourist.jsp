<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" type="text/css" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
    <link rel="stylesheet" href="<%=path%>/css/tourist.css">

</head>
<body>

<div class="ui fixed inverted menu">
    <div class="ui container">
        <a href="#" class="header item">
            <i class="myLogo mobile icon"></i>
            手百网
        </a>
        <a href="#" class="item">主页</a>
        <div class="ui item right">
            <div class="ui icon input">
                <input type="text" placeholder="搜索...">
                <i class="inverted circular search link icon"></i>
            </div>
        </div>
    </div>
</div>

<div class="ui main container">
    <div class="ui menu inverted attached">
        <a class="teal item" id="phone">手机大全</a>
        <a class="teal item" id="firm">厂商大全</a>
    </div>
    <div class="ui stacked segment attached">
        <div class="ui horizontal divided list" id="myList">
            <div class="item">
                <div class="content">
                    <p>最新：</p>
                </div>
            </div>
        </div>
    </div>
    <div class="ui grid">
        <div class="sixteen wide column">
            <div class="ui raised segment four column grid"><c:forEach var="bean" items="${requestScope.mobilePhone}">
                <div class="column">
                    <div class="ui card">
                        <div class="image">
                            <img class="ui fluid image" src='<%=path%>/upload/mobilePhone/${bean.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/mobilePhone/timg.jpg'">
                        </div>
                        <div class="ui floating red tag label">￥${bean.price}</div>
                        <div class="content">
                            <span class="right floated">
                              <i class="heart outline like icon"></i>
                              ${bean.collection} 喜欢
                            </span>
                            <i class="comment icon"></i>
                                ${bean.comment} 评论
                        </div>
                    </div>
                </div></c:forEach>
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
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">友情链接</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">联系方式</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="seven wide column">
                <h4 class="ui inverted header">Footer Header</h4>
                <p>Extra space for a call to action inside the footer that could help re-engage users.</p>
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
    var phoneList=['小米6','iphone X','魅族 pro6'];
    var firmList=['小米','苹果','魅族'];

    alterSize();

    $('.ui.card').click(function () {
        window.open("http://www.baidu.com");
    })
    
    $('.item').hover(function () {
        if ($(this).attr("id")=='phone')
            changeList(phoneList);
        else
            changeList(firmList)
        $(this).addClass('active');
        $(this).siblings().removeClass('active');
        }
    );

    function changeList(list) {
        var htmlList=list.map(getEle)
        var innerHtml="<div class=\"item\">\n" +
            "                <div class=\"content\">\n" +
            "                    <p>最新：</p>\n" +
            "                </div>\n" +
            "            </div>";
        for(i in htmlList){
            innerHtml+=htmlList[i]
        }
        $('#myList').html(innerHtml);
    }

    function getEle(text) {
        return "<div class=\"item\">\n" +
            "                <div class=\"content\">\n" +
            "                    <a>"+text+"</a>\n" +
            "                </div>\n" +
            "            </div>"
    }

    window.onload=alterSize();

    function alterSize(){
        $('.ui.fluid.image').outerHeight(5/4*$('.ui.fluid.image').outerWidth());
    }
</script>
</html>
