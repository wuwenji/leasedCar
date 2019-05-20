<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
</head>
<body>
<form id="searchForm" action="${ctx}/charter/order/findSettlementOrderList" method="post" class="layui-form">

    <input type="hidden" name="pageNum" value="${billOrderVO.pageNum}"/>
    <input type="hidden" name="pageSize" value="${billOrderVO.pageSize}"/>
    <input type="hidden" name="pageSize" value="${billOrderVO.billOrderCode}"/>
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="30">
                <col width="250">
                <col width="100">
                <col width="250">
                <col width="250">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>订单号</th>
                <th>金额</th>
                <th>上车地点</th>
                <th>下车地点</th>
                <th>时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderList.list}" var="order" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td> ${order.orderCode}</td>
                    <td> ${order.amount}</td>
                    <td> ${order.startPoint}</td>
                    <td> ${order.endPoint}</td>
                    <td>
                        <fmt:formatDate value="${order.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <tags:page pages="${orderList}"/>
</form>
</body>
</html>