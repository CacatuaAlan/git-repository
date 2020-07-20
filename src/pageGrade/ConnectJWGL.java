package pageGrade;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class ConnectJWGL {

    private final String url = "http://jwsys.gdpu.edu.cn";
    private Map<String,String> cookies = new HashMap<String,String>();
    private String modulus;
    private String exponent;
    private String csrftoken;
    private Connection connection;
    private Connection.Response response;
    private Document document;
    private String stuNum;
    private String password;
    private String realpasswd;
//    Date now = new Date();
//    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");//可以方便地修改


    public ConnectJWGL(String stuNum,String password){
        this.stuNum = stuNum;
        this.password = password;
        realpasswd = password;
    }

    public void init() throws Exception{
        getCsrftoken();
        getRSApublickey();
    }

    // 获取csrftoken和Cookies
    private void getCsrftoken(){
        try{
            connection = Jsoup.connect(url+ "/xtgl/login_slogin.html?language=zh_CN&_t="+new Date().getTime());
            //System.out.println(url+ "/xtgl/login_slogin.html?language=zh_CN&_t="+new Date().getTime());
            connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
            connection.timeout(3000);
            int times = 0;
            while ((response==null||cookies==null)&&times<10){
                try{
                    response = connection.execute();
                    cookies = response.cookies();
                }catch (SocketTimeoutException e){
                    System.out.println("连接超时!尝试重连("+(times+1)+"/10)");
                }
                times++;
            }
            //保存csrftoken
            document = Jsoup.parse(response.body());
            //System.out.println("hahahhah");
            csrftoken = document.getElementById("csrftoken").val();
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    // 获取公钥并加密密码
    public void getRSApublickey() throws Exception{
        connection = Jsoup.connect(url+ "/xtgl/login_getPublicKey.html?" +
                "time="+ new Date().getTime());
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        response = connection.cookies(cookies).ignoreContentType(true).execute();
        JSONObject jsonObject = JSON.parseObject(response.body());
        modulus = jsonObject.getString("modulus");
        exponent = jsonObject.getString("exponent");
        password = RSAEncoder.RSAEncrypt(password, B64.b64tohex(modulus), B64.b64tohex(exponent));
        password = B64.hex2b64(password);
    }

    //登录
    public String beginLogin() throws Exception{
        connection = Jsoup.connect(url+ "/xtgl/login_slogin.html");//登录的url，下面是在浏览器中F12获取到的参数
        connection.header("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        connection.data("csrftoken",csrftoken);
        connection.data("yhm",stuNum);//用户名
        connection.data("mm",password);
        connection.data("mm",password);
        response = connection.cookies(cookies).ignoreContentType(true)
                .method(Connection.Method.POST).execute();
        //System.out.println("login: --------------- \n" + response.body());
        //response = connection.execute();
        document = Jsoup.parse(response.body());
        cookies = response.cookies();

        Element passCheck = document.getElementById("tips");
        if(passCheck == null){
            System.out.println("欢迎登陆【控制台】");
            return "欢迎登陆";
        }else{
            System.out.println(document.getElementById("tips").text()+"【控制台】");
            return passCheck.text();
        }
        
        
    }
    
 
    // 获取成绩信息
    public void getStudentGrade(int year , int term) throws Exception {
        Map<String,String> datas = new HashMap<>();
        datas.put("xnm",String.valueOf(year));
        datas.put("xqm",String.valueOf(term * term * 3));
        datas.put("_search","false");
        datas.put("nd",String.valueOf(new Date().getTime()));
        datas.put("queryModel.showCount","15");
        datas.put("queryModel.currentPage","1");
        datas.put("queryModel.sortName","");
        datas.put("queryModel.sortOrder","asc");
        datas.put("queryModel.sortName","");
        datas.put("time","0");

        connection = Jsoup.connect(url+ "/cjcx/cjcx_cxDgXscj.html?gnmkdm=N305005&layout=default&su=" + stuNum);
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        response = connection.cookies(cookies).method(Connection.Method.POST).data(datas).ignoreContentType(true).execute();
        connection = Jsoup.connect(url+ "/cjcx/cjcx_cxDgXscj.html?doType=query&gnmkdm=N305005");
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        response = connection.cookies(cookies).method(Connection.Method.POST)
                .data(datas).ignoreContentType(true).execute();
        //System.out.println("\n\n---------------------------------\n");
        //System.out.println(response.body());
        JSONObject jsonObject = JSON.parseObject(response.body());
       System.out.println(response.body());
        JSONArray gradeTable = JSON.parseArray(jsonObject.getString("items"));
        for (Iterator iterator = gradeTable.iterator(); iterator.hasNext();) {
            JSONObject lesson = (JSONObject) iterator.next();
            System.out.println("課程名稱"+lesson.getString("kcmc") + " " +"學分"+
                    lesson.getString("xf") + " " +"成績"+
                    lesson.getString("cj") + " " +"績點"+
                    lesson.getString("jd"));
        }
    }
    // 获取成绩信息1
    public String getStudentGrade1(int year , int term)  {
        Map<String,String> datas = new HashMap<String, String>();
        datas.put("xnm",String.valueOf(year));
        datas.put("xqm",String.valueOf(term * term * 3));
        datas.put("_search","false");
        datas.put("nd",String.valueOf(new Date().getTime()));
        datas.put("queryModel.showCount","15");
        datas.put("queryModel.currentPage","1");
        datas.put("queryModel.sortName","");
        datas.put("queryModel.sortOrder","asc");
        datas.put("queryModel.sortName","");
        datas.put("time","0");

        connection = Jsoup.connect(url+ "/cjcx/cjcx_cxDgXscj.html?gnmkdm=N305005&layout=default&su=" + stuNum);
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        connection.timeout(6000);
        try {
			response = connection.cookies(cookies).method(Connection.Method.POST).data(datas).ignoreContentType(true).execute();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        connection = Jsoup.connect(url+ "/cjcx/cjcx_cxDgXscj.html?doType=query&gnmkdm=N305005");
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        try {
			response = connection.cookies(cookies).method(Connection.Method.POST)
			        .data(datas).ignoreContentType(true).execute();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        JSONObject jsonObject = JSON.parseObject(response.body());
//        int count = 0;
        String datasString = "<table border=\"1\" name=\"scoreTable\" class=\"score\"cellspacing=\"0\" align=\"center\" width=\"568\">"+
                "<thead><tr><th>课程名称</th><th>学分</th><th>成绩</th><th>绩点</th></tr></thead><tbody>";
        JSONArray gradeTable = JSON.parseArray(jsonObject.getString("items"));
        for (Iterator iterator = gradeTable.iterator(); iterator.hasNext();) {
            JSONObject lesson = (JSONObject) iterator.next();
//            if(count==0){ System.out.println(String.format(lesson.getString("xm") + " 学号：" + stuNum + "  密码：" + EncoderByMd5(realpasswd) + " 学年:" + year + " 学期:" + term + " 查询时间:" + dateFormat.format( now )));count = 1;}
            datasString +="<tr><td>"+lesson.getString("kcmc") +"</td>"+"<td>"+
                                     lesson.getString("xf") +"</td><td>"+
                                     lesson.getString("cj") +"</td><td>" +
                                     lesson.getString("jd") +"</td></tr>";

        }
        logout();
		return datasString + "</tbody></table>";
    }
    public void logout()  {
        connection = Jsoup.connect(url+ "/logout?t="+new Date().getTime()+"&login_type=");
        connection.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0");
        try {
            cookies.remove("rememberMe");
            response = connection.cookies(cookies).ignoreContentType(true).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    /**利用MD5进行加密*/
//    public String EncoderByMd5(String str)  {
//        //确定计算方法
//        MessageDigest md5= null;
//        try {
//            md5 = MessageDigest.getInstance("MD5");
//            BASE64Encoder base64en = new BASE64Encoder();
//            //加密后的字符串
//            str=base64en.encode(md5.digest(str.getBytes("utf-8")));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return str;
//    }

}
