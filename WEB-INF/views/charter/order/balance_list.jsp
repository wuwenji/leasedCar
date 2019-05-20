<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>个人中心</title>
<style type="text/css">
	.button_left label{float: left;}
	.button_left span{float: left;}
	.info{
		min-height: 40px !important;
	}
</style>
</head>
<body>
<section>
	<div class="container">
	<jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
		<main>
		<div class="position_all">
			<div class="position">您所在的位置：首页 -> 个人中心 -> 费用结算</div>
		</div>
		<div class="">
			<form id="searchForm" action="${ctx}/charter/order/balanceList" method="post">
                   <input type="hidden" name="pageNum" value="${order.pageNum}"/>
                   <input type="hidden" name="pageSize" value="${order.pageSize}"/>
				<div class="info">
				<div class="button_left">
					<div class="layui-inline">
						<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0);" onclick="batchWechatPay();">批量微信付款</a>
					</div>
					<div class="layui-inline">
						<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0);" onclick="batchBalancePay();">批量余额付款</a>
					</div>
				</div>
				<div class="button_right">
					<div class="layui-inline">
						<label class="layui-form-label">出发日期：</label>
						<div class="layui-input-inline" style="top: 5px;">
							<input class="layui-input search_text input_date yearm" id="beginTime" name="beginTime" type="text"
							value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>_
						</div>
						<div class="layui-input-inline" style="top: 5px;">
							<input class="layui-input search_text input_date yearm" id="endTime" name="endTime" type="text"
							value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
						</div>
					</div>
					<div class="layui-inline">
						<a class="layui-btn layui-btn-danger layui-btn-small" href="#" onclick="submitCharterForm();">搜索</a>
					</div>
				</div>
				</div>
				<div class="cl"></div>
				<div class="layui-form">
                     <c:forEach items="${orders.list}" var="ord">
                         <table class="layui-table" lay-even="" lay-skin="nob" style="border: 1px solid #CCC;">
						<colgroup>
							<col width="250">
						    <col width="250">
						    <col width="100">
						    <col width="100">
							<col width="200"/>
						</colgroup>
                           	<thead>
						    <tr>
						      <th colspan="5">
								  <input type="checkbox" lay-filter="check_order" name="check_order" lay-skin="primary" value="${ord.orderCode}" />
								订单号：<a href="javascript:query('${ord.orderCode}',1);" style="color: orange;">${ord.orderCode}</a>
								<c:if test="${ord.recordStatus == 0 }">
									<a href="javascript:orderCharterDel('${ctx}','${ord.orderCode}');">删除订单</a>
								</c:if>
								<c:if test="${ord.recordStatus == 1 }">
									<a href="#" style="color: red;">已删除</a>
								</c:if>
						      </th>
						      
						    </tr> 
						  </thead>
						  <tbody>
						    <tr>
						      <td>${ord.startPoint} — ${ord.endPoint}</td>
						      <td><fmt:formatDate value="${ord.placeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						      <td><span class="orange"><b>
							      <c:choose>
							      	<c:when test="${ord.amount != null}">￥${ord.amount}</c:when>
							      	<c:when test="${ord.amount == null}">￥0</c:when>
							      </c:choose>
							      </b></span>
						      </td>
						      <td>
							      <c:choose>
							      	<c:when test="${ord.paymentStatus == 1}">未付款</c:when>
							      	<c:when test="${ord.paymentStatus == 2}">已付款</c:when>
							      </c:choose>
						      </td>
						      <td>
						      	<c:if test="${ord.recordStatus == 0 && ord.paymentStatus == 1}">
						      		<a href="javascript:wechatPay('${ord.bigOrderCode}','${ord.prices}');" class="layui-btn layui-btn-normal layui-btn-mini">付款</a>
									<a href="javascript:balancePay('${ord.bigOrderCode}','${ord.prices}');" class="layui-btn layui-btn-normal layui-btn-mini">余额付款</a>
						      	</c:if>
						      </td>
						    </tr>
						    </tbody>
						</table>    
                      </c:forEach>
				</div>
			</form>
		</div>
           <tags:page pages="${orders}"/>
		</main>
	</div>
</section>
<script type="text/javascript">

	//订单号，以逗号隔开
	var orderCodes = "";

    //订单详情
    function query(orderCode,type){
        var width ="1000px";
        var height = "400px;";
        var title ="查看订单详情";
        if(type ==1){
            height = "400px;";
            title ="查看订单详情";
        }else if(type ==3){
            height = "560px;";
            title ="订单投诉";
        }
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar:false,
            yes: function(index, layero){
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
				console.log()
                iframeWin.laySubmit();//执行iframe页的方法：
            },
            area: [width,height],
            content: '${ctx}/charter/order/query?orderCode='+orderCode+'&type='+type
        })
    }


function submitForm(){
	var beginTime = $("#test1").val();
	var endTime = $("#test2").val();
	if((beginTime == null || '' == beginTime) && (endTime != null && '' != endTime)){
           layer.tips('开始日期不能为空！', '#beginTime', {tips: [3, '#78BA32']});
           return false;
       }
	$("#searchForm").submit();
}
function wechatPay(bigOrderCode,prices){
	var width ="400px";
	var height = "300px;"
	var title ="订单支付";
	  layer.open({
	    type: 2,
	    title: title,
	    shadeClose: true,
	    shade: 0.5,
        scrollbar:false,
	    yes: function(index, layero){
	    	 var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
	    	 iframeWin.laySubmit();//执行iframe页的方法：
	    },
	    area: [width,height],
		  content: '${ctx}/charter/wechat/newscanPay?bigOrderCode='+bigOrderCode+'&prices='+prices+'&actiontype=3'
	  })
}

function balancePay(bigOrderCode,prices) {

    var content = '确定提交吗？';

    layer.confirm(content, {icon: 3, title:'提示',scrollbar:false}, function(index){
        $('.layui-layer-btn0').css('pointer-events','none');
        $.ajax({
            type:"post",
            url:"${ctx}/charter/balancePay/balancePay",
            dataType:"json",
            data:{"bigOrderCode":bigOrderCode,"prices":prices},
            success:function(data) {
                if(data.state == 1){
                    layer.open({
                        icon: 1,
                        title: '信息',
                        skin: 'layer-ext-myskin',
                        shade: 0, //不显示遮罩
                        scrollbar:false,
                        content: "支付成功！",
                        yes: function(){
                            parent.layer.closeAll();
                            parent.location.reload();
                        },
                    });
                }else if(data.state ==2){
                    layer.open({
                        icon: 2,
                        title: '信息',
                        skin: 'layer-ext-myskin',
                        shade: 0, //不显示遮罩
                        scrollbar:false,
                        content: "余额不足，支付失败！",
                    });
                }else if(data.state ==3){
                    layer.open({
                        icon: 2,
                        title: '信息',
                        skin: 'layer-ext-myskin',
                        shade: 0, //不显示遮罩
                        scrollbar:false,
                        content: "支付失败,请联系管理员！",
                    });
                }
            }
        });
    });
}

//批量微信付款
function batchWechatPay(){
    if(orderCodes.trim() <= 0  || orderCodes.trim() == "" || orderCodes.trim() == null || orderCodes.trim() == undefined){
        layer.msg('请勾选要付款的订单！');
        return;
	}
	var width ="400px";
	var height = "300px;";
	var title ="订单支付";
	layer.open({
		type: 2,
		title: title,
		shadeClose: true,
		shade: 0.5,
        scrollbar:false,
		yes: function(index, layero){
			var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
			iframeWin.laySubmit();//执行iframe页的方法：
		},
		area: [width,height],
		content: '${ctx}/charter/wechat/newscanPay?bigOrderCode='+orderCodes+'&actiontype=4'
	})
}

//批量余额付款
function batchBalancePay() {
    if(orderCodes.trim() <= 0  || orderCodes.trim() == "" || orderCodes.trim() == null || orderCodes.trim() == undefined){
        layer.msg('请勾选要付款的订单！');
        return;
    }
	var content = '确定提交吗？';
	layer.confirm(content, {icon: 3, title:'提示',scrollbar:false}, function(index){
		$('.layui-layer-btn0').css('pointer-events','none');
		$.ajax({
			type:"post",
			url:"${ctx}/charter/balancePay/balanceMultiplePay",
			dataType:"json",
			data:{"bigOrderCode":orderCodes},
			success:function(data) {
				if(data.state == 1){
					layer.open({
						icon: 1,
						title: '信息',
						skin: 'layer-ext-myskin',
						shade: 0, //不显示遮罩
                        scrollbar:false,
						content: "支付成功！",
						yes: function(){
							parent.layer.closeAll();
							parent.location.reload();
						},
					});
				}else if(data.state ==2){
					layer.open({
						icon: 2,
						title: '信息',
						skin: 'layer-ext-myskin',
						shade: 0, //不显示遮罩
                        scrollbar:false,
						content: "余额不足，支付失败！",
					});
				}else if(data.state ==3){
					layer.open({
						icon: 2,
						title: '信息',
						skin: 'layer-ext-myskin',
						shade: 0, //不显示遮罩
                        scrollbar:false,
						content: "支付失败,请联系管理员！",
					});
				}
			}
		});
	});
}

//查询
function submitCharterForm(){
	var beginTime = $("#test1").val();
	var endTime = $("#test2").val();
	if((beginTime == null || '' == beginTime) && (endTime != null && '' != endTime)){
	    layer.tips('开始日期不能为空！', '#beginTime', {tips: [3, '#78BA32']});
	    return false;
	}
	$("#searchForm").submit();
}

//获取所有选中checkbox的值
function queryCheckedValue() {
	var str = "";
	$("input:checkbox[name='check_order']:checked").each(function() {
		var val = $(this).val();
		if(str.length > 0){
		    str += "," + val;
		}else{
		    str += val;
		}
	});
	return str;
}

layui.use(['layer', 'form'], function(){
	var form = layui.form;
	form.on('checkbox(check_order)', function(data){
        orderCodes = queryCheckedValue();
	});
});
</script>
</body>
</html>