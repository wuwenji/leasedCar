<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>订单统计</title>
</head>
<body>
<form id="searchForm" action="${ctx}/sys/statistic/order" method="post" class="layui-form">
    <input type="hidden" name="pageNum" value="${order.pageNum}"/>
    <input type="hidden" name="pageSize" value="${order.pageSize}"/>
    <input type="hidden" id="dowloadExcel" name="dowloadExcel" value="${order.dowloadExcel}"/>
    <div class="button_left">
        <label class="layui-form-label">订单类型:</label>
        <div class="layui-input-block">
            <input type="radio" name="paramType" value="1" title="个人用户"
                   <c:if test="${order.paramType == 1}">checked</c:if> lay-filter="orderType">
            <input type="radio" name="paramType" value="2" title="包车方"
                   <c:if test="${order.paramType == 2}">checked</c:if> lay-filter="orderType">
        </div>
    </div>
    <div class="button_right">
        <div class="layui-inline">
            <label class="layui-form-label">日期范围：</label>
            <div class="layui-input-inline" style="top: 5px;">
                <input class="layui-input search_text input_date" id="beginTime" name="beginTime" type="text"
                       value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>_
            </div>
            <div class="layui-input-inline" style="top: 5px;">
                <input class="layui-input search_text input_date" id="endTime" name="endTime" type="text"
                       value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
            </div>
        </div>
        <div class="layui-inline">
            <input type="text" name="companyName" class="layui-input" placeholder="请输入企业名称"
                   value="${order.companyName}">
        </div>
        <div class="layui-inline">
            <input type="text" name="orderCode" class="layui-input" placeholder="请输入关键字" value="${order.orderCode}">
        </div>
        <button type="button" class="layui-btn layui-btn-small" onclick="search();">搜索</button>
        <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel();" lay-submit=""
                lay-filter="demo1">导出Execl
        </button>
    </div>
    <div class="cl"></div>
    <table class="layui-table">
        <colgroup>
            <col width="60">
            <col width="150">
            <col width="150">
            <col width="150">
            <col width="150">
            <col width="150">
            <col width="150">
            <col width="150">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>序号</th>
            <th>订单号</th>
            <th>起点</th>
            <th>途径点</th>
            <th>终点</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>运输企业</th>
            <%--<th>车牌</th>--%>
            <th>订单金额</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orders.list}" var="info" varStatus="vs">
            <tr>
                <td>${vs.index+1}</td>
                <td><a href="javascript:query('${info.orderCode}',1);" style="color: orange;">${info.orderCode}</a></td>
                <td>${info.startPoint}</td>
                <td>${info.viaPoint}</td>
                <td>${info.endPoint}</td>
                <td>
                    <fmt:formatDate value="${info.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    <fmt:formatDate value="${info.reserveOffTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>${info.companyName}</td>
                    <%--<td>${info.carNum}</td>--%>
                <td>
                    <fmt:formatNumber value="${info.amount}" pattern="#.##" minFractionDigits="2"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <tags:page pages="${orders}"/>
</form>
<div style="display: none">
    <form id="ExeclForm" action="${ctx}/sys/exportExcel" method="post" class="layui-form">
    </form>
</div>
<script type="text/javascript">
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        lay('.input_date').each(function(){
            laydate.render({
                elem: this
                ,trigger: 'click'
            });
        });
    })
    function query(orderCode, type) {
        var width = "1000px";
        var height = "400px;";
        var title = "查看订单详情";
        if (type == 1) {
            height = "400px;";
            title = "查看订单详情";
        } else if (type == 3) {
            height = "560px;";
            title = "订单投诉";
        }
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar:false,
            yes: function (index, layero) {
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                iframeWin.laySubmit();//执行iframe页的方法：
            },
            area: [width, height],
            content: '${ctx}/charter/order/query?orderCode=' + orderCode + '&type=' + type
        })
    }

    function search() {
        $("input[name='pageNum']").val(1);
        $("input[name='pageSize']").val(10);
        $("#searchForm").submit();
    }

    function exportExcel() {

        layui.use(['form'], function () {

            var form = layui.form;
            //监听提交


            form.on('submit(demo1)', function (data) {
                $("#dowloadExcel").val("1");

                $("#searchForm").submit();
                return false;
            });
        })

    }

    var radioType;
    layui.use(['form'], function () {

        var form = layui.form;

        form.on('radio(orderType)', function (data) {
            $("#dowloadExcel").val("2");
            radioType = data.value;
            var paramType = '${order.paramType}';
            if (paramType != data.value) {
                $("[name='pageNum']").val(1);//第一页
                $("[name='beginTime']").val("");
                $("[name='endTime']").val("");
                $("[name='companyName']").val("");
                $("[name='orderCode']").val("");
            }
            $("#searchForm").submit();
        });
    });


</script>
</body>
</html>
