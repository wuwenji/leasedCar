<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>证件提醒</title>
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
    </style>
</head>
<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 服务评价 -> 证件提醒</div>
            </div>
            <div>
                <form id="searchForm" class="layui-form" action="${ctx}/transport/certificate/list" method="post">
                    <input type="hidden" name="pageNum" value="${certificate.pageNum}"/>
                    <input type="hidden" name="pageSize" value="${certificate.pageSize}"/>
                    <input type="hidden" id="order" name="order" value="${certificate.order}"/>
                    <input type="hidden" id="sortType" name="sortType" value="${certificate.sortType}"/>
                    <div class="info">
                        <div class="button_right john-edge">
                            <div class="layui-inline">
                                <select name="subjectType" lay-filter="search">
                                    <option value="">主体类型</option>
                                    <option value="1" <c:if test="${certificate.subjectType == 1}">selected="selected"</c:if>>司机
                                    </option>
                                    <option value="2" <c:if test="${certificate.subjectType == 2}">selected="selected"</c:if>>车辆
                                    </option>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <select name="type" id="type" lay-filter="search">
                                    <option value="">证件类型</option>
                                    <option value="1" <c:if test="${certificate.type == 1}">selected="selected"</c:if>>上岗证
                                    </option>
                                    <option value="2" <c:if test="${certificate.type == 2}">selected="selected"</c:if>>驾驶证
                                    </option>
                                    <option value="3" <c:if test="${certificate.type == 3}">selected="selected"</c:if>>行驶证
                                    </option>
                                    <option value="4" <c:if test="${certificate.type == 4}">selected="selected"</c:if>>营运证
                                    </option>
                                    <option value="5" <c:if test="${certificate.type == 5}">selected="selected"</c:if>>保险单
                                    </option>
                                </select>
                            </div><div class="layui-inline">
                            <select name="status" lay-filter="search">
                                <option value="">证件状态</option>
                                <option value="0" <c:if test="${certificate.status == 0}">selected="selected"</c:if>>今天到期
                                </option>
                                <option value="1" <c:if test="${certificate.status == 1}">selected="selected"</c:if>>即将过期
                                </option>
                                <option value="2" <c:if test="${certificate.status == 2}">selected="selected"</c:if>>已经过期
                                </option>
                            </select>
                        </div>

                            <div class="layui-inline">
                                <input type="text" name="name" value="${certificate.name}" class="layui-input" placeholder="请输入名称">
                                <%-- <input type="text" name="orderCodeSe" value="${order.orderCodeSe}" class="layui-input" placeholder="请输订单号"> --%>
                                <a class="layui-btn layui-btn-danger layui-btn-small"
                                   href="javascript:selfSubmit();">搜索</a>
                            </div>
                        </div>
                        <div class="cl"></div>
                    </div>
                    <div class="layui-form">
                        <table class="layui-table">
                            <thead>
                            <tr class="th-center">
                                <th>类型<img id="subjectType" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>名称<img id="name" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>证件名称<img id="type" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>到期时间<img id="invalid" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <th>证件状态<img id="expireDays" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                                <%--<th><a id="subjectType" onclick="sort(this);" style="cursor: pointer;">类型</a></th>
                                <th><a id="name" onclick="sort(this);" style="cursor: pointer;">名称</a></th>
                                <th><a id="type" onclick="sort(this);" style="cursor: pointer;">证件名称</a></th>
                                <th><a id="invalid" onclick="sort(this);" style="cursor: pointer;">到期时间</a></th>
                                <th><a id="expireDays" onclick="sort(this);" style="cursor: pointer;">证件状态</a></th>--%>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${certificates.list}" var="certificate" varStatus="status">
                                <tr>
                                    <td>
                                        <c:if test="${certificate.subjectType == 1}">司机</c:if>
                                        <c:if test="${certificate.subjectType == 2}">车辆</c:if>
                                    </td>
                                    <td>${certificate.name}</td>
                                    <td>
                                        <c:if test="${certificate.type == 1}">上岗证</c:if>
                                        <c:if test="${certificate.type == 2}">驾驶证</c:if>
                                        <c:if test="${certificate.type == 3}">行驶证</c:if>
                                        <c:if test="${certificate.type == 4}">营运证</c:if>
                                        <c:if test="${certificate.type == 5}">保险单</c:if>
                                    </td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${certificate.invalid}"/></td>
                                    <td>
                                        <c:if test="${certificate.expireDays == 0}"><span class="red">今天到期</span></c:if>
                                        <c:if test="${certificate.expireDays < 0}"><span class="red">已经过期</span></c:if>
                                        <c:if test="${certificate.expireDays > 0}"><span
                                                class="orange">快要到期(还有${certificate.expireDays}天)</span></c:if>
                                    </td>
                                    <td>
                                        <c:if test="${certificate.subjectType == 1}">
                                            <a href="javascript:updateDriver('${certificate.id}','${certificate.type}');"
                                               class="layui-btn layui-btn-primary layui-btn-mini"><i
                                                    class="icon-edit"></i> 更新</a>
                                        </c:if>
                                        <c:if test="${certificate.subjectType == 2}">
                                            <a href="javascript:updateCar('${certificate.name}','${certificate.type}');"
                                               class="layui-btn layui-btn-primary layui-btn-mini"><i
                                                    class="icon-edit"></i> 更新</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
            <tags:page pages="${certificates}"/>
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
    function selfSubmit() {
        $("#searchForm").submit();
    }

    //跳到第一页
    function selfSearch() {
        $("[name='pageNum']").val(1);//第一页
        selfSubmit();
    }

    /*****、新增、修改/车辆*****/
    function updateCar(carNum, type) {

        var title = "新增车辆";
        if (carNum == null || carNum == "" || carNum == undefined) {
            title = "新增车辆";
        } else {
            title = "修改车辆";
        }
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar: false,
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
            content: '${ctx}/transport/car/form?carNum=' + carNum + '&updateType=' + type
        })
    }

    /*****、新增、修改/司机*****/
    function updateDriver(id, type) {


        var title = "新增司机";
        if (id == null || id == "" || id == undefined) {
            title = "新增司机";
        } else {
            title = "修改司机";
        }
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar: false,
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
            content: '${ctx}/transport/driver/form?id=' + id + '&updateType=' + type
        })
    }

    layui.use('form', function () {

        var form = layui.form;

        //各种基于事件的操作，下面会有进一步介绍
        form.on('select(search)', function (data) {
            selfSearch();
        });
    });
</script>
</body>
</html>