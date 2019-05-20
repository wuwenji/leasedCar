<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>收藏订单</title>
    <style type="text/css">
        .button_left label {
            float: left;
        }
        .button_left span {
            float: left;
        }
        .th-center th {
            padding-left: 20px;
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

        .td-center td {
            text-align: center;
            padding-left: 20px;
        }
        .info {
            min-height: 0px;
        }
        .search_text{
            width: 110px;
            padding-right: 0;
        }
        .button_right .layui-form-label{ padding: 5px 5px; }
        .search_select.layui-input-inline{ width: 100px; margin-right: 0px;}
        .search_select .layui-input{ width: 100px; }
        .search_input.layui-input-inline{ width: 140px; }
        .search_input .layui-input{ width: 140px; }
    </style>
</head>
<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 订单管理 -> 收藏订单
            </div>
            <form id="searchForm" class="layui-form" action="${ctx}/charter/order/collection" method="post">
                <input type="hidden" name="pageNum" value="${collectionOrder.pageNum}"/>
                <input type="hidden" name="pageSize" value="${collectionOrder.pageSize}"/>
                <input type="hidden" id="order" name="order" value="${collectionOrder.order}"/>
                <input type="hidden" id="sortType" name="sortType" value="${collectionOrder.sortType}"/>
                <div class="info" style="width: 936px;">
                    <div class="button_left">
                    </div>
                    <div class="button_right john-edge" style="margin-right: 30px;">
                        <div class="layui-inline">
                            <label class="layui-form-label">收藏时间:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="beginTime" name="beginTime"
                                       type="text" value="<fmt:formatDate value='${collectionOrder.beginTime}' pattern='yyyy-MM-dd'/>"/>_
                            </div>
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="endTime" name="endTime"
                                       type="text" value='<fmt:formatDate value="${collectionOrder.endTime}" pattern="yyyy-MM-dd"/>'/>
                            </div>
                        </div>
                        <div class="layui-inline"<%-- style="margin-top: 9px;margin-right: 115px;"--%>>
                            <label class="layui-form-label">查询内容选项:</label>
                            <div class="layui-input-inline search_select">
                                <select name="fieldName" id="fieldName" lay-filter="fieldName">
                                    <option value="o.start_point" <c:if test="${collectionOrder.fieldName eq 'o.start_point'}">
                                        selected="selected"</c:if>>上车点</option>
                                    <option value="o.via_point" <c:if test="${collectionOrder.fieldName eq 'o.via_point'}">
                                        selected="selected"</c:if>>途径点</option>
                                    <option value="o.end_point" <c:if test="${collectionOrder.fieldName eq 'o.end_point'}">
                                        selected="selected"</c:if>>下车点</option>
                                </select>
                            </div>
                            <div class="layui-input-inline search_input">
                                <input class="layui-input" id="searchValue" name="searchValue" type="text" placeholder="输入查询内容"
                                       value="${collectionOrder.searchValue}"/>
                            </div>
                            <%--<label class="layui-form-label">地点:</label>
                            <div style="width:80px;" class="layui-inline">
                                <input class="search_text" name="param" type="text" value="${collectionOrder.param}" placeholder="输入关键字"/>
                            </div>--%>
                        </div>
                        <div class="layui-inline">
                            <a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0);"
                               onclick="submitCharterForm();">搜索</a>
                        </div>
                    </div>
                    <div class="cl"></div>
                </div>

                <div class="info info-padding0" style="width: 936px;text-align: center;">
                    <table class="layui-table" lay-even="" lay-skin="nob">
                        <colgroup>
                            <col width="250">
                            <col width="250">
                            <col width="250">
                            <col width="250"/>
                            <col width="250"/>
                        </colgroup>
                        <thead>
                        <tr class="th-center">
                            <th>上车点<img id="o.start_point" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                            <th>途径点<img id="o.via_point" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                            <th>下车点<img id="o.end_point" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                            <th>收藏时间<img id="c.create_date" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt=""></th>
                            <%--<th>上车点</th>
                            <th>途径点</th>
                            <th>下车点</th>
                            <th>收藏时间</th>--%>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </form>
            <div class="layui-form">
                <c:forEach items="${collections.list}" var="item">
                    <table class="layui-table" lay-even="" lay-skin="nob" style="border: 1px solid #CCC;">
                        <colgroup>
                            <col width="250">
                            <col width="250">
                            <col width="250">
                            <col width="250">
                            <col width="250"/>
                        </colgroup>
                        <tbody>
                        <tr class="td-center">
                            <td style="width: 250px;"><a style="text-align: center;">${item.startPoint}</a></td>
                            <td style="width: 250px;"><a style="text-align: center;">${item.viaPoint}</a></td>
                            <td style="width: 250px;"><a style="text-align: center;padding-left: 60px;"> ${item.endPoint}</a></td>

                            <td style="width: 200px;"><a style="text-align: center;"><fmt:formatDate value="${item.cCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
                            <td style="width: 250px;">
                                <a href="javascript:void(0);" class="layui-btn layui-btn-danger layui-btn-mini" onclick="deleteCollection('${item.cId}');">删除</a>
                                <a href="javascript:void(0);" class="layui-btn layui-btn-danger layui-btn-mini" onclick="oneMoreOrder('${item.orderCode}');">再来一单</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </c:forEach>
            </div>
            <tags:page pages="${collections}"/>
        </main>
    </div>
</section>
<script type="text/javascript">

    $(function () {
        layui.use('laydate', function() {
            var laydate = layui.laydate;
            lay('.input_date').each(function(){
                laydate.render({
                    elem: this
                    ,trigger: 'click'
                });
            });
        });
    });

    //查询
    function submitCharterForm() {
        $('[name="pageNum"]').val(1);
        $("#searchForm").submit();
    }

    function deleteCollection(id){
        parent.layer.confirm("是否确认删除", {icon: 3, title:'提示'}, function(index){
            $.ajax({
                type: "POST",
                url: "${ctx}/collectionOrder/delete",
                data: {'id': id},
                dataType: "json",
                success: function (data) {
                    if (data) {
                        layer.msg('删除成功', {icon: 1, timeout: 500});
                        setTimeout(function () {
                            parent.layer.close(index);
                            location.reload();
                        },500);
                    }else {
                        layer.msg('系统错误', {icon: 2, timeout: 1000});
                    }
                }
            });
        });
    }

    function oneMoreOrder(orderCode) {
        location.href = "${ctx}/charter/order/oneMoreOrder?orderCode=" + orderCode;
    }
</script>
</body>
</html>