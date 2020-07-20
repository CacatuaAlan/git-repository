<%--
  Created by IntelliJ IDEA.
  User: 国瑚
  Date: 2019/10/17
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta charset="UTF-8"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0"
	name="viewport">
<title>广东药科大学成绩查询</title>
<style>
/*html{ filter: grayscale(100%); -webkit-filter: grayscale(100%); -moz-filter: grayscale(100%); -ms-filter: grayscale(100%); -o-filter: grayscale(100%); filter: url("data:image/svg+xml;utf8,#grayscale"); filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); -webkit-filter: grayscale(1);}*/
* {
	margin: 0;
	padding: 0;
}

body {
	background: #EFEFEF;
}

h1 {
	height: 70px;
	line-height: 70px;
	font-size: 25px;
	color: #0076c1;
	padding: 0 0 0 20px;
}

nav li {
	float: left;
	list-style: none;
	margin-left: 20px;
}

.navi {
	text-decoration: none;
	color: #00A5ED;
	font: '微软雅黑', '黑体', sans-serif;
	font-size: 20px;
	cursor: pointer;
}

#container {
	width: 100%;
	height: 600px;
	margin: 0 auto;
	position: absolute;
}

#login {
	margin: auto auto;
	text-align: center;
}

fieldset {
	height: 70%;
	font-size: 25px;
}

legend {
	margin-left: 20px;
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

.buts1:hover {
	border: 1px solid rgba(0, 0, 0, 0.05);
	box-shadow: 1px 1px 2px rgba(255, 255, 255, 0.2);
	color: #fff;
	cursor: pointer;
}

.buts1 {
	width: 86%;
	height: 27px;
	border-radius: 2px;
	border: 1px solid rgba(0, 0, 0, 0.05);
	background-color: #0076c1;
	font-size: 13px;
	color: white;
	text-align: center;
	float: right;
}

.user_login {
	width: 320px;
	padding: 10px;
	border: 1px solid #DBDBD0;
	background-color: #FFFFFF;
	margin: 10px auto;
	border-radius: .3em;
}

.user_login * {
	margin: 0;
	padding: 0;
}

.user_login h3 {
	height: 30px;
	line-height: 34px;
	font-weight: bold;
	text-align: center;
	/*             background-color: #00A5ED; */
	/*             border-radius: .3em; */
	font-size: 18px;
	color: black;
}

.user_login .content {
	padding: 5px;
}

@media screen and (max-width: 640px) {
	.user_login {
		width: 316px;
		margin-top: 10%;
	}
	h1 {
		height: 40px;
		font-size: 20px;
		line-height: 40px;
		color: #0076c1;
		padding: 0 0 0 20px;
	}
}

.user_login .frm_cont.buts, .user_login .frm_cont.password, .user_login .frm_cont.forget {
	/*         	margin:0 auto; */
	text-align: center;
	margin-top: 10px;
}

.user_login .frm_cont.forget a{
	margin-top:8px;
}

.user_login .frm_cont label {
	cursor: pointer;
	font-size: 15px;
}

.user_login .number input, .user_login .password input, .user_login .xn input,
	.user_login .xq input {
	width: 86%;
	height: 27px;
	padding: 3px 3px 0;
	border: 1x solid #A9A98D;
	/* 	border-radius:3px; */
	margin: 0 0 0 5px;
}

.user_tip {
	background-color: #f2dede;
	border-radius: .3em;
	color: #a9442d;
	width: 280px;
	margin: 15px auto;
	padding: 10px;
	font-size: 15px;
}

.frm_cont.forget {
	padding: 15px;
	margin-bottom: 8px;
	margin-top: 8px;
}

.frm_cont.forget a {
	text-decoration: none;
	color: #0076c1;
	font-size: 13px;
	float: right;
}

.frm_cont.forget a:hover {
	cursor: pointer;
	color: #0076c1;
	text-decoration: underline;
}
/*.tubiao{ width:20px;height:13px;position:absolute;right:12%;padding-top: 8px;opacity: 0.5;}*/
/*.tubiao:hover{opacity: 1;}*/
</style>
<%--    <script>--%>
<%--        var flag = true;--%>
<%--        var img = document.getElementById("dj");--%>
<%--        function show(){--%>
<%--            var imgObj = document.getElementById("dj");--%>
<%--            if(imgObj.getAttribute("src",2)=="img/1.png"){--%>
<%--                document.getElementById("mm").type="text"--%>
<%--                imgObj.src="img/2.png";--%>
<%--            }else{--%>
<%--                document.getElementById("mm").type="password"--%>
<%--                imgObj.src="img/1.png";--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
</head>
<body>
	<div>
		<%
			//记录当天访问量
			Integer applicationCount = (Integer) application.getAttribute("applicationCount");
			if (applicationCount == null) {
				applicationCount = 0;
			}
			applicationCount = applicationCount + 1;
			application.setAttribute("applicationCount", applicationCount);
		%>
		<div id="container">
			<h1>广东药科大学成绩查询系统</h1>
			<!-- 只用了两个核心属性，别的可以自行实验 -->

			<fieldset
				style="margin-right: auto; margin-left: auto; min-height: 80%;">
				<legend
					style="text-align: right; font-size: 15px; padding: 0 10px 0 0;">
					当前访问量：<%=applicationCount%></legend>
				<marquee behavior="scroll" direction="left">
					<font style="color: red; font-size: 15px;">系统休息时间：00:00-08：00，如有不便，望同学们谅解！</font>
				</marquee>
				<div class="user_login">
					<h3>学生登录</h3>
					<div class="content">
						<form action="loginServlet" method="post" name="form1">
							<div class="frm_cont number">
								<label for="number">学号</label> <input type="text" name="yhm"
									id="yhm" value="${sessionScope.yhm}" pattern="[0-9]{10}"
									title="请输入正确的学号" placeholder="请输入学生学号">
							</div>
							<div class="frm_cont password">
								<label for="password">密码</label> <input type="password"
									name="mm" id="mm" required="required" title="请输入密码"
									placeholder="请输入教务系统密码" background-image="img/1.png">
								<%--                            <img id="dj" class="tubiao" title="点击隐藏或显示密码" src="img/1.png" onclick="show()"/>--%>
							</div>
							<div class="frm_cont buts">
								<input type="submit" value="登录" class="buts1">
								<!-- 								<input type="reset" class="buts2" value="刷新本页"> -->
							</div>
							<div class="frm_cont forget">
									<a href="http://jwsys.gdpu.edu.cn/pwdmgr/retake/index.zf"
										target="_blank">忘记密码</a>
								</div>
						</form>
					</div>
					<div class="user_tip">
						1：学生账号为学号，初始密码学生为证件号码后六位<br> 2：密码忘记请联系学院的教学秘书或辅导员<br>
						3：密码组成为数字加字母<br>
					</div>
					<div style="height: 8px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
				</div>
			</fieldset>
			<div id="foo">
				<font>&copy;&nbsp;&nbsp;2019&nbsp;&nbsp;<a
					href="http://www.yiban.cn" target="_blank">广东药科大学易班学生工作站</a></font>
			</div>
		</div>
		<%--        弹窗提示     --%>
		<div>${tip}</div>
		<%--        弹窗提示清空     --%>
		<div>${tip=""}</div>
</body>
</html>
