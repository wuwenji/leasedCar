<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
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
        .button_left { margin-top: 0px; }
        .layui-form-item { margin-bottom: 0px; }
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
        .search_select.layui-input-inline{ width: 80px; margin-right: 0px;}
        .search_select .layui-input{ width: 80px; }
        .search_input.layui-input-inline{ width: 140px; }
        .search_input .layui-input{ width: 140px; }
        .search_button.layui-input-inline{ width: 30px; }
    </style>
</head>
<body>
<form id="searchForm" action="${ctx}/sys/user/list" method="post" class="layui-form">
    <input type="hidden" name="pageNum" value="${user.pageNum}"/>
    <input type="hidden" name="pageSize" value="${user.pageSize}"/>
    <input type="hidden" id="order" name="order" value="${user.order}"/>
    <input type="hidden" id="sortType" name="sortType" value="${user.sortType}"/>
    <div class="button_left">
        <a href="javascript:;" class="layui-btn layui-btn-primary layui-btn-small car_a" onclick="update('', '','insert')"><i class="icon-plus-sign"></i> 新增</a>
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
        <%--<input type="text" name="userName" class="layui-input" placeholder="请输入关键字" value="${user.userName}">
        <button class="layui-btn layui-btn-small">搜索</button>--%>
    </div>
    <div class="cl"></div>
    <table class="layui-table">
        <colgroup>
            <col width="60">
            <col width="160">
            <col width="160">
            <col width="110">
            <col width="210">
            <col width="300">
            <col width="110">
            <col>
        </colgroup>
        <thead>
        <tr class="th-center">
            <th>序号</th>
            <th>姓名<img id="user_name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <th>账号<img id="user_account" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <th>性别<img id="sex" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <th>手机号码<img id="phone" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <th>身份证<img id="id_card" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <th>状态<img id="u.status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
            <%--<th>姓名</th>
            <th>账号</th>
            <th>性别</th>
            <th>手机号</th>
            <th>身份证</th>
            <th>状态</th>--%>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users.list}" var="user" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
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
                <td style="white-space: nowrap;">
                    <a href="javascript:update('${user.id}','${user.userName}','update');" class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i class="icon-edit"></i> 修改</a>
                    <c:if test="${user.status == 0}"><a href="javascript:updateById('${user.id}',1);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 禁用</a></c:if>
                    <c:if test="${user.status == 1}"><a href="javascript:updateById('${user.id}',0);" class="layui-btn layui-btn-primary layui-btn-mini"><i class="icon-remove"></i> 启用</a></c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <tags:page pages="${users}"/>
</form>
<script>
    /*****、新增、修改*****/
    function update(id, name,type){

        var title = (id==''?'新增用户':'修改【'+name+'】用户');
        parent.layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.1,
            scrollbar:false,
            btn: ['提交', '取消'],
            yes: function(index, layero){
                var iframe = window.top[layero.find('iframe')[0]['name']];//获取iframeWin对象
                iframe.$('#submit_btn').submit();//执行iframe页的方法：
            },
            skin: "layui-layer-molv",
            area: ['650px','450px'],
            content: '${ctx}/sys/user/form?id='+id
        })
    }

    /*
     * status:
     * 0:启用 1:禁用 2:不通过
     */
    function updateById(id, status){
        var title = (status == 0?'启用':'禁用');
        parent.layer.confirm('确定'+title+'这个用户么?', {icon: 3, title:'提示'}, function(index){
            $.ajax({
                type: "POST",
                url: "${ctx}/sys/user/updateById",
                data: {'id': id, 'status': status},
                dataType: "json",
                success: function(data){
                    if(data > 0){
                        parent.layer.open({
                            icon: 1,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作成功！",
                            yes: function(){
                                parent.layer.closeAll();
                                parent.refresh();
                            },
                        });
                    }else{
                        parent.layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作失败！"
                        });
                    }
                }
            });
        });
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