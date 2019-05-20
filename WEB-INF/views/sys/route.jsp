<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/layui/css/layui.css">
    <script src="${ctx}/static/js/jquery-3.2.1.min.js"></script>
    <script src="${ctx}/static/layui/layui.js"></script>
    <link rel="stylesheet" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" href="${ctx}/static/css/platform.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/css/transport.css">
</head>
<body>

<form id="searchForm" action="${ctx}/sys/route" class="layui-form" method="post">
    <input type="hidden" name="pageNum" value="${order.pageNum}"/>
    <input type="hidden" name="pageSize" value="${order.pageSize}"/>

    <div class="button_right">
        <%--<input type="text" id="test6" name="beginTime" class="layui-input input_date" placeholder="开始时间" value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd HH:mm:ss" />'>--%>
        <%--<input type="text" id="test7" name="endTime" class="layui-input input_date" placeholder="结束时间" value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd HH:mm:ss" />'>--%>
        <input type="text" name="carNum" class="layui-input" placeholder="请输入车牌号" value="${order.carNum}">
        <input type="text" name="driverName" class="layui-input" placeholder="请输入司机名字" value="${order.driverName}">
        <input type="text" name="orderCode" class="layui-input" placeholder="请输入关键字" value="${order.orderCode}">
        <button type="button" class="layui-btn layui-btn-small" onclick="searchSelf();">搜索</button>
    </div>
    <div class="cl"></div>
    <table class="layui-table">
        <thead>
        <tr>
            <th>订单号</th>
            <th>路线</th>
            <th>上车时间</th>
            <th>下车时间</th>
            <th>司机</th>
            <th>车牌号</th>
            <th>订单状态</th>
            <th>线路偏差</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini examine">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini examine">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini examine">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini examine">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini examine">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini">审核</a></td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>DH-201801020914046_01</td>--%>
            <%--<td>文雅苑-江门第一中学</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>2017-01-03 12:00:00</td>--%>
            <%--<td>司机</td>--%>
            <%--<td>粤A12345</td>--%>
            <%--<td>完成</td>--%>
            <%--<td>是</td>--%>
            <%--<td>已审核</td>--%>
            <%--<td><a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-mini">审核</a></td>--%>
        <%--</tr>--%>
            <c:forEach items="${routes.list}" var="item">
                <tr>
                    <td>${item.orderCode}</td>
                    <td>${item.startPoint} — ${item.endPoint}</td>
                    <td><fmt:formatDate value="${item.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td><fmt:formatDate value="${item.debusTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td>${item.driverName}</td>
                    <td>${item.carNum}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == -4}">已取消</c:when>
                            <c:when test="${item.status == -3}">被拒绝</c:when>
                            <c:when test="${item.status == -2}">待匹配</c:when>
                            <c:when test="${item.status == -1}">匹配中</c:when>
                            <c:when test="${item.status == 0}">待确定</c:when>
                            <c:when test="${item.status == 1}">等待上车</c:when>
                            <c:when test="${item.status == 2}">在途</c:when>
                            <c:when test="${item.status == 3}">已完成</c:when>
                            <c:when test="${item.status == 4}">支付超时</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.deviation == 1}">是</c:when>
                            <c:otherwise>否</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test='${ item.isExamine > 0 }'>已审核</c:when>
                            <c:otherwise>未审核</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="javascript:void(0);" onclick="examine('${item.orderCode}');" class="layui-btn layui-btn-primary layui-btn-mini">
                            <c:choose>
                                <c:when test='${ item.isExamine > 0 }'>查看</c:when>
                                <c:otherwise>审核</c:otherwise>
                            </c:choose>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <tags:page pages="${routes}"/>
</form>
<script>
    function examine(orderCode){
        parent.layer.open({
            type: 2,
            title: '审核信息',
            shadeClose: true,
            shade: 0.5,
            area: ['1230px','600px'],
            content: '${ctx}/sys/routeExamine?orderCode='+orderCode
        })
    }

    function searchSelf() {
        $("[name='pageNum']").val(1);
        $("#searchForm").submit();
    }
    //$('.examine').click(examine)
</script>


</body>
</html>
<script src="${ctx}/static/js/layui.john.js"></script>
<script src="${ctx}/static/js/john.js"></script>
