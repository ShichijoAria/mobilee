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
                if(j==arr[n]) {
                    body += "<td class='td'>" + list[i][j] + "</td>";
                }
            }
        }
        html+=head+body+"</tr>";
    }
    $('tbody').append(html);
}


//获取列表信息
function getInfoList(module,arr) {
    $.post("/mobilee/"+module+"/list.action",
        {

        },
        function (data, status) {
            $('form').removeClass('loading');
            if (status != "success") {
                showError(["无法连接服务器"]);
            }else {
                if(data.msg=="success"){

                }else {
                    addInfoList(arr,data);
                }
            }
        });
}

function changeSize() {
    $('form').outerWidth($('body').width())
    $('#foot').width($('body').width())
    $('.ui.input').outerWidth($('input').outerWidth())
    $('.ui.grid.stackable.centered.segment.three.column.vertical.container').outerWidth($('form').outerWidth())
}