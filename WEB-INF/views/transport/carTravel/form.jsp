<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加/编辑行程</title>
</head>
<body class="window">
<div class="layui-form" style="margin-top: 10px;">
    <form id="saveOrUpdate" class="layui-form" action="${ctx}/transport/carTravel/saveOrUpdate" method="post">
        <input type="hidden" name="id" value="${carTravel.id}"/>
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col width="150">
                <col width="200">
                <col width="200">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>车牌号</th>
                <th>车辆状况</th>
                <th>开始时间</th>
                <th>结束时间</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <select name="carCode" lay-verify="required|requestCarCode" lay-search=""
                            <c:if test="${not empty carTravel.id}">disabled</c:if>>
                        <option value="">选择车辆</option>
                        <c:forEach items="${cars}" var="car" varStatus="status">
                            <option value="${car.carCode}"
                                    <c:if test="${carTravel.carCode == car.carCode}">selected="selected"</c:if>>${car.carNum}(${car.carType})
                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select name="carState" lay-verify="required|check" lay-search="" readonly="readonly">
                        <option value="1" <c:if test="${carTravel.carState == 1}">selected="selected"</c:if>>保养</option>
                        <option value="2" <c:if test="${carTravel.carState == 2}">selected="selected"</c:if>>维修</option>
                        <option value="3" <c:if test="${carTravel.carState == 3}">selected="selected"</c:if>>事故</option>
                        <option value="4" <c:if test="${carTravel.carState == 4}">selected="selected"</c:if>>自运营
                        </option>
                    </select>
                </td>
                <td>
                    <input class="layui-input input_date" id="startTime" name="startTime" lay-verify="required"
                           placeholder="开始时间" type="text"
                           value="<fmt:formatDate type='date' value='${carTravel.startTime}'/>"/>
                </td>
                <td>
                    <input class="layui-input input_date" id="endTime" name="endTime" lay-verify="required"
                           placeholder="结束时间" type="text"
                           value="<fmt:formatDate type='date' value='${carTravel.endTime}'/>"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<script type="text/javascript">
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        lay('.input_date').each(function(){
            laydate.render({
                elem: this
                ,trigger: 'click'
                ,type: 'datetime'
                ,format: 'yyyy-MM-dd HH:mm'
            });
        });
    })
    //文档加载完毕执行
    $(function () {
        var message = '${message}';
        if (message != null && "" != message) {
            var msg = message.split("@");
            setTimeout(function () {
                layer.msg(msg[0], {icon: msg[1]});
                setTimeout(function () {
                    parent.layer.closeAll(); //疯狂模式，关闭所有层
                    parent.selfSubmit();   //刷新页面
                }, 1000);
            }, 500);

            if (msg[0] == '新建成功') {
                setTimeout(function () {
                    parent.layer.closeAll(); //疯狂模式，关闭所有层
                    parent.selfSubmit();   //刷新页面
                }, 1500);

            }
        }
    });

    //提交表单
    function laySubmit() {
        $('#saveOrUpdate').submit();
    }


    //加载表单
    layui.use(['form', 'element', 'laydate'], function () {

        /* var laydate = layui.laydate;
         //执行laydate实例
         laydate.render({
         elem: '#startTime' //指定元素
         ,type: 'datetime'
         ,theme: '#0071bf'
         });
         //日期时间选择器
         laydate.render({
         elem: '#endTime'
         ,type: 'datetime'
         ,theme: '#0071bf'
         }); */

        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function (data) {
            //layer.msg(JSON.stringify(data.field));
            return true;
        });

        //自定义验证规则
        form.verify({
            //只能输入数字
            integer: function (value, item) {
                if (!/^[0-9]*$/.exec(value)) {
                    return "只能输入数字";
                }
            },
            requestCarCode: function (value, item) {


                var startTime = $('#startTime').val();

                var endTime = $('#endTime').val();
                var va;


                $.ajax({
                    type: "POST",
                    async: false,
                    url: "${ctx}/transport/carTravel/checkCarCore",
                    data: {'carCode': value, 'startTime': startTime, 'endTime': endTime},
                    dataType: "json",
                    success: function (data) {

                        va = data.state
                    }
                });
                if (va == '1') {
                    return '该车辆已存在订单，请先对应订单的车辆再进行设置！';
                }
            },
            check: function (value, item) {
                var type = 'success';
                if (value == '4') {
                    $.ajax({
                        type: "POST",
                        async: false,
                        url: "${ctx}/transport/carTravel/checkNum",
                        data: {},
                        dataType: "json",
                        success: function (data) {
                            type = data.state;

                        }
                    });
                }


                if (type == 'success') {

                } else {
                    return '已经超出可设置自运营车的上限！';
                }

            }
        });
    });
</script>
</body>
</html>