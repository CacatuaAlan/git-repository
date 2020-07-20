<%@ page import="pageGrade.View"%>
<%@ page import="java.util.Calendar"%>

<%--
  Created by IntelliJ IDEA.
  User: 国瑚
  Date: 2019/10/11
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0"
	name="viewport">
<title>查询结果</title>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style>
/*html{ filter: grayscale(100%); -webkit-filter: grayscale(100%); -moz-filter: grayscale(100%); -ms-filter: grayscale(100%); -o-filter: grayscale(100%); filter: url("data:image/svg+xml;utf8,#grayscale"); filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); -webkit-filter: grayscale(1);}*/
.loadEffect {
	width: 100px;
	height: 100px;
	position: relative;
	margin: 0 auto;
	margin-top: 100px;
}

.loadEffect span {
	display: inline-block;
	width: 30px;
	height: 10px;
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	background: deepskyblue;
	position: absolute;
	-webkit-animation: load 1.04s ease infinite;
}

@
-webkit-keyframes load { 0%{
	opacity: 1;
}

100%{
opacity
:
 
0
.2
;

            
}
}
.loadEffect span:nth-child(1) {
	left: 0;
	top: 50%;
	margin-top: -5px;
	-webkit-animation-delay: 0.13s;
}

.loadEffect span:nth-child(2) {
	left: 10px;
	top: 20px;
	-webkit-transform: rotate(45deg);
	-webkit-animation-delay: 0.26s;
}

.loadEffect span:nth-child(3) {
	left: 50%;
	top: 10px;
	margin-left: -15px;
	-webkit-transform: rotate(90deg);
	-webkit-animation-delay: 0.39s;
}

.loadEffect span:nth-child(4) {
	top: 20px;
	right: 10px;
	-webkit-transform: rotate(135deg);
	-webkit-animation-delay: 0.52s;
}

.loadEffect span:nth-child(5) {
	right: 0;
	top: 50%;
	margin-top: -5px;
	-webkit-transform: rotate(180deg);
	-webkit-animation-delay: 0.65s;
}

.loadEffect span:nth-child(6) {
	right: 10px;
	bottom: 20px;
	-webkit-transform: rotate(225deg);
	-webkit-animation-delay: 0.78s;
}

.loadEffect span:nth-child(7) {
	bottom: 10px;
	left: 50%;
	margin-left: -15px;
	-webkit-transform: rotate(270deg);
	-webkit-animation-delay: 0.91s;
}

.loadEffect span:nth-child(8) {
	bottom: 20px;
	left: 10px;
	-webkit-transform: rotate(315deg);
	-webkit-animation-delay: 1.04s;
}

* {
	margin: 0;
	padding: 0;
}

body {
	background: #EFEFEF;
}

#nav_container {
	color: white;
	background: #0076c1;
	height: 50px;
	line-height: 50px;
	font-size: 20px;
	padding-left: 7.5%;
}

#body_container {
	height: 70%;
	width: 80%;
	background-color: white;
	margin: 20px auto;
}

#foo {
	bottom: 5px;
	text-align: center;
}

#foo font {
	text-align: center;
	font-size: 14px;
	font-weight: 300px;
}

#foo a {
	text-decoration: none;
	color: black;
}

#foo a:hover {
	color: #0076c1;
}

#submit {
	background: white;
	height: 40px;
	line-height: 40px;
	text-align: right;
	padding: 5px;
}

#select {
	padding: 20px 12px 12px 12px;
}

#form {
	border: 1px solid #EFEFEF;
}

#select select {
	height: 35px;
	width: 20%;
	padding: 3px 2px 0;
	border: 1px solid #A9A98D;
	margin: 10px;
	border-radius: .5em;
}

#xn select {
	width: 100px;
}

#select label {
	margin: 0 10px 0 10px;
}

#submit input {
	width: 60px;
	height: 35px;
	padding: 2px;
	border: 1px solid #A9A98D;
	border-radius: .5em;
	background: #0076c1;
	cursor: pointer;
	color: white;
	font-weight: bold;
}

.score {
	width: 100%;
	height: 40px;
	margin: 0px auto;
	margin: 20px 0 8px 0;
	border: 1px solid #EFEFEF;
	background-color: white
}

thead {
	background-color: #EFEFEF;
	font-weight: 400;
	color: #777777;
	font-size: 14px;
}

tbody {
	overflow-x: auto;
	overflow-y: auto;
	height: 80%;
	color: #777777;
	font-size: 13px;
}

.test-5::-webkit-scrollbar {
	/*滚动条整体样式*/
	margin: 20px 0 8px 0;
	width: 7px; /*高宽分别对应横竖滚动条的尺寸*/
	height: 1px;
}

.test-5::-webkit-scrollbar-thumb {
	/*滚动条里面小方块*/
	border-radius: 7px;
	background-color: #EFEFEF;
	background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, 0.2)
		25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.2) 50%,
		rgba(255, 255, 255, 0.2) 75%, transparent 75%, transparent);
}

.test-5::-webkit-scrollbar-track {
	/*滚动条里面轨道*/
	box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
	background: #EFEFEF;
	border-radius: 7px;
}
</style>
<script src="js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	function ajaxFun() {
		var tip = "<div class=\"loadEffect\">\n" + "    <span></span>\n"
				+ "    <span></span>\n" + "    <span></span>\n"
				+ "    <span></span>\n" + "    <span></span>\n"
				+ "    <span></span>\n" + "    <span></span>\n"
				+ "    <span></span>\n" + "</div>";
		document.getElementById("infoSorce").innerHTML = tip;
		$('#infoSorce').html(tip);
		$.ajax({
			type : "POST", //传数据的方式
			url : "getGradeServlet", //servlet地址
			data : $('#form').serialize(), //传的数据  form表单 里面的数据
			success : function(infoSorce) { //传数据成功之后的操作   result是servlet传过来的数据  这个函数对result进行处理，让它显示在 输入框中
				document.getElementById("infoSorce").innerHTML = infoSorce;
				$('#infoSorce').html(infoSorce);
				$(document).ready(function() {
					$("tr:gt(0) td:nth-child(3)").each(function(i, j) {
						if ($(this).text() < 60) {
							$(this).parent().css('color', 'red');
						}
					});
				});
			}
		});
	}
</script>
</head>
<body>
	<%
		if (request.getSession().getAttribute("yhm") == null || request.getSession().getAttribute("mm") == null)
			response.sendRedirect("index.jsp");
	%>
	<header>
		<div id="nav_container">
			<div style="float: left">学生成绩查询</div>
			<div style="font-size: 12px; line-height: 55px;">[${yhm}]</div>
		</div>
	</header>

	<div id="body_container">
		<div id="select">
			<form id="form" method="post">
				<label for="xn">学年</label> <input type="hidden" name="yhm" id="yhm"
					value="${sessionScope.yhm}"> <input type="hidden" name="mm"
					id="mm" value="${sessionScope.mm}"> <select name="xn"
					id="xn">
					<%--类似for循环--%>
					<c:forEach var="x" begin="${sessionScope.yhmnumber}"
						end="${sessionScope.yearnumber}">
						<c:choose>
							<%-- 类似if/else --%>
							<c:when test="${x==sessionScope.xn}">
								<option value="${x}" selected>${x}-${x+1}</option>
							</c:when>
							<c:otherwise>
								<option value="${x}">${x}-${x+1}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> <label for="xq">学期</label> <select name="xq" id="xq">
					<%--类似for循环--%>
					<c:forEach var="x" begin="1" end="2">
						<%-- 类似if/else --%>
						<c:choose>
							<c:when test="${x==sessionScope.xq}">
								<option value="${x}" selected>${x}</option>
							</c:when>
							<c:otherwise>
								<option value="${x}">${x}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<div id="submit">
					<input type="button" onclick="ajaxFun()" value="查询">
				</div>
			</form>


			<div class="test test-5" id="main_table" align="center"
				style="overflow-x: auto; overflow-y: auto; height: 80%;">
				<!--成绩单（通过session传值网页接收）-->
				<div id="infoSorce" class="scrollbar"></div>
			</div>
		</div>
	</div>
	<div id="foo">
		<font>&copy;&nbsp;&nbsp;2019&nbsp;&nbsp;<a
			href="http://www.yiban.cn" target="_blank">广东药科大学易班学生工作站</a></font>
	</div>


</body>
</html>
