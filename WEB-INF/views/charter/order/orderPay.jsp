<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>订单支付</title>
</head>
<body class="window">
    <form class="layui-form" style="display: none;">
        <input type="hidden" name="bigOrderCode" id="bigOrderCode" value="${order.bigOrderCode}" />
        <input type="hidden" name="actionType" id="actionType" value="${actionType}" />
        <input type="hidden" name="prices" id="prices" value="${prices}" />
    </form>
	<table class="layui-table">
		 <colgroup>
		      <col width="120">
		      <col width="130">
		      <col>
	    </colgroup>
		<tr>
		  <td style="text-align: right;">支付金额(单位：元)：</td>
		  <td>${prices}</td>
		</tr>
        <tr>
            <td style="text-align: right;">支付方式：</td>
            <td>
                <c:if test="${actionType == 1 || actionType == 3 || actionType == 5}">
                    银联支付
                </c:if>
                <c:if test="${actionType == 2 || actionType == 4}">
                    线下支付
                </c:if>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">手续费(单位：元)：</td>
            <td>${serviceCharge}</td>
        </tr>
	</table>
<script>
    function submitOrderPay() {
        var bigOrderCode = $("#bigOrderCode").val();
        var actionType = $("#actionType").val();
        var prices = $("#prices").val();
        var formData = {};
        if(bigOrderCode != "" && bigOrderCode != null && bigOrderCode != undefined){
            formData.bigOrderCode = bigOrderCode;
            formData.actionType = actionType;
            formData.prices = prices;

        }else{
            layer.msg("出错，请刷新页面重试");
        }

        return formData;
    }
</script>
</body>
</html>