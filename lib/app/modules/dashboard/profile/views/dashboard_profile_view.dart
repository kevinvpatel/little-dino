import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import '../controllers/dashboard_profile_controller.dart';

class DashboardProfileView extends GetView<DashboardProfileController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LocalVariables.getDataFrom_hive();
    ScreenUtil().setSp(24);
    DashboardProfileController controller = Get.put(DashboardProfileController());
    controller.cntfirstname.text = LocalVariables.firstName;
    controller.cntlastname.text  = LocalVariables.lastname;
    controller.cntBirthDate.text = LocalVariables.userId != "Users"
        ? DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd").parse(LocalVariables.birthDate))
        : LocalVariables.birthDate != 'Users' ? LocalVariables.birthDate : DateFormat("dd MMMM yyyy").format(DateTime.now());
    controller.firstname.value = controller.cntfirstname.text;
    controller.lastname.value = controller.cntlastname.text;
    controller.selectedImagePath.value = '';

    ///textfield
    Widget inputFilds({required String textfildtitle, TextEditingController? controller, required String hint, required bool readonly, required String sufixIconPath, required Function() fun}){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textfildtitle,style: TextStyle(fontSize: 19.sp,color: ConstantsColors.fontColor,fontWeight: FontWeight.w700)),
          Container(
            height: 28.sp,
            child: TextField(
              onTap: fun,
              readOnly: readonly,
              scrollPadding: EdgeInsets.zero,
              controller: controller,
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700,fontSize: 17.sp),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700,fontSize: 17.sp),
                suffixIcon : SvgPicture.asset(sufixIconPath),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 30,
                  minHeight: 30,
                  maxWidth: 30,
                  minWidth: 30
                ),
                border: InputBorder.none
              ),
            ),
          ),
          Divider(height: 10,color: Colors.orange.withOpacity(0.5),thickness: 1.5)
        ],
      );
    }

    Widget buttonsForPickImage({required Function() fun, required String title, required IconData icon}){
      return Container(
        width: width,
        child:  CupertinoButton(
          onPressed: fun,
          child: Row(
            children: [
              Icon(icon,color: Colors.grey),
              SizedBox(width: 10.sp),
              Text(title,style: TextStyle(fontSize: 18.5.sp, color: Colors.black, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      );
    }

    getData()async {
      final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1960),
          initialDate: DateTime.now(),
          lastDate: DateTime(2100));
      if (date != null) {
        controller.cntBirthDate.text = DateFormat("dd MMMM yyyy").format(date);
      }
    }

    Widget setImage({required Widget content}){
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: content
      );
    }


    return SafeArea(
      top: false,
      child: Scaffold( 
        backgroundColor: ConstantsColors.whitecolor,
        body: Container(
          height: height,
          color: Colors.orangeAccent.withOpacity(0.2),
          child: SingleChildScrollView(
            child: Obx(() => Stack(
              children: [
                ///Appbar
                Container(
                  height: 200.sp,
                  padding: EdgeInsets.only(top: 25.sp),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profile", style: TextStyle(fontSize: 22.sp,color: Colors.white,fontWeight: FontWeight.w600)),
                            SvgPicture.asset("assets/appbar/add-reminder.svg",fit: BoxFit.cover,width: 20.w,)
                          ],
                        ),
                      ),
                      SizedBox(height: 50.sp),
                      Center(
                        child:  Column(
                          children: [
                            Text("${controller.firstname.value == 'Users' ? '' : controller.firstname.value} ${controller.lastname.value}", style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 25.sp,fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Spacer(),
                      Obx(() => controller.isEdit.value == false?InkWell(
                        onTap: (){
                          controller.isEdit.value = true;
                          print("controller.isEdit.value ----------> ${controller.isEdit.value}");
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 50.sp,
                            width: 50.sp,
                            padding: EdgeInsets.all(13.sp),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(32))
                            ),
                            child: SvgPicture.asset("assets/profile/edit.svg",color: Colors.white.withOpacity(0.9)),
                          ),
                        ),
                      ) : SizedBox.shrink())
                    ],
                  ),
                ),
                ///Body
                Container(
                  width: width,
                  color: Colors.orangeAccent,
                  margin: EdgeInsets.only(top: 200.sp),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30))
                    ),
                    child: Container(
                      color: Colors.orangeAccent.withOpacity(0.2),
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.sp),
                          Obx(() => Container(
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                inputFilds(
                                    textfildtitle: 'First Name',
                                    controller: controller.cntfirstname,
                                    hint: LocalVariables.firstName,
                                    readonly: !controller.isEdit.value,
                                    sufixIconPath: 'assets/login/name_logo.svg',
                                    fun: (){}
                                ),
                                inputFilds(
                                    textfildtitle: 'Last Name',
                                    controller: controller.cntlastname,
                                    hint: LocalVariables.lastname,
                                    readonly: !controller.isEdit.value,
                                    sufixIconPath: 'assets/login/name_logo.svg',
                                    fun: (){}
                                ),
                                // inputFilds(textfildtitle: 'BirthDay',controller: controller.cntBirthDate,hint: LocalVariables.birthDate,readonly: true,sufixIconPath: 'assets/profile/birthdat_icon.svg',fun: () => controller.isEdit.value?getData():{}),
                              ],
                            ),
                          ),
                          ),
                          SizedBox(height: 30.sp),
                          Obx(() => controller.isEdit.value ? FlutterWidgets.button(
                              width: width,
                              backgroundColor: ConstantsColors.lightblue,
                              borderColor: ConstantsColors.darkblueColor,
                              content: Text("Done",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 18.sp,fontWeight: FontWeight.w600)),
                              height: 40.sp,
                              onTap: controller.ontap
                          ) : SizedBox.shrink()),
                          SizedBox(height: 30.sp),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150.sp,
                  left: width/2.8,
                  child: Stack(
                    children: [
                      LocalVariables.userId != "Users"
                          ? Obx(() {
                            print('controller.selectedImagePath.value 11-> ${controller.selectedImagePath.value}');
                            print('LocalVariables.profilePath 11-> ${LocalVariables.profilePath}');
                            return Container(
                                width: 110.sp,
                                height: 110.sp,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: ConstantsColors.whitecolor,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: controller.selectedImagePath.value != '' ?
                                setImage(content: Image.file(File(controller.selectedImagePath.value), fit: BoxFit.cover, width: 110.sp, height: 110.sp)) :
                                setImage(content: Image.network(LocalVariables.profilePath, fit: BoxFit.cover, width: 110.sp, height: 110.sp))
                            );
                          })
                          : Obx(() {
                            print('controller.selectedImagePath.value 22-> ${controller.selectedImagePath.value}');
                            print('LocalVariables.profilePath 22-> ${LocalVariables.profilePath}');
                            return Container(
                                width: 110.sp,
                                height: 110.sp,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: ConstantsColors.whitecolor,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: LocalVariables.profilePath != "Users"
                                    // ? setImage(content: FileImage(File(controller.selectedImagePath.value!= '' ? controller.selectedImagePath.value : LocalVariables.profilePath)))
                                    ? setImage(content: controller.selectedImagePath.value != ''
                                        ? Image.file(File(controller.selectedImagePath.value))
                                        : Image.file(File(LocalVariables.profilePath), width: 110.sp, height: 110.sp, fit: BoxFit.cover))
                                    : setImage(content: SvgPicture.asset(Constants.PROFILE))
                                    // : setImage(content: Image.file(File(controller.selectedImagePath.value)))
                            );
                          }),
                      // assets/profile/edit.svg
                      Obx(() => controller.isEdit.value == true?
                      Positioned(
                        right: 0,
                        top: 5.sp,
                        child: InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Container(
                                  height: 100.sp,
                                  child: Column(
                                    children: [
                                      buttonsForPickImage(title:'Camera',fun: () {
                                        controller.getImage(imagesounrce: ImageSource.camera);
                                        Get.back();
                                      }, icon: Icons.monochrome_photos),
                                      buttonsForPickImage(title: 'Gallary',fun: () {
                                        controller.getImage(imagesounrce: ImageSource.gallery);
                                        Get.back();
                                      }, icon: Icons.insert_photo_outlined)
                                    ],
                                  ),
                                ),
                              ),
                            ).then(((exit){return;}));
                          },
                          child: SvgPicture.asset("assets/profile/camera.svg"),),
                      )
                          : SizedBox.shrink())
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
