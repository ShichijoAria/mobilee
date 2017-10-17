"use strict"

function showError(arr) {
    $('.ui.error.message').css("display","none");
    $('ul.list').empty();
    for(i in arr){
        var html="<li>"+arr[i]+"</li>";
        $('ul.list').append(html);
    }
    $('.ui.error.message').css("display","block");
}

//添加列表信息到页面
function addInfoList(arr,data) {
    var list=data.list;
    var html='';
    for(var i in list) {
        var head = "<tr id='" +list[i].id+"' class='center aligned'>\n" +
            "    <td>\n" +
            "    <div class='ui checkbox'>\n" +
            "    <input type='checkbox' name='item' value='"+list[i].id+"'><label></label>\n" +
            "    </div>\n" +
            "    </td>";
        var body="";
        for (var n in arr){
            for(var j in list[i]){
                console.log(j)
                console.log(j==arr[n])
                if(j==arr[n]) {
                    body += "<td class='td'>" + list[i][j] + "</td>";
                }
            }
        }
        html+=head+body+"</tr>";
    }
    $('tbody').html(html);
    $('tbody')
        .transition('fade')
    ;
}
//获取列表信息
function getInfoList(module,arr,param) {
    $.post("/mobilee/"+module+"/list.action?page="+param,
        {

        },
        function (data, status) {
            $('form').removeClass('loading');
            if (status != "success") {
                showError(["无法连接服务器"]);
            }else {
                if(data.msg=="success"){

                }else {
                    $('tbody')
                        .transition({
                            animation  : 'fade',
                            onComplete:function () {
                                addInfoList(arr,data);
                                generatePagination(data.total,data.page,module)
                                var select="a[page='"+data.page+"']";
                                $(select).addClass('active');
                            }
                        })
                    ;
                }
            }
            $('#segment').removeClass('loading');
        });
}

function changeSize() {
    $('form').outerWidth($('body').width())
    $('#foot').width($('body').width())
    $('.ui.input').outerWidth($('input').outerWidth())
    $('.ui.grid.stackable.centered.segment.three.column.vertical.container').outerWidth($('form').outerWidth())
}

//生成分页菜单
function generatePagination(total,curPage,viewName) {
    var array=[1];
    if(total<=0){
        array.pop();
    }else if(curPage<total&&curPage>1){
        if(curPage=2)
            array.push(2);
        if(curPage>2) {
            if(curPage>3) {
                array.push(0);
            }
            array.push(curPage - 1)
        }
        if(curPage!=total-1) {
            array.push(curPage);
            array.push(curPage + 1)
            if(curPage<total-2)
                array.push(0);
        }
        array.push(total);
    }else if(total>2){
        array.push(2);
        array.push(total);
    }else if (total>3){
        array.push(2);
        array.push(0)
        array.push(total);
    }else {
        array.push(2);
    }
    var html=array.map(pageItem).join('');
    $('#pagination').html(html);
    bind(viewName);
}
function pageItem(i) {
    if(i>0)
        return "<a class='item' page='"+i+"'>"+i+"</a>";
    return "<div class='disabled item'>...</div>";
}
function bind(viewname) {
    $('a.item').click(function () {
        if($(this).attr('page')!=undefined) {
            getInfoList(viewname, arr, $(this).attr('page'))
        }
    });
}

//全选或取消全选
function bindCheck() {
    $('#checkAll').click(function () {
        $("input[name='item']").prop('checked',$(this)[0].checked);
    });
}