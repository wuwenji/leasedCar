<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>角色管理</title>
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
</head>
<body>
<section>
	<div class="container">
	<jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
		<main>
		<div class="position_all">
			<div class="position">您所在的位置：首页 -> 用户管理 -> 角色管理</div>
		</div>
		<div class="">
			<form id="searchForm" class="layui-form" action="${ctx}/charter/role/list" method="post">
                <input type="hidden" name="pageNum" value="${role.pageNum}"/>
                <input type="hidden" name="pageSize" value="${role.pageSize}"/>
                <input type="hidden" id="order" name="order" value="${role.order}"/>
				<input type="hidden" id="sortType" name="sortType" value="${role.sortType}"/>
				<div class="info">
				<div class="button_left">
					<a href="javascript:update('');" class="layui-btn layui-btn-primary layui-btn-mini car_a"><i class="icon-plus-sign"></i> 新增</a>
				</div>
				<div class="button_right">
					<div class="layui-form-item">
						<div class="layui-inline status">
							<label class="layui-form-label">状态：</label>
							<div class="layui-input-inline">
								<select name="status" lay-filter="status">
									<option value="">全部</option>
									<option value="0" <c:if test="${role.status eq 0}">
										selected="selected"</c:if>>启用</option>
									<option value="1" <c:if test="${role.status eq 1}">
										selected="selected"</c:if>>禁用</option>
								</select>
							</div>
						</div>
						<div class="layui-inline search_div">
							<label class="layui-form-label">查询内容选项：</label>
							<div class="layui-input-inline search_select">
								<select name="fieldName" id="fieldName" lay-filter="fieldName">
									<option value="role_name" <c:if test="${role.fieldName eq 'role_name'}">
										selected="selected"</c:if>>角色名称</option>
									<option value="role_describe" <c:if test="${role.fieldName eq 'role_describe'}">
										selected="selected"</c:if>>角色描述</option>
									<option value="remark" <c:if test="${role.fieldName eq 'remark'}">
										selected="selected"</c:if>>备注</option>
								</select>
							</div>
							<div class="layui-input-inline search_input">
								<input class="layui-input" id="searchValue" name="searchValue" type="text" placeholder="输入查询内容"
									   value="${role.searchValue}"/>
							</div>
							<div class="layui-input-inline search_button">
								<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSearch();">搜索</a>
							</div>
						</div>
					</div>
					<%--<input type="text" name=roleName value="${role.roleName}" class="layui-input" placeholder="请输入角色名">
					<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSubmit();">搜索</a>--%>
				</div>
				<div class="cl"></div>
				</div>
				<div class="layui-form">
					<table class="layui-table">
						<colgroup>
							<%--<col width="50">--%>
							<col width="150">
							<col width="150">
							<col width="300">
							<col width="100">
							<col width="300">
							<col>
						</colgroup>
						<thead>
							<tr class="th-center">
								<%--<th><input name="" lay-skin="primary" lay-filter="allChoose" type="checkbox"></th>--%>
							    <th>角色名称<img id="role_name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
							    <th>角色描述<img id="role_describe" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
							    <th>备注<img id="remark" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
							    <th>状态<img id="status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
						        <th>操作</th>
							</tr>
						</thead>
						<tbody>
                           <c:forEach items="${roles.list}" var="role" varStatus="status">
                               <tr>
                                   <%--<td><input name="" lay-skin="primary" type="checkbox"></td>--%>
                                   <td>${role.roleName}</td>
                                   <td>${role.roleDescribe}</td>
                                   <td>${role.remark}</td>
                                   <td>
	                                   	<c:if test="${role.status == 0}">启用</c:if>
	                                   	<c:if test="${role.status == 1}">禁用</c:if>
                                   </td>
                                   <td>
	                                   	<a href="javascript:update('${role.id}');" class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i class="icon-edit"></i> 修改</a>
	                                   	<a href="javascript:authorize('${role.id}','${role.roleDescribe}');" class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i class="icon-edit"></i> 授权</a>
	                                   	<c:if test="${role.status == 0}"><a href="javascript:updateById('${role.id}',1);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 禁用</a></c:if>
                                   		<c:if test="${role.status == 1}"><a href="javascript:updateById('${role.id}',0);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 启用</a></c:if>
                                   </td>
                               </tr>
                           </c:forEach>
						</tbody>
					</table>
				</div>
			</form>
		</div>
        <tags:page pages="${roles}"/>
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
    var title = "新增角色";
    if(id == null || id == "" || id == undefined){
        title = "新增角色";
    }else{
        title = "修改角色";
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
    area: ['550px','400px'],
    content: '${ctx}/charter/role/form?id='+id
  })
}

/****给角色授权页面*****/
function authorize(id, roleName){
  parent.layer.open({
    type: 2,
    title: '给角色['+roleName+']分配菜单',
    shadeClose: true,
    shade: 0.1,
    scrollbar:false,
    btn: ['确定', '取消'],
    yes: function(index, layero){
        var iframe = window.top[layero.find('iframe')[0]['name']];//获取iframeWin对象
        iframe.setPer();
    },
    area: ["750px", "500px"],
    content: '${ctx}/charter/role/authorize?id='+id
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
    layer.confirm('真的'+typeStr+'这个角色么?', {icon: 3, title:'提示',scrollbar:false}, function(index){
        $.ajax({
            type: "POST",
            url: "${ctx}/charter/role/updateById",
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

layui.use('form', function () {
    var form = layui.form;
    //各种基于事件的操作，下面会有进一步介绍
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