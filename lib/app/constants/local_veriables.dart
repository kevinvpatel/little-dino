import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/constants.dart';

class LocalVariables{


  static List quizdetail = [];
  static var userId = '';
  static String role = '';
  static String firstName = '';
  static String lastname = '';
  static String emailId = '';
  static String birthDate = '';
  static String gender = '' ;
  static String profilePath = '';
  static String selectedQuizTypeId = '';

  static Map savedCategories = {};
  static Map<String,dynamic> savedQuiz = {};
  static Map<String,dynamic> savedQuizCategories = {};
  static Map<String,dynamic> displaySvaedcategories = {};
  static List<Map<String,dynamic>> categoriesDetail = [];


  static List<Map<String,dynamic>> Categoriesdata = [];
  static List<Map<String,dynamic>> QuizData = [];
  static List<Map<String,dynamic>> learningData = [];
  static String selectedIndexOfQuizCategories = '';

  static var selectedCategory_uniqueId = '';
  static var selectedCategory_Id = '';
  static var selectedCategory_title = '';
  static var quizType_uniqueId = '';
  static var selectedquiz_Id = '';
  static var selectedquiz_uniqId = '';
  static var selectedlevel_uniqueId = '';
  static var selectedCategory = '';
  static var selectedquiz = '';
  static var question_uniqId = '';
  static var selectedQuiedname = '';
  static int riteAnswers = 0;
  static int totlequestions = 0;
  static bool fromCompelet = false;
  static String fromScreen = '';

  static int? initalizeCard;


  static getDataFrom_hive() {
    final _myBox = Hive.box('users_Info');
    final datas = _myBox.get(1) ?? _myBox.get(2);
    userId =  datas['uniqid'] != ''?datas['uniqid']:'Users';
    role =  datas['role'] != ''?datas['role']:'Users';
    lastname = datas['last_name'] != ''?datas['last_name']:'Users';
    firstName = datas['first_name'] != ''?datas['first_name']:'Users';
    gender = datas['gender'] != ''?datas['gender']:'Users';
    birthDate = datas['dob'] != ''?datas['dob']:'Users';
    emailId = datas['email'] != ''?datas['email']:'Users';
    // profilePath = datas['profile'] != ''?datas['profile']:'assets/profile/default-profile.jpg';
    profilePath = datas['profile'] != '' ? datas['profile'] : Constants.PROFILE;
  }

  static deleteData(){
    final _myBox = Hive.box('users_Info');
    _myBox.delete(1);
    userId = '';
    role = '';
    lastname = '';
    firstName = '';
    gender = '';
    birthDate = '';
    emailId = '';
    profilePath = '';
  }

}
