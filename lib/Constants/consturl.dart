/**
 * Created by LENOVO on 4/20/2016.
 */
 class ConstValue {
//    public  static String BASE_URL = "http://shreehariweb.com/education/";
    static String BASE_URL = "http://schoolportal.mtemporary.hol.es";
    // public  static String BASE_URL = "http://192.168.0.102:89/education/";
    static  String LOGIN_URL = BASE_URL+"/index.php/api/login";
   static String STUDENT_PROFILE_URL = BASE_URL+"/index.php/api/get_student_profile";
   static String STUDENT_ATTENDENCE_URL = BASE_URL+"/index.php/api/get_student_attendence";
   static String EXAMS_URL = BASE_URL+"/index.php/api/get_exams";
   static String RESULTS_URL = BASE_URL+"/index.php/api/get_results";
   static String EVENT_URL = BASE_URL+"/index.php/api/get_school_event";
   static String TEACHERS_URL = BASE_URL+"/index.php/api/get_school_teacher";
   static String TOP_STUDENT_URL = BASE_URL+"/index.php/api/get_top_student";
   static String HOLIDAY_URL = BASE_URL+"/index.php/api/get_holidays";
   static String NOTICEBOARD_URL = BASE_URL+"/index.php/api/get_school_noticeboard";
   static String GROWTH_URL = BASE_URL+"/index.php/api/get_student_growth";
   static String RESULTS_REPORT_URL = BASE_URL+"/index.php/api/get_result_report";
   static String ENQUIRY_URL = BASE_URL+"/index.php/api/get_enquiry";
   static String SEND_ENQUIRY_URL = BASE_URL+"/index.php/api/send_enquiry";
   static String GCM_REGISTER_URL = BASE_URL+"/index.php/api/register_gcm";

   static  String PREF_NAME = "education.pref";
   static  String COMMON_KEY = "student_id";
   static  int student_id = -1;

  static String GCM_SENDER_ID = "881835876590";
}
