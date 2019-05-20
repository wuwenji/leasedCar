<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>车辆管理</title>
    <style>
        .button_right .layui-form-select .layui-edge {
            margin-top: 12px;
        }

        .button_right input {
            width: 136px;
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
                <div class="position">您所在的位置：首页 -> 资源管理 -> 车辆管理</div>
            </div>
            <div>
                <form id="searchForm" action="${ctx}/transport/car/list" method="post" class="layui-form">
                    <input type="hidden" name="pageNum" value="${car.pageNum}"/>
                    <input type="hidden" name="pageSize" value="${car.pageSize}"/>
                    <input type="hidden" id="order" name="order" value="${car.order}"/>
                    <input type="hidden" id="sortType" name="sortType" value="${car.sortType}"/>


                    <input type="hidden" id="carNum" name="carNum" value="${car.carNum}"/>
                    <input type="hidden" id="carType" name="carType" value="${car.carType}"/>
                    <input type="hidden" id="seatNumber" name="seatNumber" value="${car.seatNumber}"/>
                    <input type="hidden" id="driverName" name="driverName" value="${car.driverName}"/>
                    <input type="hidden" name="site" value="${car.site}"/>

                    <input type="hidden" id="searchType" name="searchType" value="0">
                    <div class="info">
                        <div class="button_left">
                            <a href="javascript:update('');" class="layui-btn layui-btn-primary layui-btn-small car_a"><i
                                    class="icon-plus-sign"></i> 新增</a>
                        </div>
                        <div class="button_right">
                            <div class="layui-inline">
                                <label class="layui-form-label">出厂日期:</label>
                                <div class="layui-input-inline" style="top: 5px;">

                                    <input class="layui-input search_text input_date" id="beginTime" name="beginTime"
                                           type="text"
                                           <%--value='<fmt:formatDate value="${car.beginTime}" pattern="yyyy-MM-dd"/>'>_--%>
                                           value="${car.beginTime}"/>_
                                </div>
                                <div class="layui-input-inline" style="top: 5px;">
                                    <input class="layui-input search_text input_date" id="endTime" name="endTime"
                                           type="text"
                                           <%--value='<fmt:formatDate value="${car.endTime}" pattern="yyyy-MM-dd"/>'/>--%>
                                           value="${car.endTime}"/>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">查询内容选项:</label>
                                <div class="layui-input-inline" style="top: 5px;">
                                    <select name="dim" id="dim" lay-filter="dim">
                                        <option value="0" <c:if test="${car.carNum != null and car.carNum !=''}">
                                            selected="selected"</c:if>>车牌号
                                        </option>
                                        <option value="1" <c:if test="${car.carType != null and car.carType !=''}">
                                            selected="selected"</c:if>>车型
                                        </option>
                                        <option value="2" <c:if test="${car.seatNumber != null and car.seatNumber !=''}">
                                            selected="selected"</c:if>>车座数
                                        </option>
                                        <option value="3" <c:if test="${car.driverName != null and car.driverName !=''}">
                                            selected="selected"</c:if>>司机
                                        </option>
                                        <option value="4" <c:if test="${car.site != null and car.site !=''}">
                                            selected="selected"</c:if>>驻场地点
                                        </option>
                                    </select>
                                </div>

                            </div>
                            <div class="layui-inline">
                                <input class="layui-input search_text" id="dimValue" name="dimValue" type="text"
                                       style="cursor: pointer;" placeholder="输入查询内容"
                                       value="${car.carNum}${car.carType}${car.seatNumber}${car.driverName}${car.site}"/>
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
                                <col width="200">
                                <col width="100">
                                <col width="200">
                                <col width="200">
                                <col width="150">
                                <col width="200">
                                <col>
                            </colgroup>
                            <thead>
                            <tr class="th-center">
                                <th>车牌号<img id="car_num" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>车型<img id="car_type" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>司机<img id="d.name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>客座数<img id="seat_number" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>驻场地点<img id="site" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>状态<img id="c.status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>

                                <%--<th style="text-align: center;"><a id="car_num" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">车牌号</a>
                                </th>
                                <th style="text-align: center;"><a id="car_type" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">车型</a>
                                </th>
                                <th style="text-align: center;"><a id="d.name" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">司机</a>
                                </th>
                                <th style="text-align: center;"><a id="seat_number" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">客座数</a>
                                </th>
                                <th style="text-align: center;"><a id="made_date" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">驻场地点</a>
                                </th>
                                <th style="text-align: center;"><a id="c.status" onclick="sort(this);"
                                                                   style="cursor: pointer;font-weight: bold;">状态</a>
                                </th>--%>
                                <th style="text-align: center;"><a style="font-weight: bold;">操作</a></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${cars.list}" var="car" varStatus="status">
                                <tr>
                                    <td style="text-align: center;">${car.carNum}</td>
                                    <td style="text-align: center;">${car.carType}</td>
                                    <td style="text-align: center;">${car.driverName}</td>
                                    <td style="text-align: right;">${car.seatNumber}</td>
                                    <td style="text-align: center;">${car.site}</td>
                                    <td style="text-align: center;">
                                        <c:if test="${car.status == 0}">正常</c:if>
                                        <c:if test="${car.status == 1}">停用</c:if>
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="javascript:update('${car.id}');"
                                           class="layui-btn layui-btn-primary layui-btn-mini caradmin_a"><i
                                                class="icon-edit"></i> 修改</a>
                                        <c:if test="${car.status == 0}"><a href="javascript:updateById('${car.id}',1);"
                                                                           class="layui-btn layui-btn-primary layui-btn-mini"><i
                                                class="icon-remove"></i> 冻结</a></c:if>
                                        <c:if test="${car.status == 1}"><a href="javascript:updateById('${car.id}',0);"
                                                                           class="layui-btn layui-btn-primary layui-btn-mini"><i
                                                class="icon-remove"></i> 启用</a></c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
            <tags:page pages="${cars}"/>
        </main>
    </div>
</section>
<script type="text/javascript">
    //文档加载完毕执行
    $(function () {
        //input_date
        layui.use('laydate', function() {
            var laydate = layui.laydate;
            lay('.input_date').each(function(){
                laydate.render({
                    elem: this
                    ,trigger: 'click'
                });
            });
        })
        var message = '${message}';
        if (message != null && "" != message) {
            var msg = message.split("@");
            setTimeout(function () {
                layer.alert(msg[0], {icon: msg[1]});
            }, 500);
        }
    });

    //搜索框的状态记忆
    var selectValue = $("#dim").val();
    if (selectValue == null && selectValue == '') {
        selectValue = '0';
    }
    layui.use('form', function () {

        var form = layui.form;


        //各种基于事件的操作，下面会有进一步介绍
        form.on('select(dim)', function (data) {
            selectValue = data.value; //得到被选中的值
        });
    })

    //提交表单
    function selfSubmit() {

        if ($("#dimValue").val() == null || $("#dimValue").val() == '') {

            $("#searchType").val('0');

            $("#carNum").val('');
            $("#carType").val('');
            $("#driverName").val('');
            $("#seatNumber").val('');
            $("[name='site']").val('');
        } else {
            $("#searchType").val("1");
            var setValue = $("#dimValue").val();
            if (selectValue == '0') {
                set('carNum', setValue);
            } else if (selectValue == '1') {

                set('carType', setValue);
            } else if (selectValue == '2') {
                set('seatNumber', setValue);
            } else if (selectValue == '3') {
                set('driverName', setValue);
            } else if (selectValue == '4') {
                $("[name='site']").val(setValue);
            }
        }

        $("#pageNum").val("1");
        $("#pageSize").val("10");


        $("#searchForm").submit();
    }


    function set(id, value) {
        $("#carNum").val('');
        $("#carType").val('');
        $("#driverName").val('');
        $("#seatNumber").val('');
        $("[name='site']").val('');
        $("#" + id).val(value);
    }


    //搜索
    function selfSearch() {
        $("[name='pageNum']").val(1);//第一页
        selfSubmit();
    }

    /*****、新增、修改/车辆*****/
    function update(id) {


        var msg = '车辆修改';
        if(id==null || id ==''){
            msg ='新增车辆'
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
            area: ['650px', '640px'],
            content: '${ctx}/transport/car/form?id=' + id
        })
    }

    /*
    * status:
    * 0:启用，1:冻结
    */
    function updateById(id, status) {
        var typeStr = status == 0 ? '启用' : '冻结';
        layer.confirm('真的' + typeStr + '这辆车辆么?', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                type: "POST",
                url: "${ctx}/transport/car/updateById",
                data: {'id': id, 'status': status},
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