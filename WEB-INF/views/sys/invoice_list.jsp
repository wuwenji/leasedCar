<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>订单提醒</title>
	<script>
        //type 1: 批量  2：单个
        function remind(type, ids) {
            $.ajax({
                type:"post",
                url:"${ctx}/remind/remind",
                dataType:"json",
                data:{"ids": ids, "type": type},
                success:function(data) {
                    if(data.state){
                        layer.msg('提醒成功！',{
                            time: 1000,
                            skin: 'layui-layer-molv',
                            area: '20px',
                            icon: 1
                        }, function(){
                        });
                    }else{
                        layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "提醒失败！"
                        });
                    }
                }
            });
        }
	</script>
</head>
<body>
<form id="searchForm" action="${ctx}/sys/invoice" method="post" class="layui-form">
	<input type="hidden" name="pageNum" value="${order.pageNum}"/>
	<input type="hidden" name="pageSize" value="${order.pageSize}"/>
	<input type="hidden" id="order" name="order" value="${order.order}"/>
	<input type="hidden" id="sortType" name="sortType" value="${order.sortType}"/>
	<input type="hidden" name="remindType" value="${order.remindType}"/>
	<div class="button_left">
		<!-- <a class="layui-btn layui-btn-primary layui-btn-mini" href="javascript:;" onclick="remind(1, null)">批量提醒</a> -->
	</div>
	<div class="button_right">
		<div class="layui-inline">
			<label class="layui-form-label">出发日期：</label>
			<div class="layui-input-inline" style="top: 5px;">
                <%--<input class="layui-input search_text input_date" id="beginTime" name="beginTime" type="text"--%>
                       <%--value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'--%>
                       <%--onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})"/>--%>
				<input class="layui-input search_text input_date" id="beginTime" name="beginTime" type="text"
					   value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>_
			</div>
			<div class="layui-input-inline" style="top: 5px;">
				<input class="layui-input search_text input_date" id="endTime" name="endTime" type="text"
					   value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
			</div>
		</div>
		<button class="layui-btn layui-btn-small">搜索</button>
	</div>
	<div class="cl"></div>
	<table class="layui-table">
		<colgroup>
			<col width="50">
			<col width="180">
			<col width="160">
			<col width="160">
			<col width="200">
			<col width="200">
			<col width="170">
			<col width="100">
			<col width="120">
			<col width="100">
			<col>
		</colgroup>
		<thead>
		<tr>
			<th><input name="" lay-skin="primary" lay-filter="allChoose" type="checkbox"></th>
			<th><a id="order_code" onclick="sort(this);" style="cursor: pointer;">订单号</a></th>
			<th><a id="u.user_account" onclick="sort(this);" style="cursor: pointer;">包车方</a></th>
			<th><a id="c.company_name" onclick="sort(this);" style="cursor: pointer;">运输方</a></th>
			<th><a id="start_point" onclick="sort(this);" style="cursor: pointer;">上车地点</a></th>
			<th><a id="end_point" onclick="sort(this);" style="cursor: pointer;">下车地点</a></th>
			<th><a id="boarding_time" onclick="sort(this);" style="cursor: pointer;">上车时间</a></th>
			<th><a id="t.status" onclick="sort(this);" style="cursor: pointer;">订单状态</a></th>
			<th><a id="payment_status" onclick="sort(this);" style="cursor: pointer;">支付情况</a></th>
			<th><a id="settlement" onclick="sort(this);" style="cursor: pointer;">结算情况</a></th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${orders.list}" var="info" varStatus="vs">
			<tr>
				<td>
					<input name="singleCheck" lay-skin="primary" lay-filter="singleChoose" type="checkbox"/>
				</td>
				<td><a href="javascript:query('${info.orderCode}',1);" style="color: orange;">${info.orderCode}</a></td>
				<td>${info.placerAccount}</td>
				<td>${info.companyName}</td>
				<td>${info.startPoint}</td>
				<td>${info.endPoint}</td>
				<td><fmt:formatDate value="${info.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<c:choose>
						<c:when test="${info.status == -4}">已取消</c:when>
						<c:when test="${info.status == -3}">被拒绝</c:when>
						<c:when test="${info.status == -2}">待匹配</c:when>
						<c:when test="${info.status == -1}">匹配中</c:when>
						<c:when test="${info.status == 0}">待确定</c:when>
						<c:when test="${info.status == 1}">等待上车</c:when>
						<c:when test="${info.status == 2}">在途</c:when>
						<c:when test="${info.status == 3}">已完成</c:when>
						<c:when test="${info.status == 4}">支付超时</c:when>
					</c:choose>
				</td>
				<td>
					<c:if test="${info.paymentStatus == 1 && info.paymentType == 1}">未支付-现付</c:if>
					<c:if test="${info.paymentStatus == 1 && info.paymentType == 2}">未支付-月结</c:if>
					<c:if test="${info.paymentStatus == 2}">已支付</c:if>
				</td>
				<td>
					<c:if test="${info.settlement == 1}">未结算</c:if>
					<c:if test="${info.settlement == 2}">已结算</c:if>
				</td>
				<td>
					<c:if test="${info.orderStatus == 1}">
						<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-mini" onclick="detil('${info.orderCode}',1)">发票审核</a>
					</c:if>
					<c:if test="${info.orderStatus == 2}">
						<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-mini" onclick="detil('${info.orderCode}',2)">填写快递单号</a>
					</c:if>
					<c:if test="${info.orderStatus == 3}">
						<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-mini" onclick="detil('${info.orderCode}',3)">修改快递单号</a>
					</c:if>

				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<tags:page pages="${orders}"/>
</form>
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
    $(document).ready(function(){

    });


    function detil(ordercode,orderStatus) {

        layer.open({
            type: 2,
            title: '查看发票信息',
            shadeClose: true,
            shade: 0.5,
            scrollbar:false,
            area: ['1000px','500px'],
            content: '${ctx}/sys/detil?orderCode='+ordercode+'&orderStatus='+orderStatus
        })
    }

</script>
</body>
</html>