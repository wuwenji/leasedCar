<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>订单详情</title>
</head>
<body class="window">
	<table class="layui-table">
		 <colgroup>
		      <col width="110">
		      <col width="100">
		      <col width="110">
		      <col width="180">
		      <col width="110">
		      <col width="180">
		      <col>
	    </colgroup>
		<tr>
		  <td style="text-align: right;">起始点：</td>
		  <td>${backOrder.startPoint}</td>
		  <td style="text-align: right;">目的地：</td>
		  <td>${backOrder.endPoint}</td>
		</tr>
		<tr>
			<td style="text-align: right;">途经点：</td>
			<td colspan="3">${backOrder.viaPointStr}</td>
		</tr>
		<tr>
			<td style="text-align: right;">预估路程：</td>
			<td><fmt:formatNumber type="number" value="${backOrder.distance/1000.0}" pattern="0.00" maxFractionDigits="2"/>(公里)</td>
			<td style="text-align: right;">预估时长：</td>
		  	<td><fmt:formatNumber type="number" value="${backOrder.duration/60.0}" pattern="0.00" maxFractionDigits="2"/>(分钟)</td>
		</tr>
		<tr>

			<td style="text-align: right;">最早出发时间：</td>
			<td><fmt:formatDate value="${backOrder.earliestDepartureTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td style="text-align: right;">最晚出发时间：</td>
			<td><fmt:formatDate value="${backOrder.latestDepartureTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		<tr>
			<td style="text-align: right;">车型：</td>
		  	<td>${backOrder.carType}</td>
			<td style="text-align: right;">优惠价：</td>
			<td>${backOrder.discountPrices}</td>
		</tr>
	</table>
</body>
</html>