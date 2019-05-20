<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<aside>
    <div class="aside_title" style="font-size: 14px;"></div>
    <div class="aside_menu"></div>
</aside>

<script>
    init_menu();

    //初始化菜单
    function init_menu() {
        $.ajax({
            type: "POST",
            url: "${ctx}/menu/left",
            data: {},
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.state) {
                    var content = "<ul>";
                    //var asideTitle = data.asideTitle;
                    //$(".aside_title").text(asideTitle);
                    var menus = eval(data.menus);
                    for (var i = 0; i < menus.length; i++) {
                        var menuPath = menus[i].menuPath;
                        if (menuPath != null && '' != menuPath) {
                            content += "<li><a href='javascript:;'  style=\"font-weight: bold;font-size: 15px;\">" + menus[i].menuItem + "</a></li>";
                        } else {
                            content += "<li><a href='javascript:;'  style=\"font-weight: bold;font-size: 15px;\">" + menus[i].menuItem + "<i class='icon-sort-down'></i></a></li>";
                        }
                        var childMenus = menus[i].childMenus;
                        if (childMenus != null && childMenus.length > 0) {
                            content += "<dl style='display:none'>";
                            for (var j = 0; j < childMenus.length; j++) {
                                var childMenuItem = childMenus[j].menuItem;
                                var childMenuPath = childMenus[j].menuPath;
                                content += "<dd id='" + childMenuItem + "' style='cursor: pointer;' onclick='left_forward(\"" + childMenuPath + "\");'>";
                                content += "<a href='javascript:;'>" + childMenuItem + "</a>";
                                content += "</dd>";
                            }
                            content += "</dl>";
                        }
                    }
                    content += "</ul>";
                    $(".aside_menu").html(content);
                    init_css();
                    init_click();
                } else {
                    top.location.href = "${ctx}/index";
                }
            }
        });
    }

    //初始化样式
    function init_css() {
        var position = $(".position").text();
        if (position != null && '' != position) {
            position = position.substring((position.lastIndexOf('->') + 2), position.length);
            position = position.replace(" ", "");
            $("#" + position).css("background", "url(${ctx}/static/images/bg_left_nav_cur.gif) no-repeat left top");
            $("#" + position + " a").css("color", "#fff");
            $("#" + position + " span").css("color", "#fff");

        }
        <!--包车方统计-->
        var pendAmount = $("#被拒绝订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/charter/order/statistics", {'ids': '-3'});
        }
        var pendAmount = $("#待出发订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/charter/order/statistics", {'ids': '1,2,5'});
        }
        var pendAmount = $("#待确定订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/charter/order/statistics", {'ids': '0'});
        }
        var pendAmount = $("#待付订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/charter/order/statistics", {'ids': '-1'});
        }
        var pendAmount = $("#待匹配订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/charter/order/statistics", {'ids': '-2'});
        }
        <!--运输方统计-->
        var pendAmount = $("#未接订单").text();
        if (pendAmount != null && '' != pendAmount) {
            statistics(pendAmount, "${ctx}/transport/order/statistics", {'ids': '0'});
        }
        var matchAmount = $("#匹配订单").text();
        if (matchAmount != null && '' != matchAmount) {
            statistics(matchAmount, "${ctx}/transport/order/statistics", {'ids': '-2'});
        }
        var certAmount = $("#证件提醒").text();
        if (certAmount != null && '' != certAmount) {
            statistics(certAmount, "${ctx}/transport/certificate/statisticsDue", {});
        }
        var complaintAmount = $("#投诉管理").text();
        if (complaintAmount != null && '' != complaintAmount) {
            statistics(complaintAmount, "${ctx}/transport/order/statisticsNum", {});
        }
        var evaluateAmount = $("#评价分析").text();
        if (evaluateAmount != null && '' != evaluateAmount) {
            statistics(evaluateAmount, "${ctx}/transport/order/statisticsNum1", {});
        }
    }

    //左边菜单点击收放事件
    function init_click() {
        /**左边菜单**/
        $('aside div ul li').click(function () {
            $(this).next('dl').slideToggle();
            if ($(this).find('i').attr('class') == 'icon-sort-down') {
                $(this).find('i').attr('class', 'icon-sort-up')
            } else {
                $(this).find('i').attr('class', 'icon-sort-down')
            }
        })
//    	$('aside div ul li').click(function(){
//    		//$(this).next('dl').slideToggle();
//    		if($(this).find('i').attr('class') == 'icon-sort-down'){
//    			$(this).find('i').attr('class','icon-sort-up')
//    		}else{
//    			$(this).find('i').attr('class','icon-sort-down')
//    		}
//    	})
    }

    //数量统计
    function statistics(id, url, dataJson) {
        $.ajax({
            type: "POST",
            url: url,
            data: dataJson,
            dataType: "json",
            async: false,
            success: function (data) {
                $('#' + id).append("<span class='layui-badge' style='margin-left:5px;'>" + data + "</span>");
                var position = $(".position").text();
                if (position != null && '' != position) {
                    position = position.substring((position.lastIndexOf('->') + 2), position.length);
                    position = position.replace(" ", "");
                    $("#" + position + " span").css("color", "#ffea02");

                }
            }
        });
    }

    //跳转
    function left_forward(url) {
        if (url != null && '' != url && 'undefined' != url) {
            top.location.href = "${ctx}/" + url;
        }
    }

    setInterval("setTime()", 1000);


    function setTime() {

        $(".aside_title").text(getNowFormatDate());

    }

    // 获取当前系统时间格式化为 yyyy-MM-dd HH:mm:ss
    function getNowFormatDate() {
        var date = new Date();
        var current_date = dateFtt("yyyy-MM-dd hh:mm:ss",date);
//        var seperator1 = "-";
//        var seperator2 = ":";
//        var year = date.getFullYear();
//        var month = date.getMonth() + 1;
//        var strDate = date.getDate();
//        if (month >= 1 && month <= 9) {
//            month = "0" + month;
//        }
//        if (strDate >= 0 && strDate <= 9) {
//            strDate = "0" + strDate;
//        }
//
//        var current_date = year + seperator1 + month + seperator1 + strDate
//            + " " + date.getHours() + seperator2 + date.getMinutes()
//            + seperator2 + date.getSeconds();
        return current_date;
    }
    $('.aside_menu dl dd').click(function() {
        localStorage.setItem('newPage', $(this).attr('id'))
    })
    asideDown(localStorage.getItem('newPage'))
    function dateFtt(fmt,date)
    {
        var o = {
            "M+" : date.getMonth()+1,                 //月份
            "d+" : date.getDate(),                    //日
            "h+" : date.getHours(),                   //小时
            "m+" : date.getMinutes(),                 //分
            "s+" : date.getSeconds(),                 //秒
            "q+" : Math.floor((date.getMonth()+3)/3), //季度
            "S"  : date.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt))
            fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
            if(new RegExp("("+ k +")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    }
    function asideDown(str) {
        $('#' + str).parent('dl').prev().click()
    }
</script>