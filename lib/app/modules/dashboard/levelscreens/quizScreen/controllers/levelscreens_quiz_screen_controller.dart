import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/providers/answers_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/providers/quizquesion_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/quizquesion_model.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/views/levelscreens_quiz_screen_view.dart';

class LevelscreensQuizScreenController extends GetxController {
  //TODO: Implement LevelscreensQuizScreenController

  RxInt count = 0.obs;

  late RxList selectedans ;
  RxInt datalength = 0.obs;
  RxInt selectedOpetions = 0.obs;
  bool istapeOrNot = false;
  RxInt singleAnser = 0.obs;
  RxString selectedIndex = ''.obs;
  late RxList selectedAnswers;
  RxBool isItDisplay = false.obs;
  Rx<Answer> selectedanswer = Answer.none.obs;
  RxList<String> selectedmultipleOptions = [''].obs;
  RxList<String> answers = [''].obs;
  var swipcard ;

  // Audio
  FlutterTts flutterTts = FlutterTts();

  List opetions = ['A','B','C','D'];
  List singleChoiseAnswer = [];


  // AppinioSwiperController  appinioSwiperController = AppinioSwiperController();

  Future<Quizquesion?> getdata() async {
    Quizquesion? quizquesion = await QuizquesionProvider().getQuizquesion().then((value) {
      LocalVariables.totlequestions = value!.data!.length;
      return value;
    });
    return quizquesion;
  }

  List ColorOfopetions = [ConstantsColors.lightblue, ConstantsColors.pinckColor, ConstantsColors.orangeColor, ConstantsColors.green];
  List lightColorOfopetions = [ConstantsColors.lightblue.withOpacity(0.15), ConstantsColors.pinckColor.withOpacity(0.15), ConstantsColors.orangeColor.withOpacity(0.15), ConstantsColors.green.withOpacity(0.15)];

  celculateLenghth()  async {
    Quizquesion? quizquesion = await QuizquesionProvider().getQuizquesion();
    LocalVariables.totlequestions = quizquesion!.data![0].question!.length;
    update();
  }


  Future<int> setAnsers({required List lstans}) async {
    print('lstans -> ${lstans}');
    int answers = await AnswersProvider().getAnswers(lstanswer: lstans);
    print('setanswers -> ${answers}');
    return answers;
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    // selectedanswer.value = Answer.none;
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
    Future.delayed(Duration.zero, () {
      LocalVariables.riteAnswers = 0;
      analyticsController.androidButtonEvent(screenName: 'QuizScreen_Android', screenClass: 'QuizScreenActivity');
    });
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
