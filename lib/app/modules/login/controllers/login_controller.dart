import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/global_variable.dart';
import 'package:little_dino_app/app/modules/login/User.dart';
import 'package:little_dino_app/app/modules/login/providers/login_providers.dart';
import 'package:little_dino_app/app/modules/login/providers/sigb_In_UsingEmil.dart';
import 'package:email_auth/email_auth.dart';
import 'package:little_dino_app/app/modules/login/user_model.dart';

class LoginController extends GetxController {

  final count = 0.obs;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();


  RxBool isLoaded = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _myBox = Hive.box('users_Info');

  // EmailAuth? emailAuth;

  // Future<User?> signInWithEmail({required BuildContext context}) async {
  //   User? user;
  //     try{
  //       UserCredential credential = await _auth.signInWithEmailAndPassword(
  //           email: email.text, password: pass.text);
  //       user = credential.user;
  //     }
  //     catch(error){
  //       print("Firebase Email Login error------------>$error");
  //     }
  // }


  UserModel? userModel;
  signInWithEmailApi() =>
      LoginProviders().loginByAapi(email: email.text, pass: pass.text);

  Future signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
          permissions: (['email', 'public_profile']));
      if (result.accessToken == null) return;
      final token = result.accessToken!.token;
      print('fb token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
      final profile = jsonDecode(graphResponse.body);
      print('Profile is equal to $profile');

      final AuthCredential fbCredential = FacebookAuthProvider.credential(
          result.accessToken!.token);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(fbCredential);
    } catch (e) {
      print('facebook login err 2 -> $e');
    }
  }


  Future<User?> signinInWithGoogle() async {
    UserData? userData;
    isLoaded.value = true;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      googleSignInAccount != null
          ? OnlyEmailSignIn(email: googleSignInAccount.email.toString())
          : isLoaded.value = false;
    } on FirebaseException catch (err) {
      isLoaded.value = false;
      Get.snackbar('Attention!', err.message!, titlefontsize: 19, messagefontsize: 17);
    }
  }


    OnlyEmailSignIn({required String email}) {
      OnlyEmailSign_In().getemailData(email: email, isfromProfile: false);
  }


    logOut() {
      try {
        _myBox.delete(1).then((value) => print("Delete Box"));
        googleSignIn.disconnect().then((value) => LocalVariables.deleteData());
       //  _auth.signOut()
       // .then((value) => googleSignIn.disconnect().then((value) => Get.to(LoginView()))).then((value) => _myBox.delete(1).then((value) => LocalVariables.deleteData()));
      } catch (error) {
        print("Error ------------->${error}");
        Get.snackbar("SomeThing Was Wrong", 'Failed to disconnect');
      }
    }

    void sendOTP(){

    }

    AnalyticsController analyticsController = Get.put(AnalyticsController());

    @override
    void onInit() {
      super.onInit();
      email.text = '';
      pass.text = '';
      // analyticsController.screenTrack(screenName: 'LoginScreen', screenClass: 'LoginScreenActivity');
      analyticsController.androidButtonEvent(screenName:  'LoginScreen_Android', screenClass: 'LoginScreenActivity');
      // emailAuth = new EmailAuth(sessionName: "Sample session");
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() {
      print('count incremented');
      count.value++;
    }
    decrement() => count.value--;

  }
