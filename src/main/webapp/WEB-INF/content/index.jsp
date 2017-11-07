<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta charset="UTF-8">
    <title>手百网</title>
    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <link rel="stylesheet" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/index.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
</head>
<body style="background-color: #F3F5F8!important;">
<!-- 容器 -->
<div class="container" style="height: 100%">
    <div class="ui small massive attached stackable menu borderless grid one column">
        <div class="ui small menu borderless large screen tablet computer only column" style="padding: 0 0 0 0">
            <div class="ui tiny header item indexmenu" style="width:220px;padding-right: 0px">
                <i class="circular users icon indexmenu"></i>
                <div class="content">
                    手机百科网站
                </div>
            </div>
            <div class="item indexmenu" style="width:40px">
                <a id="arrow" href="javascript:void(0);"><i class="icon arrow left"></i></a>
            </div>
            <div class="item indexmenu">
                <a id="homepage" href="javascript:void(0);" class="menu"><i class="home icon"></i> 主页</a>
            </div>
            <div class="menu right">
                <div class="ui dropdown fluid item indexmenu">
                    <img class="ui avatar image" src="<%=path%>/upload/admin/${sessionScope.USER_ID}.jpg?a" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
                    <span id="adminName">${sessionScope.USER_NAME}</span>
                    <div class="menu">
                        <a class="item" modal="personalInformation"><i class="icon setting"></i> 个人信息</a>
                        <a class="item" href="<%=path%>/admin/cancel"><i class="icon sign out"></i> 注销</a>
                    </div>
                </div>
                <div class="ui item">
                    <i class="icon help"></i>
                    帮助
                </div>
            </div>
        </div>
        <div class="ui three item small menu borderless mobile only column" style="background-color: white">
            <div class="item indexmenu" style="width:33%!important">
                <a id="arrow2" href="javascript:void(0);"><i class="circular outline icon arrow left"></i></a>
            </div>
            <div class="ui icon floating item indexmenu dropdown" style="width: 33%!important">
                <i class="circular user icon"></i>
                <div class="menu">
                    <a class="item" modal="personalInformation"><i class="icon setting"></i> 个人信息</a>
                    <a class="item" href="/SIS/desktop/loginOut"><i class="icon sign out"></i> 注销</a>
                </div>
            </div>
            <div class="item indexmenu" style="width: 33%!important;">
                <i class="circular users icon"></i>
            </div>
        </div>
    </div>
    <div class="ui bottom attached segment pushable" style="background-color: #F3F5F8!important;">
        <div class="ui inverted labeled icon left inline vertical sidebar menu accordion" style="width: 260px">
            <div class="item acc">
                <a class="title" style="color:#AEB7C2;">
                    <i class="icon users padrig"></i>
                    角色管理
                    <i class="dropdown icon"></i>
                </a>
                <div class="content">
                    <p><a id="admin" class="child" href="javascript:void(0)">管理人员</a></p>
                    <p><a id="user" class="child" href="javascript:void(0)">网站用户</a></p>
                </div>
            </div>
            <div class="item acc">
                <a class="title" style="color:#AEB7C2;">
                    <i class="icon write padrig"></i>
                    资料管理
                    <i class="dropdown icon"></i>
                </a>
                <div class="content">
                    <p><a id="mobilePhone" class="child" href="javascript:void(0)">手机信息</a></p>
                    <p><a id="manufacturer" class="child" href="javascript:void(0)">出品厂商</a></p>
                    <p><a id="sale" class="child" href="javascript:void(0)">手机卖家</a></p>
                </div>
            </div>
            <div class="item acc">
                <a class="title" style="color:#AEB7C2;">
                    <i class="icon newspaper"></i>
                    关系管理
                    <i class="dropdown icon"></i>
                </a>
                <div class="content">
                    <p><a id="collection" class="child" href="javascript:void(0)">收藏信息</a></p>
                    <p><a id="sell" class="child" href="javascript:void(0)">销售信息</a></p>
                    <p><a id="comment" class="child" href="javascript:void(0)">评论信息</a></p>
                </div>
            </div>
            <div class="item acc">
                <a class="title" style="color:#AEB7C2;">
                    <i class="icon newspaper"></i>
                    操作管理
                    <i class="dropdown icon"></i>
                </a>
                <div class="content">
                    <p><a id="operate" class="child" href="javascript:void(0)">评论管理</a></p>
                </div>
            </div>
        </div>
        <div class="pusher" style="height: 100%">
            <div class="ui segment" style="height: 100%">
                <iframe class="" id="myframe" src="/SIS/desktop/welcome" height="95%" width="100%" frameborder="no" border="0" ></iframe>
            </div>
        </div>
    </div>
</div>

<%--模态框 个人信息--%>
<div class="ui first modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <form class="ui stackable  form two column grid" id="modal" style="width:100%">
            <div class="field column">
                <img id="myPicture" class="ui medium bordered  circular image" data-position="right center" data-title='点击更改图片', onerror="javascript:this.src='<%=path%>/upload/timg.jpg'" src="<%=path%>/upload/admin/${sessionScope.USER_ID}.jpg?a" id="myPicture" onclick="document.getElementById('file').click();"/>
            </div>
            <div class="field column">
                <div class="ui items">
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                编号：
                            </div>
                            <input name="id" value="${sessionScope.USER_ID}" readonly/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                姓名：
                            </div>
                            <input name="name" value="${sessionScope.USER_NAME}"/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                密码：
                            </div>
                            <input name="password" value="${sessionScope.USER_PASSWORD}"/>
                        </div>
                    </div>
                    <input type="file" name="file" id="file" style="display: none" onchange="myUpload()">
                </div>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div>
        <div class="ui positive right labeled icon button" id="saveEntity">
            保存
            <i class="checkmark icon"></i>
        </div>
    </div>
</div>

<%--模态框 反馈信息--%>
<div class="ui small modal">
    <div class="header">

    </div>
    <div class="ui icon header">

    </div>

    <div class="actions">
        <div class="ui green ok inverted button">
            <i class="checkmark icon"></i>
            是
        </div>
    </div>
</div>

</body>
<script>
    $('.ui.menu')
        .on('click', '.item', function() {
            if(!$(this).hasClass('dropdown')) {
                $(this)
                    .addClass('active')
                    .siblings('.item')
                    .removeClass('active')
                ;
            }
        })
    ;/*菜单控件初始化*/
    $('.ui.inverted.labeled.icon.left.inline.vertical.sidebar.menu')
        .sidebar({
            context: $('.ui.bottom.attached.segment.pushable'),
            closable:false,
            dimPage:false,
            useLegacy:true,
            duration:100
        })
    $('#arrow,#arrow2').click(function () {
        $('.ui.sidebar')
            .sidebar('toggle')
        ;
        if($(this).children().hasClass('left')) {
            $(this).children()
                .addClass('right')
                .removeClass('left')
            ;
            $(".pusher").width(function(n,c){
                return c+260;
            });
        }else {
            $(this).children()
                .addClass('left')
                .removeClass('right')
            ;
            $(".pusher").width(function(n,c){
                return c-260;
            });
        }
    })
    $('.ui.sidebar')
        .sidebar('toggle')
    ;
    $('.ui.dropdown')
        .dropdown()
    ;/*下拉菜单初始化*/
    $('.ui.accordion')
        .accordion()
    ;/*手风琴初始化*/
    $('.ui.medium.bordered.circular.image')
        .popup()
    ;/*弹出框初始化*/
    $(".title").mouseover(function(){
        $(this).css("color","white")
            .children().addClass("myblue")
    });
    $(".title").mouseout(function(){
        if(!$(this).hasClass("active")) {
            $(this).css("color", "#AEB7C2")
                .children().removeClass("myblue");
        }
    });
    $(".pusher").width(function(n,c){
        if($(".pusher").width()>300)
            return $('body').outerWidth()-260;
    });
    $(window).resize(function(){//缩放事件
        $(".pusher").width(function(n,c){
            return $('body').outerWidth()-260;
        });
        checkHeight();
    });
    function checkHeight() {
        $(".ui.bottom.attached.segment.pushable").height(function(n,c){
            return $('.container').outerHeight()-Number($('.ui.massive.attached.stackable.menu.borderless').outerHeight()+2);
        });
    }
    //模态框
    $('.ui.first.modal').modal({
        onDeny    : function(){
            if($('#modal').hasClass('loading'))
                return false;
        },
        onApprove : function() {
            return false;
        }
    }) .modal('setting', 'closable', false)
    $('.small.modal')
        .modal({
            allowMultiple: true,
            onApprove : function() {
                $('#modal').removeClass('loading');
            }
        })
        .modal('setting', 'closable', false)
    $('#myPicture').outerHeight($('#myPicture').outerWidth());
    $(window).resize(function () {
        $('#myPicture').outerHeight($('#myPicture').outerWidth());
    })

    $('#saveEntity').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/admin/save",
            {
                id:$(".field.column [name='id']").val(),
                name:$(".field.column [name='name']").val(),
                password:$(".field.column [name='password']").val()},
        function(data, status) {
            if (status != "success") {
                showToast("<i class='warning icon'></i>连接服务器失败！");
            }else {
                if(data.msg=="success"){
                    showToast("<i class='archive icon'></i>保存成功");
                    $('#adminName').text($(".field.column [name='name']").val());
                    $('#myPicture').attr('src',"../upload/admin/${sessionScope.USER_ID}.jpg?"+Math.random());
                    $('.ui.avatar.image').attr('src',"../upload/admin/${sessionScope.USER_ID}.jpg?"+Math.random());
                }else {
                    showToast("<i class='remove circle outline icon'></i>"+data.msg);
                }
            }
        });
    })
    $('p a.child').click(function () {
        $('iframe').attr("src","<%=path%>/"+$(this).attr('id')+"/view")
    });
    $("[modal='personalInformation']").click(function () {
        $('.ui.first.modal')
            .modal('show');
    })
    $('.circular.users.icon').click(function () {
        $('iframe').attr("src","/SIS/desktop/welcome")
    });
    $('.ui.medium.bordered.circular.image')
        .popup()
    ;
    checkHeight();


    function myUpload() {
        $('#modal').addClass('loading');
        var formData = new FormData($( "form" )[0]);
        $.ajax({
            url: "upload?fileId="+$("input[name='id']").val(),
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if(data.msg=="success"){
                    $('#modal').removeClass('loading');
                    showToast("<i class='upload icon'></i>上传成功");
                    $('#myPicture').attr('src',"../upload/admin/${sessionScope.USER_ID}.jpg?"+Math.random())
                    $('.ui.avatar.image').attr('src',"../upload/admin/${sessionScope.USER_ID}.jpg?"+Math.random());
                }else {
                    $('#modal').removeClass('loading');
                    showToast("<i class='remove circle outline icon'></i>"+data.msg);
                }

            },
            error: function (data) {
                $('#modal').removeClass('loading');
                showToast("<i class='warning icon'></i>连接服务器失败！");
            }
        });
    }
</script>
</html>
