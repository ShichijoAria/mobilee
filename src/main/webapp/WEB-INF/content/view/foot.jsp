<%--
  Created by IntelliJ IDEA.
  User: Ace
  Date: 2017/5/27
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</tbody>
</table>
</div>
<div class="ui borderless pagination menu" id="foot">
    <a class="active item">
        1
    </a>
    <div class="disabled item">
        ...
    </div>
    <a class="item">
        10
    </a>
    <a class="item">
        11
    </a>
    <a class="item">
        12
    </a>
</div>
</div>
</form>
<script>
    var arr=[];

    for(var i=1;i<$('th').length;i++){
        arr.push($('th')[i].id)
    }
    getInfoList("<%=viewName%>",arr)
    changeSize();
    $('.ui.dropdown').dropdown()/*下拉菜单初始化*/
    $(window).resize(function() {//缩放事件
        changeSize();
    });
    $('.ui.sidebar').sidebar({
        context: $('form'),
        useLegacy:true,
    })
    $('#search,.ui.right.grey.large.corner.label').click(function () {
        $('.ui.sidebar')
            .sidebar('toggle')
    })
    $('.ui.button.blue').click(function () {
        setAction('form',"/SIS/<%=viewName%>/view");
    })
    $("select#page").change(function() {
        setAction("form","/SIS/<%=viewName%>/view?curPage="+$('select').val());
    });
    $('td.td').click(function () {
        setAction("form","/SIS/<%=viewName%>/field?resourceId="+$(this).parent().attr("id"));
    })
    $('#new').click(function () {
        setAction('form',"/SIS/<%=viewName%>/open")
    })
    $('#delete').click(function () {
        setAction('form',"/SIS/<%=viewName%>/delete")
    })
    $('#reset').click(function () {
        $('.input').val("");
    });
    $('.ui.black.inverted.small.button').click(function () {
        setAction('form',"/SIS/grade/insert?classId="+$(this).parent().parent().attr("id"))
    })
    $('.ui.red.inverted.small.button').click(function () {
        setAction('form',"/SIS/grade/delete?id="+$(this).parent().parent().attr("id"))
    })
</script>
</body>
</html>
