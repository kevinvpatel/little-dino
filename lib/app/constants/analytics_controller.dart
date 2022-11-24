import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // screenTrack({required String screenName, required String screenClass}) async {
  //   await analytics.logScreenView(screenClass: screenClass, screenName: screenName);
  // }

  androidButtonEvent({required String screenName, required String screenClass}) async {
    await analytics.logEvent(
        name: 'screen_view',
        parameters: {
          screenName : screenClass
        }
    );
    print('homescreen Track detected...');
  }

}