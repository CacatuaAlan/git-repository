<%--
  Created by IntelliJ IDEA.
  User: 国瑚
  Date: 2019/11/30
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8" name="viewport" content="width=device-width,initial-scale=1.0"/>
<style>
    .error_detail {width: 400px; height: auto; }
    .error_detail .error_p_title{ font-size: 28px; color: #eb8531;}
    .error_detail .error_p_con{ font-size:14px; margin-top: 10px; line-height: 20px;}
    .error_p_con a{  padding: 5px; border: 1px solid  #00A5ED; text-decoration:none; }

    a{
        height: 21px;
        line-height: 21px;
        padding: 0 11px;
        border-radius: 3px;
        /*color: #fff;*/
        display: inline-block;
        text-decoration: none;
        outline: none;
        font-weight: bold;
        padding-right: 2px;
        background-color: #00A5ED;
        color: white;
        font-size: 17px;
        text-align: center;
    }

</style>
</head>
<body>
<div class="error_detail" style="width: 100%;text-align:center">
    <div style="margin:0px auto;width: 400px;text-align: left" >
        <p class="error_p_title">哎呦~ 服务器居然累倒了!</p>
        <p class="error_p_con">●点击<a href="index.jsp">呼叫小易</a>。还是不行？哈哈，那小易也累倒了！</p>
        <p class="error_p_con">●如有其它的问题,可直接到易班办公室咨询哦!</p>
        <p class="error_p_con">●小易的进步需要您的反馈,感谢您对小易的关注!</p>
    </div>
    <div style="margin:0px auto;width: 400px;">
        <h3>更多精彩，敬请关注我们哦!</h3>
        <img src='https://ftp.bmp.ovh/imgs/2019/12/0d284b81f0d61b9f.png' style="width: 200px;">
    </div>
</div>
</body>
</html>
