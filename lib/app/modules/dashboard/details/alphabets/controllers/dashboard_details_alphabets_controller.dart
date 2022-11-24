import 'dart:math';
import 'package:audio_session/audio_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/details/details_model.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/controllers/dashboard_details_first_detail_page_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/manageSavedata.dart';
import 'package:little_dino_app/app/modules/dashboard/details/providers/details_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class DashboardDetailsAlphabetsController extends GetxController {
  //TODO: Implement DashboardDetailsAlphabetsController

  RxInt count =  0.obs;
  RxInt currentIndex = 0.obs;
  int lengh = 0;
  var isLoading = true.obs;
  RxList productslist = [].obs;

  //Play Sound
  // RxBool playerState = false.obs;
  RxString playerState = ''.obs;
  RxString audio = "".obs;
  DashboardDetailsFirstDetailPageController firstDetailPageController = Get.put(DashboardDetailsFirstDetailPageController());


  play(uri) async {
      player.value.playerStateStream.listen((state) {
        if(state.playing) {
          switch (state.processingState) {
            case ProcessingState.idle:
              playerState.value = 'idle';
              break;
            case ProcessingState.loading:
              playerState.value = 'loading';
              break;
            case ProcessingState.buffering:
              playerState.value = 'buffering';
              break;
            case ProcessingState.ready:
              playerState.value = 'ready';
              break;
            case ProcessingState.completed:
              playerState.value = 'completed';
          }
        }
        // playerState.value = playing;
        print('playerState.value -> ${playerState.value}');
      });
    try{
      await player.value.setUrl(uri).then((value) => print("Audio Successufully loaded"));
    }
    catch(error){
      print("error to play audio ---> ${error}");
    }
  }


  final player = AudioPlayer(
      handleInterruptions: false,
      androidApplyAudioAttributes: false,
      handleAudioSessionActivation: false
  ).obs;

  _handleInterruptions(AudioSession audioSession) {
    bool playInterrupted = false;
    print('interruption type@@');
    audioSession.becomingNoisyEventStream.listen((_) {
      print('PAUSE');
      player.value.pause();
    });
    // player.value.playingStream.listen((playing) {
    //   playInterrupted = false;
    //   print('playing type: $playing');
    //   if (playing) {
    //     audioSession.setActive(true);
    //   }
    // });
    audioSession.interruptionEventStream.listen((event) {
      print('interruption begin: ${event.begin}');
      print('interruption type: ${event.type}');
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes!.usage ==
                AndroidAudioUsage.game) {
              player.value.setVolume(player.value.volume / 2);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            if (player.value.playing) {
              player.value.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            player.value.setVolume(min(1.0, player.value.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) player.value.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
    audioSession.devicesChangedEventStream.listen((event) {
      print('Devices added: ${event.devicesAdded}');
      print('Devices removed: ${event.devicesRemoved}');
    });
  }


  // Bottom Navigation Bar
  late AutoScrollController scrollController;
  CarouselController buttonCarouselController = CarouselController();

   RxList<RxBool> isselected = List.generate(50, (index) => false.obs).obs;

  // RxInt itemCount = 0.obs;

  Future<Details?> getAlphabetData({required String id}) async {
     var details = await DetailsProvider().getDetails(id: id).then((value) {
        productslist.clear();
        if(value != null) {
          // isselected = List.generate(value.data!.length, (index) => false.obs).obs;
          value.data!.forEach((element) {
            productslist.add(element.audio_string);
          });
        }
        return value;
    });
    return details;
  }

  setalphabets({required String id}) async{
    await DetailsProvider().getDetails(id: id).then((value){
      if(value != null) {
        isselected.value = List.generate(value.data!.length, (index) => false.obs).obs;
        print('value.data!.length -> ${value.data!.length}');
      }
    });
  }

  Stream manageSavedFCMbyHive() {
    ManageSavedata? manageSavedata;
    // setalphabets(id: LocalVariables.selectedCategory_uniqueId);
    return FirebaseFirestore.instance.collection("users").
            doc(LocalVariables.userId).collection('savedCategories').
            snapshots().
            map((event) {
              event.docs.forEach((element) async {
                await Hive.openBox("StorSavedDetailsFromFCM").then((value) {
                  final _myBox = Hive.box("StorSavedDetailsFromFCM");
                  _myBox.put(element['uniqid'], element.data());
                });
              });
              return event;
            });
  }


  manageSavedUseingHive({required String detailsUniqId,required int index}){
      Hive.openBox("savedCategories").then((value) {
        final _myBox = Hive.box("savedCategories");
        isselected.value[index].value = _myBox.get(detailsUniqId) == null ? false : true;
        firstDetailPageController.issetctedOrNot.value = isselected.value[index].value;
      });
  }

  manageSavedUseingHiveForFCM({required String detailsUniqId,required int index}){
    Hive.openBox("StorSavedDetailsFromFCM").then((value) {
      final _myBox = Hive.box("StorSavedDetailsFromFCM");
      print('isselected.value[index].value ££ -> ${isselected.value[index].value}');
      isselected.value[index].value = _myBox.get(detailsUniqId) == null ? false : true;
      print('isselected.value[index].value ¢¢¢¢¢ -> ${detailsUniqId}');
      _myBox.values.forEach((element) {
        print('_myBox.get(detailsUniqId) ¢¢¢¢¢ -> ${element}');
      });
    });
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    super.onInit();
    AudioSession.instance.then((audioSession) async {
      await audioSession.configure(AudioSessionConfiguration.speech());
      _handleInterruptions(audioSession);
      await player.value.setAsset("assets/sound/music.mp3");
    });
    analyticsController.androidButtonEvent(screenName: 'CategoryDetailScreen_Android', screenClass: 'CategoryDetailScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    player.value.dispose();
  }

  Future<void> increment() async {
      buttonCarouselController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
      update();
  }
  Future<void> decrement() async {
    buttonCarouselController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    update();
  }
}
