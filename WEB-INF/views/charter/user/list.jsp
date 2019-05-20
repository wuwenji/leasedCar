<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<style>
		/*排序按钮*/
		.th-center th {
			font-weight: bold;
			text-align: center;
		}
		.th-center th img {
			margin-left: 2px;
			margin-top: -4px;
			cursor: pointer;
			width: 14px;
			height: 14px;
		}
		/*搜索块边距*/
		.info { padding: 10px 0 0 0; }
		.layui-form-item { margin-bottom: 10px; }
		/*内部input浮动消除，位置修正*/
		.button_right input { float: none; }
		.button_right .layui-input-inline{ margin-top:5px; }
		.button_right .layui-form-label{ padding: 9px 5px; }

	    .sex .layui-form-label{ width: 40px; }
	    .sex .layui-input-inline{ width: 70px; }
	    .sex .layui-input{ width: 70px; }

	    .status .layui-form-label{ width: 40px; }
	    .status .layui-input-inline{ width: 80px; }
	    .status .layui-input{ width: 80px; }

		.search_div .layui-form-label{ width: 90px; }
		.search_select.layui-input-inline{ width: 100px; margin-right: 0px;}
		.search_select .layui-input{ width: 100px; }
		.search_input.layui-input-inline{ width: 140px; }
		.search_input .layui-input{ width: 140px; }
		.search_button.layui-input-inline{ width: 30px; }
	</style>
	<title>用户管理</title>
</head>
<body>
<section>
	<div class="container">
	<jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
		<main>
		<div class="position_all">
			<div class="position">您所在的位置：首页 -> 用户管理 -> 用户列表</div>
		</div>
		<div class="layui-form">
			<form id="searchForm" action="${ctx}/charter/user/list" method="post">
                <input type="hidden" name="pageNum" value="${user.pageNum}"/>
                <input type="hidden" name="pageSize" value="${user.pageSize}"/>
                <input type="hidden" id="order" name="order" value="${user.order}"/>
				<input type="hidden" id="sortType" name="sortType" value="${user.sortType}"/>
				<div class="info">
				<div class="button_left">
					<a href="javascript:update('');" class="layui-btn layui-btn-primary layui-btn-small car_a"><i class="icon-plus-sign"></i> 新增</a>
				</div>
				<div class="button_right">
					<div class="layui-form-item">
						<div class="layui-inline sex">
							<label class="layui-form-label">性别：</label>
							<div class="layui-input-inline">
								<select name="sex" lay-filter="sex">
									<option value="">全部</option>
									<option value="0" <c:if test="${user.sex eq 0}">
										selected="selected"</c:if>>女</option>
									<option value="1" <c:if test="${user.sex eq 1}">
										selected="selected"</c:if>>男</option>
								</select>
							</div>
						</div>
						<div class="layui-inline status">
							<label class="layui-form-label">状态：</label>
							<div class="layui-input-inline">
								<select name="status" lay-filter="sex">
									<option value="">全部</option>
									<option value="0" <c:if test="${user.status eq 0}">
										selected="selected"</c:if>>启用</option>
									<option value="1" <c:if test="${user.status eq 1}">
										selected="selected"</c:if>>禁用</option>
									<option value="2" <c:if test="${user.status eq 2}">
										selected="selected"</c:if>>不通过</option>
								</select>
							</div>
						</div>
						<div class="layui-inline search_div">
							<label class="layui-form-label">查询内容选项：</label>
							<div class="layui-input-inline search_select">
								<select name="fieldName" id="fieldName" lay-filter="fieldName">
									<option value="user_name" <c:if test="${user.fieldName eq 'user_name'}">
										selected="selected"</c:if>>姓名</option>
									<option value="user_account" <c:if test="${user.fieldName eq 'user_account'}">
										selected="selected"</c:if>>账号</option>
									<option value="phone" <c:if test="${user.fieldName eq 'phone'}">
										selected="selected"</c:if>>手机号码</option>
									<option value="id_card" <c:if test="${user.fieldName eq 'id_card'}">
										selected="selected"</c:if>>身份证</option>
								</select>
							</div>
							<div class="layui-input-inline search_input">
								<input class="layui-input" id="searchValue" name="searchValue" type="text" placeholder="输入查询内容"
									   value="${user.searchValue}"/>
							</div>
							<div class="layui-input-inline search_button">
								<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSearch();">搜索</a>
							</div>
						</div>
					</div>
				</div>
				<%--<input type="text" name="userName" value="${}" class="layui-input" placeholder="请输入用户名">--%>
				<%--<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSubmit();">搜索</a>--%>
				<div class="cl"></div>
				</div>
				<div class="layui-form">
					<table class="layui-table">
						<colgroup>
							<%--<col width="50">--%>
							<col width="150">
							<col width="150">
							<col width="100">
							<col width="100">
							<col width="200">
							<col width="100">
							<col width="300">
							<col>
						</colgroup>
						<thead>
							<tr class="th-center">
								<%--<th><input name="" lay-skin="primary" lay-filter="allChoose" type="checkbox"></th>--%>
								<th>姓名<img id="user_name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>账号<img id="user_account" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>性别<img id="sex" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>手机号码<img id="phone" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>身份证<img id="id_card" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						       	<th>状态<img id="u.status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>操作</th>
							</tr>
						</thead>
						<tbody>
                           <c:forEach items="${users.list}" var="user" varStatus="status">
                               <tr>
                                   <%--<td><input name="" lay-skin="primary" type="checkbox"></td>--%>
                                   <td>${user.userName}</td>
                                   <td>${user.userAccount}</td>
                                   <td>
	                                   <c:if test="${user.sex == 0}">女</c:if>
		                               <c:if test="${user.sex == 1}">男</c:if>
                                   </td>
                                   <td>${user.phone}</td>
								   <td>${user.idCard}</td>
                                   <td>
	                                   	<c:if test="${user.status == 0}">启用</c:if>
	                                   	<c:if test="${user.status == 1}">禁用</c:if>
	                                   	<c:if test="${user.status == 2}">不通过</c:if>
                                   </td>
                                   <td>
	                                   	<a href="javascript:update('${user.id}');" class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i class="icon-edit"></i> 修改</a>
	                                   	<c:if test="${user.status == 0}"><a href="javascript:updateById('${user.id}',1);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 禁用</a></c:if>
                                   		<c:if test="${user.status == 1}"><a href="javascript:updateById('${user.id}',0);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 启用</a></c:if>
                                   </td>
                               </tr>
                           </c:forEach>
						</tbody>
					</table>
				</div>
			</form>
		</div>
        <tags:page pages="${users}"/>
		</main>
	</div>
</section>
<script type="text/javascript">
//文档加载完毕执行
$(function() {
	var message = '${message}';
	if(message != null && "" != message){
		var msg = message.split("@");
		setTimeout(function(){
			layer.alert(msg[0], {icon: msg[1]});
		}, 500);
	}
});
//提交搜索表单
function selfSubmit() {
	$("#searchForm").submit();
}

//跳到第一页
function selfSearch() {
	$("[name='pageNum']").val(1);//第一页
	selfSubmit();
}

/*****、新增、修改*****/
function update(id){
    var title = "新增用户";
    if(id == null || id == "" || id == undefined){
        title = "新增用户";
	}else{
        title = "修改用户";
	}
  layer.open({
    type: 2,
    title: title,
    shadeClose: true,
    shade: 0.5,
    scrollbar:false,
    btn: ['提交', '取消'],
    yes: function(index, layero){
    	 var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
    	 iframeWin.laySubmit();//执行iframe页的方法：
    },
    btn2: function(index, layero){
    	selfSearch();
    },
    cancel: function(index, layero){ 
    	selfSearch();
    },
    area: ['650px','450px'],
    content: '${ctx}/charter/user/form?id='+id
  })
}

/*
* status:
* 0:启用 1:禁用 2:不通过
*/
function updateById(id, status){
	var typeStr = '禁用';
	if(status == 0){
		typeStr = '启用';
	}
	if(status == 1){
		typeStr = '禁用';
	}
    layer.confirm('真的'+typeStr+'这个用户么?', {icon: 3, title:'提示',scrollbar:false}, function(index){
        $.ajax({
            type: "POST",
            url: "${ctx}/charter/user/updateById",
            data: {'id': id, 'status': status},
            dataType: "json",
            success: function(data){
            	var msg = '';
            	var icon = 1;
            	if(data < 0){
            		msg = '失败，系统错误！';
            		icon = 2;//失败
            	}else{
            		if(data == 0){
            			msg = '失败';
            		}else{
            			msg = '成功';
            		}
            	}
                layer.msg(typeStr+msg,{
                    time: 1000,
                    skin: 'layui-layer-molv',
                    area: '20px',
                    scrollbar:false,
                    icon: icon
                }, function(){
                	selfSubmit();
                });
            }
        });
        layer.close(index);
        //向服务端发送操作指令
    });

}

//搜索框的状态记忆
var selectValue = $("#dim").val();
if (selectValue == null && selectValue == '') {
    selectValue = '0';
}

layui.use('form', function () {

    var form = layui.form;

    //各种基于事件的操作，下面会有进一步介绍
    form.on('select(sex)', function (data) {
        selfSearch();
    });
    form.on('select(status)', function (data) {
        selfSearch();
    });
    form.on('select(fieldName)', function (data) {
        $("#searchValue").val("");
    });
})
</script>
</body>
</html>