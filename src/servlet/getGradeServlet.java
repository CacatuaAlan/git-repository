package servlet;

import pageGrade.View;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getGradeServlet")
public class getGradeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String tip = "结果展示区";
        String yhm = request.getParameter("yhm");
        String mm = request.getParameter("mm");
        String xn = request.getParameter("xn");
        String xq = request.getParameter("xq");
        View v = new View();
        tip = v.Login_value(yhm, mm);
        if (tip == "欢迎登陆") {
            String infoSorce = null;
            session.setAttribute("xn", xn);//接收网页的学年数据
            session.setAttribute("xq",xq);//接收网页的学期数据
            infoSorce = v.getScore(xn,xq);//获取成绩

            PrintWriter out = response.getWriter();
            out.println(infoSorce);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
