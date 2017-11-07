<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-4
  Time: 下午8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../components/head.jsp"  %>
</head>
<body style="background-color: #fff;">
<div class="ui form pushable" method="post" action="view" id="main">
    <%--侧边栏--%>
    <div class="ui top left vertical menu sidebar">
        <a class="ui right grey large corner label">
            <i class="close icon"></i>
        </a>
        <div class="content">
            <form id="searchForm" class="ui grid stackable segment three column vertical container">
                <div class="column">
                    <div class="ui black basic label">
                        操作编号
                    </div>
                    <div class="ui input">
                        <input type="number" name="id">
                    </div>
                </div>
                <div class="column">
                    <div class="ui black basic label">
                        管理员姓名
                    </div>
                    <div class="ui input">
                        <input type="text" name="admin.name">
                    </div>
                </div>
                <div class="row">
                    <div class="column">
                        <div class="ui black basic label">
                            入站时间
                        </div>
                        <div class="ui input">
                            <input type="text" datetime="true" name="createdStart">
                        </div>
                    </div>
                    <div class="column">
                        <div class="ui black basic label">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                        <div class="ui input">
                            <input type="text" datetime="true" name="createdEnd">
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div style="text-align: center;width:100%;padding-top: 5%">
            <div class="ui button blue" id="lookFor">查询</div>
            <a class="ui button" id="reset">重置</a>
        </div>
    </div>

    <div class="pusher" style="height: 100%">
        <h2 class="ui header">
            <i class="spy alternate icon"></i>
            <div class="content">收藏信息</div>
            <div class="sub header">Comment Management</div>
        </h2>
        <div  id="menu">
            <div class="ui small menu">
                <div class="right menu">
                    <div class="item">
                        <div id="search" class="ui teal icon button">
                            <i class="search icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui loading segment"  id="segment">
            <table class="very selectable small celled large unstackable compact ui single line table">
                <thead>
                <tr class="center aligned">
                    <th class="one wide">
                        <div class="ui checkbox">
                            <input type="checkbox" name="switch" id="checkAll"><label></label>
                        </div>
                    </th>
                    <th id="operate_id"/><i class="icon sort"></i>收藏编号</th>
                    <th id="admin_name"/><i class="icon sort"></i>用户姓名</th>
                    <th id="operate_created"/><i class="icon sort"></i>操作时间</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div  id="foot" style="text-align: center">
            <div class="ui compact pagination menu" id="pagination">
                <div class='disabled item'>
                    ...
                </div>
            </div>
        </div>
    </div>
</div>

<%--模态框 主信息--%>
<div class="ui first modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <form class="ui stackable  form three column grid" id="modal" style="width: 100%">
            <div class="field column">
                <label>操作编号</label>
                <input type="number" name="id">
            </div>
            <div class="field column">
                <label>用户姓名</label>
                <input type="text" readonly name="author.name">
            </div>
            <div class="field column">
                <label>手机名称</label>
                <input type="text" readonly name="mobilePhone.name">
            </div>
            <div class="field column">
                <label>评论时间</label>
                <input type="text" datetime="false" readonly name="created">
            </div>
            <div class="field column">
                <label>评论楼层</label>
                <input type="text"readonly name="storey">
            </div>
            <div class="row">
                <div class="field column">
                    <label>备注</label>
                    <textarea class="myTextarea" rows="3" readonly name="remark"></textarea>
                </div>
            </div>
            <input type="text" style="display: none" name="edition">
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
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

<script>
    "use strict"

    //声明全局变量
    //初始页
    var currentPage=1;
    //trim().length()>0为降序
    var sequence="";
    //排序字段
    var orderBy="";

    var viewName='operate';
    //table head初始化
    var arr=[];
    for(var i=1;i<$('th').length;i++){
        arr.push($('th')[i].id)
    }
    getInfoList(viewName,arr,1,false,null,null);

    $('#delete').click(function () {
        var myCheck=$(".pusher #segment input[name='item'][type='checkbox']");
        var deleteArr=[];
        for(i in myCheck){
            if(myCheck[i].checked){
                deleteArr.push(myCheck[i].value);
            }
        }
        console.log(deleteArr)
        if(arr.length>0) {
            $.post("/mobilee/" + viewName + "/delete", "deleteArr=" + deleteArr.join(','),
                function (data, status) {
                    if (status != "success") {

                    } else {
                        if (data.msg == "success") {
                            showToast("<i class='remove circle icon'></i>删除成功")
                            getInfoList(viewName,arr,currentPage,true,orderBy,sequence);
                        } else {

                        }
                    }
                });
        }
    });

    $('#myPicture').click(function () {
        document.getElementById('file').click();
    })

    $('#lookFor').click(function () {
        orderBy="";
        sequence="";
        getInfoList(viewName,arr,1,true,orderBy,sequence);
        $('th').children('i').attr("class","icon sort")
    });

    $('#reset').click(function () {
        $('#searchForm input').val("");
        $('#searchForm select').dropdown('set selected', "0");
    });

    init();

    $('#new').click(function () {
        $('.ui.myNew.modal').modal('show')
    })

    //排序图标变化
    $('th').click(function () {
        if($(this).children('i').attr("class")=="icon sort ascending"||$(this).children().attr("class")=="icon sort") {
            orderBy=$(this).attr('id');
            sequence="desc";
            getInfoList(viewName,arr,currentPage,true,orderBy,sequence);
            $(this).children('i').attr("class", "icon sort descending");
            $(this).siblings().children('i').attr("class", "icon sort");
        }
        else if($(this).children('i').attr("class")=="icon sort descending") {
            orderBy=$(this).attr('id');
            sequence="";
            getInfoList(viewName,arr,currentPage,true,$(this).attr('id'),null);
            $(this).children('i').attr("class", "icon sort ascending");
            $(this).siblings().children('i').attr("class", "icon sort");
        }
    })

    //时间日期选择框初始化
    $.datetimepicker.setLocale('zh');
    $("input[datetime='true']").datetimepicker({format: 'Y/m/d H:i'});
    $("input[date='true']").datetimepicker({format: 'Y/m/d'});

    //页面初始化
    changeSize();
    bindCheck();
    $('.ui.dropdown').dropdown()/*下拉菜单初始化*/
    $(window).resize(function() {//缩放事件
        changeSize();
    });
    $('.ui.sidebar').sidebar({
        context: $('#main'),
        useLegacy:true,
        transition:'push',
        dimPage:false
    })
    $('#search,.ui.right.grey.large.corner.label').click(function () {
        $('.ui.sidebar')
            .sidebar('toggle')
    })

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
    $('.ui.myNew.modal').modal({
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

    //添加列表信息到页面
    function addInfoList(arr,data,module) {
        var list=data.list;
        var html='';
        for(var i in list) {
            var head = "<tr id='" +list[i].operate_id+"' class='center aligned'>\n" +
                "    <td>\n" +
                "    <div class='ui checkbox'>\n" +
                "    <input type='checkbox' name='item' value='"+list[i].operate_id+"'><label></label>\n" +
                "    </div>\n" +
                "    </td>";
            var body="";
            for (var n in arr){
                for(var j in list[i]){
                    if(j==arr[n]) {
                        var text=list[i][j];
                        body += "<td class='td'>" + text + "</td>";
                    }
                }
            }
            html+=head+body+"</tr>";
        }
        $('tbody').html(html);
        $('td.td').click(function () {
            getInfo(module,$(this).parent().attr('id'));
        })
    }

    function myUpload() {
        $('#fileId').val($("#modal input[name='id']").val());
        $('#modal').addClass('loading');
        var formData = new FormData($( "#modal" )[0]);
        $.ajax({
            url: 'upload',
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
                    $('#myPicture').attr('src',"../upload/"+viewName+"/"+$("#modal input[name='id']").val()+".jpg?"+Math.random())
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
</body>
</html>
