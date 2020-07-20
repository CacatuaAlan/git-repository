package pageGrade;

public class View {
	  String tipString;
	  ConnectJWGL connectJWGL ;
	  public String  Login_value(String stuNum,String password) {
		  connectJWGL = new ConnectJWGL(stuNum,password);
		  try {
				connectJWGL.init();
				tipString = connectJWGL.beginLogin();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	        return tipString;	}
	  public String getScore(String year, String term)  {
          try {
              tipString = connectJWGL.getStudentGrade1(Integer.parseInt(year),Integer.parseInt(term));
          } catch (NumberFormatException e) {
              e.printStackTrace();
          }finally {
              connectJWGL.logout();
          }
          return  tipString;
		}
}
