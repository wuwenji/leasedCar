<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>个人中心</title>

</head>
<body>
	<section>
		<div class="container">
		<jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
			<main>
			<div class="position_all">
				<div class="position">您所在的位置：首页 -> 财务管理 -> 额度查询</div>
			</div>
			<div class="">
				<div class="searh searh1 integral">
					<p><h1 >用户额度信息  <a href="javascript:detail('${credit.companyCode}');" class="layui-btn layui-btn-normal layui-btn-mini">查看使用详情</a></h1></p>
					<p><shiro:principal property="name"/><br/>您的信用额度为：<span class="orange">${credit.totalCredit}</span>元<br/>已使用的额度为：<span class="orange">${credit.consumeCredit}</span>元<br/>剩余的额度为：<span class="orange">${credit.stockCredit}</span>元</a>&nbsp;<a href="javascript:unionPay('5','${credit.consumeCredit}');" class="layui-btn layui-btn-normal layui-btn-mini">结算</a></p>

					<!--<p>您的信用额度为：<span class="orange">${credit.totalCredit}</span>元</p>
					<p>已使用的额度为：<span class="orange">${credit.consumeCredit}</span>元&nbsp;<a href="javascript:wechatPay('${credit.consumeCredit}');" class="layui-btn layui-btn-normal layui-btn-mini">结算</a></p>
					<p>剩余的额度为：<span class="orange">${credit.stockCredit}</span>元</p>
					-->
					<div class="cl"></div>
		        </div>

				<!--
				<div>
					<form id="searchForm" action="${ctx}/credit/CreditDetail" method="post" class="layui-form" style="padding-top: 10px;">
						<input type="hidden" name="pageNum" value="${credit.pageNum}"/>
						<input type="hidden" name="pageSize" value="${credit.pageSize}"/>
						<input type="hidden" name="companyCode" value="${credit.companyCode}">
						<div class="button_left" style="border: 1px solid #e2e2e2;">
							<label class="layui-form-label">消费类型:</label>
							<div class="layui-input-block">
								<input type="radio" name="TabNum" value="1" title="消费情况"
									   <c:if test="${TabNum == 1}">checked</c:if> lay-filter="companyType">
								<input type="radio" name="TabNum" value="2" title="结算情况 "
									   <c:if test="${TabNum == 2}">checked</c:if> lay-filter="companyType">
								<input type="radio" name="TabNum" value="3" title="调整情况"
									   <c:if test="${TabNum == 3}">checked</c:if> lay-filter="companyType">
							</div>
						</div>
						<div class="button_right">
							<input type="text" name="param" class="layui-input" placeholder="请输入关键字" value="${credit.param}">
							<button id="submitBtn" class="layui-btn layui-btn-small">搜索</button>
						</div>

						<c:if test="${TabNum == 1}">
							<div class="cl"></div>
							<table class="layui-table">
								<colgroup>
									<col width="150">
									<col width="300">
									<col width="250">
									<col width="250">
								</colgroup>
								<thead>
								<tr>
									<th>序号</th>
									<th>订单号</th>
									<th>订单金额</th>
									<th>操作用户</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${credits.list}" var="credit" varStatus="vs">
									<tr>
										<td>${vs.index+1}</td>
										<td>${credit.orderCode}</td>
										<td>
												${credit.money}
										</td>
										<td> ${credit.userAccount}</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<tags:page pages="${credits}"/>
						</c:if>


						<c:if test="${TabNum == 2}">
							<div class="cl"></div>
							<table class="layui-table">
								<colgroup>
									<col width="60">
									<col width="300">
									<col width="250">
									<col width="250">
									<col width="250">
									<col width="250">
								</colgroup>
								<thead>
								<tr>
									<th>序号</th>
									<th>时间</th>
									<th>操作用户</th>
									<th>调整前</th>
									<th>调整额</th>
									<th>调整后</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${BalanceDetilBillPageInfo.list}" var="credit" varStatus="vs">
									<tr>
										<td>${vs.index+1}</td>
										<td>
											<fmt:formatDate value="${credit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
												${credit.userAccount}
										</td>
										<td> ${credit.balanceBefore}</td>
										<td> ${credit.balance}</td>
										<td> ${credit.balanceAfter}</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<tags:page pages="${BalanceDetilBillPageInfo}"/>
						</c:if>


						<c:if test="${TabNum == 3}">

							<div class="cl"></div>
							<table class="layui-table">
								<colgroup>
									<col width="60">
									<col width="300">
									<col width="250">
									<col width="250">
									<col width="250">
									<col width="250">
								</colgroup>
								<thead>
								<tr>
									<th>序号</th>
									<th>时间</th>
									<th>操作用户</th>
									<th>调整前</th>
									<th>调整额</th>
									<th>调整后</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${creditDetilBillPageInfo.list}" var="credit" varStatus="vs">
									<tr>
										<td>${vs.index+1}</td>
										<td>
											<fmt:formatDate value="${credit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
												${credit.userAccount}
										</td>
										<td> ${credit.creditBefore}</td>
										<td> ${credit.credit}</td>
										<td> ${credit.creditAfter}</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<tags:page pages="${creditDetilBillPageInfo}"/>
						</c:if>



					</form>
				</div>
				-->
			</div>
			</main>
		</div>
	</section>
    <a id="submitBtn" target="view_window" style="display: none;">结算</a>
    <form id="submitForm" method="post" target="_blank">

    </form>
    <script src="${ctx}/static/js/Md5.js" type="text/javascript"></script>
	<script type="text/javascript">

        var radiovaLue;
        layui.use(['form','element','laydate'], function() {

            var form = layui.form;

            form.on('radio(companyType)', function(data){
                //console.log(data.elem); //得到radio原始DOM对象
                //console.log(data.value); //被点击的radio的value值
                var type = '${TabNum}';
                if(type != data.value){
                    $("[name='pageNum']").val(1);//第一页
                }
                $('#submitBtn').click();

            });
        });

		function wechatPay(prices){
			var width ="400px";
			var height = "300px;";
			var title ="额度结算";
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
				  content: '${ctx}/charter/wechat/newscanPay?prices='+prices+'&actiontype=2'
			   // content: '${ctx}/charter/wechat/creDitPay?amount='+amount
			  })
		}

        function detail(companyCode){
            layer.open({
                type: 2,
                title: '额度信息',
                shadeClose: true,
                shade: 0.5,
                scrollbar:false,
                area: ['90%', '80%'],
                content: "${ctx}/credit/CreditDetail?companyCode=" + companyCode+"&actionTypa=2"
            })
        }

        <%--function unionPay(prices) {--%>
            <%--$.ajax({--%>
                <%--url:'${ctx}/charter/wechat/unionPay',--%>
                <%--type:'post',--%>
                <%--data:{'prices':prices},--%>
                <%--dataType:'json',--%>
                <%--success:function (result) {--%>
                    <%--if(result.flag){--%>
                        <%--make(result.MERCHANTID,result.POSID,result.BRANCHID,result.ORDERID,0.01);--%>
                    <%--}else{--%>
                        <%--layer.msg("操作失败");--%>
                    <%--}--%>
                <%--},--%>
                <%--error:function (errMsg) {--%>
                    <%--layer.msg("操作失败");--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>

        function make(MERCHANTID,POSID,BRANCHID,ORDERID,PAYMENT)
        {
            var tmp;
            var CURCODE="01"; //币种代码
            var TXCODE="690401"; //企业支付交易码
            var REMARK1= "";
            var REMARK2= "";
            var TIMEOUT= "";
            var bankURL= "https://b2bpay.ccb.com/NCCB/NECV5B2BPayMainPlat";

            tmp ='MERCHANTID='+MERCHANTID+'&POSID='+POSID+'&BRANCHID='+BRANCHID+'&ORDERID='+ORDERID+'&PAYMENT='+PAYMENT+'&CURCODE='+CURCODE+'&TXCODE='+TXCODE+'&REMARK1='+REMARK1+'&REMARK2='+REMARK2+ TIMEOUT;    //加密原串
            var strMD5=hex_md5(tmp);
            var url = bankURL+'?'+tmp+'&MAC='+strMD5;
            layer.open({
                type: 2,
                title: '银联付款',
                shadeClose: true,
                shade: 0.5,
                scrollbar:false,
                area: ['90%', '80%'],
                content: url
            })
            //window.open().location.href=url;
            //console.log(url);
            //$("#submitForm").attr("action",url).submit();
            //$("#submitBtn").attr("href",url);
            //console.log($("#submitBtn").attr("href"));
            //document.getElementById("submitBtn").click();
        }

        function unionPay(type,prices){
            var width ="400px";
            var height = "300px;";
            var title ="额度结算";
            var btnName = "确认支付";
            layer.open({
                type: 2,
                title: title,
                shadeClose: true,
                shade: 0.5,
                scrollbar:false,
                btn:[btnName,"取消"],
                yes: function(index, layero){
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                    var formData = iframeWin.submitOrderPay();
                    if(formData != null && formData != undefined){
                        $.ajax({
                            url:"${ctx}/charter/order/submitOrderPay",
                            type:"post",
                            data:{bigOrderCode:formData.bigOrderCode,actionType:formData.actionType,prices:formData.prices},
                            async:false,
                            success:function (result) {
                                if(result.flag){
                                    make(result.MERCHANTID,result.POSID,result.BRANCHID,result.ORDERID,0.01);
                                }else{
                                    layer.open({
                                        icon: 2,
                                        title: '信息',
                                        skin: 'layer-ext-myskin',
                                        shade: 0, //不显示遮罩
                                        scrollbar:false,
                                        content: "提交失败！"
                                    });
                                }
                                layer.close(index);
                            },
                            error:function (errMsg) {
                                layer.open({
                                    icon: 2,
                                    title: '信息',
                                    skin: 'layer-ext-myskin',
                                    shade: 0, //不显示遮罩
                                    scrollbar:false,
                                    content: "提交失败！"
                                });
                            }
                        });
                    }
                },
                area: [width,height],
                content: '${ctx}/charter/order/orderPay?prices='+prices+'&actionType='+type
            })
        }
	</script>
</body>
</html>