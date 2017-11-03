<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-2
  Time: 上午10:11
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
                        卖家编号
                    </div>
                    <div class="ui input">
                        <input type="number" name="id">
                    </div>
                </div>
                <div class="column">
                    <div class="ui black basic label">
                        卖家名称
                    </div>
                    <div class="ui input">
                        <input type="text" name="name">
                    </div>
                </div>
                <div class="column">
                    <div class="ui black basic label">
                        录入作者
                    </div>
                    <div class="ui input">
                        <input type="text" name="author.name">
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
            <i class="shop alternate icon"></i>
            <div class="content">手机卖家</div>
            <div class="sub header">Sale</div>
        </h2>
        <div  id="menu">
            <div class="ui small menu">
                <div class="left menu">
                    <div class="item">
                        <div class="ui primary button" id="new" style="margin-right: 5px">新建</div>
                        <div class="ui red button" id="delete">删除</div>
                    </div>
                </div>
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
                    <th id="sale_id"/><i class="icon sort"></i>卖家编号</th>
                    <th id="sale_name"/><i class="icon sort"></i>卖家名称</th>
                    <th id="sale_author"/><i class="icon sort"></i>录入作者</th>
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
            <div class="row">
                <div class="field column">
                    <label>头像</label>
                    <img class="ui medium bordered  circular image" data-position="right center" data-title='点击更改图片' onerror="javascript:this.src='../upload/timg.jpg'" src="" id="myPicture" />
                </div>
            </div>
            <div class="field column">
                <label>卖家编号</label>
                <input type="number" name="id">
            </div>
            <div class="field column">
                <label>卖家名称</label>
                <input type="text" name="name">
            </div>
            <div class="field column">
                <label>卖家地址</label>
                <input type="text" name="address">
            </div>
            <div class="field column">
                <label>录入时间</label>
                <input type="text" date="false" readonly name="created">
            </div>
            <div class="field column">
                <label>录入作者</label>
                <input type="text" readonly name="author.name" readonly=>
            </div>
            <input type="text" style="display: none" name="edition">
            <input type="file" id="file" name="headPortrait" style="display: none" onchange="myUpload()">
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div><c:if test="${requestScope.fields.update=='true'}">
        <div class="ui positive right labeled icon button" id="saveEntity">
            保存
            <i class="checkmark icon"></i>
        </div></c:if>
    </div>
</div>

<%--模态框 新建信息--%>
<div class="ui myNew modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <form class="ui stackable  form three column grid" id="newModal" style="width: 100%">
            <div class="field column">
                <label>卖家名称</label>
                <input  type="text" name="name" />
            </div>
            <div class="field column">
                <label>卖家地址</label>
                <input  type="text" name="address" />
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div>
        <div class="ui positive right labeled icon button" id="insertEntity">
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

<script>
    "use strict"

    //声明全局变量
    //初始页
    var currentPage=1;
    //trim().length()>0为降序
    var sequence=null;
    //排序字段
    var orderBy=null;

    var viewName='sale';
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

    $('#saveEntity').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/"+viewName+"/save?"+serializeNotNull($('#modal').serialize()),
            function (data, status) {
                if (status != "success") {
                    showToast("<i class='warning icon'></i>连接服务器失败！");
                }else {
                    if(data.msg=="success"){
                        showToast("<i class='archive icon'></i>保存成功");
                        getInfoList(viewName, arr, currentPage,true,orderBy,sequence);
                    }else {
                        showToast("<i class='remove circle outline icon'></i>"+data.msg);
                    }
                }
            });
    });

    $('#insertEntity').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/"+viewName+"/add?"+serializeNotNull($('#newModal').serialize()),
            function (data, status) {
                if (status != "success") {
                    showToast("<i class='warning icon'></i>连接服务器失败！");
                }else {
                    if(data.msg=="success"){
                        showToast("<i class='archive icon'></i>保存成功");
                        $('.ui.myNew.modal').modal('hide')
                        getInfo(viewName,data.id)
                        getInfoList(viewName, arr, currentPage,true,orderBy,sequence);
                    }else {
                        showToast("<i class='remove circle outline icon'></i>"+data.msg);
                    }
                }
            });
    });

    $('#myPicture').click(function () {
        document.getElementById('file').click();
    })

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
            var head = "<tr id='" +list[i].sale_id+"' class='center aligned'>\n" +
                "    <td>\n" +
                "    <div class='ui checkbox'>\n" +
                "    <input type='checkbox' name='item' value='"+list[i].sale_id+"'><label></label>\n" +
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

