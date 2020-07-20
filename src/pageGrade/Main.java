package pageGrade;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws Exception {
        View v = new View();
        Scanner input = new Scanner(System.in);
//        System.out.print("请输入学号:");
//        String stuNum = input.next();
//        System.out.print("请输入密码:");
//        String password = input.next();
        if(v.Login_value("1800502106","31469agcb,./") == "欢迎登陆"){
//            System.out.print("输入学年（2018-2019就输2018）:");
//            String year = input.next();
//            System.out.print("输入学期（1或2）:");
//            String term = input.next();
            System.out.println(v.getScore("2017", "2"));}
//            connectJWGL.getStudentGrade(year, term);
//        connectJWGL.logout();
//        input.close();
        System.out.println("over");
    }
}
