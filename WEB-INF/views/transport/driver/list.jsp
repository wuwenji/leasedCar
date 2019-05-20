<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>司机管理</title>
    <style>
        .button_right .layui-form-select .layui-edge {
            margin-top: 12px;
        }
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
    </style>
</head>
<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 资源管理 -> 司机管理${driver.status}</div>
            </div>
            <div>
                <form id="searchForm" action="${ctx}/transport/driver/list" method="post" class="layui-form">
                    <input type="hidden" name="pageNum" value="${driver.pageNum}"/>
                    <input type="hidden" name="pageSize" value="${driver.pageSize}"/>
                    <input type="hidden" id="order" name="order" value="${driver.order}"/>
                    <input type="hidden" id="sortType" name="sortType" value="${driver.sortType}"/>
                    <!-- 模糊查询字段-->
                    <input type="hidden" id="searchType" name="searchType" value="${driver.searchType}">
                    <input type="hidden" id="jobNum" name="jobNum" value="${driver.jobNum}">
                    <input type="hidden" name="phone" value="${driver.phone}">
                    <input type="hidden" name="name" value="${driver.name}">
                    <input type="hidden" id="companyName" name="companyName" value="${driver.companyName}">
                    <input type="hidden" name="status" value="${driver.status}">
                    <input type="hidden" name="idCard" value="${driver.idCard}">
                    <div class="info">
                        <div class="button_left">
                            <a href="javascript:update('');" class="layui-btn layui-btn-primary layui-btn-small car_a"><i
                                    class="icon-plus-sign"></i> 新增</a>
                        </div>

                        <div class="button_right">
                            <div class="layui-inline">
                                <label class="layui-form-label">查询内容选项:</label>
                                <div class="layui-input-inline" style="margin-top:5px">
                                    <select name="dim" id="dim" lay-filter="dim1">
                                        <option value="0" <c:if test="${driver.jobNum != null and driver.jobNum !=''}">
                                            selected="selected"</c:if>>工号</option>
                                        <option value="1" <c:if test="${driver.phone != null and driver.phone !=''}">
                                            selected="selected"</c:if>>手机号码</option>
                                        <option value="2" <c:if test="${driver.name != null and driver.name !=''}">
                                            selected="selected"</c:if>>姓名</option>
                                        <option value="3" <c:if test="${driver.idCard != null and driver.idCard !=''}">
                                            selected="selected"</c:if>>身份证</option>
                                        <option value="4" <c:if test="${driver.status != null and driver.status !=''}">
                                            selected="selected"</c:if>>状态</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <input class="layui-input search_text" id="dimValue" name="dimValue" type="text"
                                       style="cursor: pointer;" placeholder="输入查询内容"
                                       value="${driver.jobNum}${driver.phone}${driver.name}${driver.idCard}<c:if test="${not empty driver.status}"><c:if
                                       test="${driver.status eq 0}">在职</c:if><c:if
                                       test="${driver.status eq 1}">休假</c:if><c:if
                                       test="${driver.status eq 2}">离职</c:if></c:if>"/>
                            </div>
                            <div class="layui-inline">
                                <a class="layui-btn layui-btn-danger layui-btn-small"
                                   href="javascript:selfSubmit();">搜索</a>
                            </div>
                        </div>
                        <div class="cl"></div>
                    </div>
                    <div class="layui-form">
                        <table class="layui-table">
                            <colgroup>

                                <col width="150">
                                <col width="150">
                                <col width="100">
                                <col width="200">
                                <col width="200">
                                <col width="150">
                                <col width="120">
                                <col>
                            </colgroup>
                            <thead>
                            <tr class="th-center">
                                <th>姓名<img id="name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>性别<img id="sex" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>工号<img id="job_num" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>手机号码<img id="phone" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>身份证<img id="id_card" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>状态<img id="status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>

                                <%--<th style="text-align: center;"><a id="name" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">姓名</a>
                                </th>
                                <th style="text-align: center;"><a id="sex" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">性别</a>
                                </th>
                                <th style="text-align: center;"><a id="job_num" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">工号</a>
                                </th>
                                                                   style="cursor: pointer;font-weight: bold;">手机号码</a>
                                </th>
                                <th style="text-align: center;"><a id="id_card" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">身份证</a>
                                </th>
                                <th style="text-align: center;"><a id="status" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">状态</a>
                                </th>--%>
                                <th style="text-align: center;"><a style="font-weight: bold;">操作</a></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${drivers.list}" var="driver" varStatus="status">
                                <tr>

                                    <td style="text-align: center;">${driver.name}</td>
                                    <td style="text-align: center;">${driver.sex}</td>
                                    <td style="text-align: right;">${driver.jobNum}</td>
                                    <td style="text-align: right;">${driver.phone}</td>
                                    <td style="text-align: right;">${driver.idCard}</td>
                                    <td style="text-align: center;">
                                        <c:if test="${driver.status == 0}">在职</c:if>
                                        <c:if test="${driver.status == 1}">休假</c:if>
                                        <c:if test="${driver.status == 2}">离职</c:if>
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="javascript:update('${driver.id}');"
                                           class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i
                                                class="icon-edit"></i> 修改</a>
                                        <a href="javascript:updateById('${driver.id}',1);"
                                           class="layui-btn layui-btn-primary layui-btn-mini"><i
                                                class="icon-remove"></i> 删除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
            <tags:page pages="${drivers}"/>
        </main>
    </div>
</section>
<script type="text/javascript">
    //文档加载完毕执行
    $(function () {
        var message = '${message}';
        if (message != null && "" != message) {
            var msg = message.split("@");
            setTimeout(function () {
                layer.alert(msg[0], {icon: msg[1]});
            }, 500);
        }
    });
    //提交搜索表单

    //搜索框的状态记忆
    var selectValue = $("#dim").val();
    if (selectValue == null && selectValue == '') {
        selectValue = '0';
    }

    layui.use('form', function () {

        var form = layui.form;

        //各种基于事件的操作，下面会有进一步介绍
        form.on('select(dim1)', function (data) {
            selectValue = data.value; //得到被选中的值
        });
    })


    function selfSubmit() {
        if ($("#dimValue").val() == null || $("#dimValue").val() == '') {

            $("#searchType").val('0');

            $("#jobNum").val('');
            $("#companyName").val('');
            $("input[name='phone']").val('');
            $("input[name='name']").val('');
            $("input[name='status']").val('');
            $("input[name='idCard']").val('');
        } else {
            $("#searchType").val("1");
            var setValue = $("#dimValue").val();

            if (selectValue == '0') {
                set('jobNum', setValue);
            } else if (selectValue == '1') {

                set('phone', setValue);
            } else if (selectValue == '2') {
                set('name', setValue);
            } else if (selectValue == '3') {
                set('idCard', setValue);
            } else if (selectValue == '4') {
//                var num = 0;
                var num = null;
                if (setValue.indexOf("在职") != -1) {
                    num = 0;
                } else if (setValue.indexOf("休假") != -1) {
                    num = 1;
                } else if (setValue.indexOf("离职") != -1) {
                    num = 2;
                }
                set('status', num);
            }
        }

        $("#pageNum").val("1");
        $("#pageSize").val("10");

        $("#searchForm").submit();
    }


    function set(id, value) {
        $("#jobNum").val('');
        $("#companyName").val('');
        $("input[name='phone']").val('');
        $("input[name='name']").val('');
        $("input[name='status']").val('');
        if (id == 'phone' || id == 'name' || id == 'status' || id == 'idCard') {
            $("input[name=" + id + "]").val(value);
        } else {
            $("#" + id).val(value);
        }
    }

    //跳到第一页
    function selfSearch() {
        $("[name='pageNum']").val(1);//第一页
        selfSubmit();
    }

    /*****、新增、修改/司机*****/
    function update(id) {

        var msg = '司机修改';
        if(id==null || id ==''){
            msg ='新增司机'
        }
        layer.open({
            type: 2,
            title: msg,
            shadeClose: true,
            shade: 0.5,
            btn: ['提交', '取消'],
            yes: function (index, layero) {
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                iframeWin.laySubmit();//执行iframe页的方法：
            },
            btn2: function (index, layero) {
                selfSearch();
            },
            cancel: function (index, layero) {
                selfSearch();
            },
            area: ['650px', '600px'],
            content: '${ctx}/transport/driver/form?id=' + id
        })
    }

    /*
    * status:
    * 0在职，1休假，2离职
    * recordStatus:
    * 0正常，1删除，
    */
    function updateById(id, recordStatus) {
        var typeStr = '删除';
        layer.confirm('真的' + typeStr + '这个司机么?', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                type: "POST",
                url: "${ctx}/transport/driver/updateById",
                data: {'id': id, 'recordStatus': recordStatus},
                dataType: "json",
                success: function (data) {
                    var msg = '';
                    var icon = 1;
                    if (data < 0) {
                        msg = '失败，系统错误！';
                        icon = 2;//失败
                    } else {
                        if (data == 0) {
                            msg = '失败';
                        } else {
                            msg = '成功';
                        }
                    }
                    layer.msg(typeStr + msg, {
                        time: 1000,
                        skin: 'layui-layer-molv',
                        area: '20px',
                        icon: icon
                    }, function () {
                        selfSubmit();
                    });
                }
            });
            layer.close(index);
            //向服务端发送操作指令
        });

    }
</script>
</body>
</html>