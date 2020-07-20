package servlet;

import pageGrade.View;
import sun.misc.BASE64Encoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@WebServlet("/login")
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String yhm = request.getParameter("yhm");
        String mm = request.getParameter("mm");
        session.setAttribute("yhm", yhm);
        session.setAttribute("mm",mm);
        if (yhm==null||mm==null){
            RequestDispatcher dispatcher=request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);//页面跳转到index.jsp
            //session = request.getSession();
        }
        if(request.getSession().getAttribute("yhm")==null||request.getSession().getAttribute("mm")==null)
            request.getRequestDispatcher("index.jsp").forward(request, response);
        View v = new View();
        String tip = v.Login_value(yhm,mm);
        if(tip == "欢迎登陆") {
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");//可以方便地修改
            System.out.println("学号:"+yhm+" 密码:"+EncoderByMd5(mm)+ " 时间:"+dateFormat.format( now ));
            Calendar date = Calendar.getInstance();
            String year = String.valueOf(date.get(Calendar.YEAR));
            int yearnumber = Integer.parseInt(year);
            int yhmnumber = Integer.parseInt(yhm) / 100000000 + 2000;
            Calendar cal = Calendar.getInstance();
            if((cal.get(Calendar.MONTH) + 1)<7&&yearnumber==cal.get(Calendar.YEAR)){
                yearnumber = yearnumber - 1;
            }
            int xqnumber = 1;
            if(cal.get(Calendar.MONTH) - 9<0) xqnumber = 2;
            request.getSession().setAttribute("yearnumber", yearnumber-1);//下拉框数据，如：2019年 即 yearnumber为2019
            request.getSession().setAttribute("yhmnumber",yhmnumber);//下拉框数据，如：1700502255 即 yhmnumber为2017,从而显示数据
            request.getSession().setAttribute("xqnumber",xqnumber);//判断在什么学期
            RequestDispatcher dispatcher=request.getRequestDispatcher("info.jsp");
            dispatcher.forward(request, response);//页面跳转到info.jsp
        }else{
            session.setAttribute("tip","<script>alert('"+tip+"');</script>");//仿照xss网页攻击，调用js脚本实现密码错误弹窗提示
            RequestDispatcher dispatcher=request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);//页面跳转到index.jsp
        }
}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    /**利用MD5进行加密*/
    public String EncoderByMd5(String str)  {
        //确定计算方法
        MessageDigest md5= null;
        try {
            md5 = MessageDigest.getInstance("MD5");
            BASE64Encoder base64en = new BASE64Encoder();
            //加密后的字符串
            str=base64en.encode(md5.digest(str.getBytes("utf-8")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }
}
