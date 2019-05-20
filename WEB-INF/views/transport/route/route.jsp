<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>线路管理</title>
</head>
<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 线路管理 -> 线路管理</div>
            </div>

            <div>
                <form id="searchForm" class="layui-form" action="${ctx}/transport/route/route">
                    <input type="hidden" name="pageNum" value="${order.pageNum}"/>
                    <input type="hidden" name="pageSize" value="${order.pageSize}"/>
                    <div class="info">
                        <div class="button_right john-edge">
                            <div class="layui-inline">
                                <%--<input type="text" id="test6" class="layui-input input_date" placeholder="选择开始时间">--%>
                                <%--<input type="text" id="tiime_john" class="layui-input input_date" placeholder="选择结束时间">--%>
                                <input type="text" class="layui-input" placeholder="请输入车牌号" name="carNum"
                                       value="${order.carNum}">
                                <input type="text" class="layui-input" placeholder="请输入司机姓名" name="driverName"
                                       value="${order.driverName}">
                                <input type="text" class="layui-input" placeholder="请输入关键字" style="width: 130px;"
                                       name="orderCode" value="${order.orderCode}">
                                <a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0);"
                                   onclick="searchSelf();">搜索</a>
                            </div>
                        </div>
                        <div class="cl"></div>
                    </div>
                    <div class="layui-form">
                        <table class="layui-table">
                            <thead>
                            <tr>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单号</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">路线</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">上车时间</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">下车时间</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">司机</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">车牌号</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单状态</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">线路偏差</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">审核状态</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">操作</a></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="${ctx}/transport/route/routeDetail?orderCode=DH-201801311737000_01" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">DH-201801311737000_01</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                            <%--<td><a href="javascript:;" class="details_a">2017082612120000332</a></td>--%>
                            <%--<td>文雅苑-江门第一中学</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>2018-01-03 12:00:00</td>--%>
                            <%--<td>张小小</td>--%>
                            <%--<td>粤A12345</td>--%>
                            <%--<td>完成</td>--%>
                            <%--<td>是</td>--%>
                            <%--<td>已审核</td>--%>
                            <%--<td><a href="line-1.html" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-edit"></i> 查看</a></td>--%>
                            <%--</tr>--%>
                            <c:forEach items="${routes.list}" var="item">
                                <tr>
                                    <td style="text-align: center;">${item.orderCode}</td>
                                    <td style="text-align: center;">${item.startPoint} — ${item.endPoint}</td>
                                    <td style="text-align: right;"><fmt:formatDate value="${item.boardingTime}"
                                                                                   pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td style="text-align: right;"><fmt:formatDate value="${item.debusTime}"
                                                                                   pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td style="text-align: center;">${item.driverName}</td>
                                    <td style="text-align: center;">${item.carNum}</td>
                                    <td style="text-align: center;">
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
                                    <td style="text-align: center;">
                                        <c:choose>
                                            <c:when test="${item.deviation == 1}">是</c:when>
                                            <c:otherwise>否</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: center;">
                                        <c:choose>
                                            <c:when test='${ item.isExamine > 0 }'>已审核</c:when>
                                            <c:otherwise>未审核</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="javascript:void(0);"
                                           onclick="location.href = '${ctx}/transport/route/routeDetail?orderCode=${item.orderCode}'"
                                           class="layui-btn layui-btn-primary layui-btn-mini">
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
                    </div>
                    <tags:page pages="${routes}"/>
                </form>
                <div id="demo7"></div>
            </div>
        </main>
    </div>
</section>
<script type="text/javascript">
    function searchSelf() {
        $("[name='pageNum']").val(1);
        $("#searchForm").submit();
    }
</script>
</body>
</html>
