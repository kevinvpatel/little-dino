import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/login/controllers/login_controller.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../controllers/forgate_password_controller.dart';

class ForgatePasswordMainView extends GetView<ForgatePasswordController> {

  Widget progressButton({required double width, required BuildContext context}) {
    return Obx(() =>
        RoundedLoadingButton(
          child: Text(controller.buttonTitles[controller.count.value],
              style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
          controller: controller.btnController,
          color: Color.fromRGBO(95, 207, 255, 1),
          width: width * 0.9,
          loaderStrokeWidth: 3.0,
          onPressed: () async {

            print("controller.count.value  -> ${controller.count.value}");
            if(controller.count.value == 0) {
              if(controller.email.text == '') {
                Get.snackbar("Something is Wrong", "Please Enter EmailId",colorText: ConstantsColors.fontColor);
              }
              else{
                await controller.getUserList()
                    .then((uniqId) async => await controller.sendEmail()
                    .then((response) async {

                      controller.btnController.stop();
                      if(response['code'] == '200') {
                        await controller.pagecontroller.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn
                        ).then((value) => controller.increment());
                      } else {
                        Fluttertoast.showToast(
                            msg: response['message'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                }));
              }

            }
            else if(controller.count.value == 1){
              controller.verifyOTP()
                  .then((response) async {

                controller.btnController.stop();
                if(response['code'] == '200') {
                  await controller.pagecontroller.nextPage(
                      duration: Duration(milliseconds: 200),curve: Curves.easeIn
                  ).then((value) => controller.increment());
                } else {
                  Fluttertoast.showToast(
                      msg: response['message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              });
            }
            else{
              controller.changePassword().then((response) {
                print('response[code] -> ${response['status']}');
                controller.btnController.stop();
                if(response['status'] == 200) {
                  controller.bottomSheet(width: width, context: context);
                } else {
                  Fluttertoast.showToast(
                      msg: response['message'].toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              });
            }
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().setSp(24);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ForgatePasswordController controller = Get.put(ForgatePasswordController());

     controller.pagecontroller = PageController(
        initialPage: 0,
        keepPage: true,
        viewportFraction: 1
    );
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            backgroundColor: ConstantsColors.whitecolor,
            resizeToAvoidBottomInset: false,
            body: Container(
              width: width,
              height: height,
              color: ConstantsColors.backgroundcolor,
              child: PageView.builder(
                controller: controller.pagecontroller,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.bodyscreens.length,
                itemBuilder:(context, index) => controller.bodyscreens[index],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: progressButton(width: width, context: context)

            // Obx(() =>
            //     Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 40.sp,
            //       margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
            //       decoration: BoxDecoration(
            //           color: Color.fromRGBO(95, 207, 255, 1),
            //           borderRadius: BorderRadius.circular(50),
            //           border: Border.all(
            //               color: Color.fromRGBO(29, 123, 212, 1)
            //           )
            //       ),
            //       child: ElevatedButton(
            //         onPressed: () async {
            //           print("controller.count.value  -> ${controller.count.value}");
            //           if(controller.count.value == 0){
            //             if(controller.email.text == ''){
            //               Get.snackbar("Something is Wrong", "Please Enter EmailId",colorText: ConstantsColors.fontColor);
            //             }
            //             else{
            //               await controller.getUserList()
            //                   .then((uniqId) async => await controller.sendEmail());
            //               await controller.pagecontroller.nextPage(
            //                   duration: Duration(milliseconds: 200),
            //                   curve: Curves.easeIn
            //               ).then((value) => controller.increment());
            //             }
            //
            //           }
            //           else if(controller.count.value == 1){
            //             controller.verifyOTP()
            //                 .then((isSuccess) async =>
            //             isSuccess
            //                 ? await controller.pagecontroller.nextPage(
            //                 duration: Duration(milliseconds: 200),curve: Curves.easeIn
            //             ).then((value) => controller.increment())
            //                 : FlutterWidgets.alertmesage(title: '',message: "Please Enter Valid OTP",marginFormBottom: 20.0,fontsize: 20.0)
            //             );
            //           }
            //           else{
            //             showModalBottomSheet(
            //               context: context,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(30),
            //                       topRight: Radius.circular(30)
            //                   )
            //               ),
            //               builder: (context) {
            //                 return Container(
            //                   width: width,
            //                   height: 330.sp,
            //                   padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 20),
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(10),
            //                           topLeft: Radius.circular(10)
            //                       )
            //                   ),
            //                   child: Column(
            //                     children: [
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text("Update Successfully",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600,color: ConstantsColors.fontColor)),
            //                           Container(
            //                             height: 28,
            //                             width: 28,
            //                             child: CupertinoButton(
            //                                 color: Color.fromRGBO(249, 77, 122, 1),
            //                                 padding: EdgeInsets.zero,
            //                                 borderRadius: BorderRadius.circular(100),
            //                                 child: Icon(Icons.close,color: ConstantsColors.whitecolor),
            //                                 onPressed: (){
            //                                   Get.back();
            //                                 }
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                       SizedBox(height: 5.sp),
            //                       Divider(color: ConstantsColors.grayColor.withOpacity(0.2),thickness: 1.5),
            //                       SvgPicture.asset("assets/forgatePassword/successfully_msg.svg"),
            //                       SizedBox(height: 10.sp),
            //                       Text("Your Password Update Successfully Now You",style: TextStyle(fontSize: 17.5.sp,color: ConstantsColors.lightgrayColor,fontWeight: FontWeight.w500)),
            //                       Text("Login And Access All The Features.",style: TextStyle(fontSize: 17.5.sp,color: ConstantsColors.lightgrayColor,fontWeight: FontWeight.w500)),
            //                       Spacer(),
            //                       Container(
            //                         height: 45.sp,
            //                         width: MediaQuery.of(context).size.width,
            //                         margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
            //                         decoration: BoxDecoration(
            //                             color: Color.fromRGBO(95, 207, 255, 1),
            //                             borderRadius: BorderRadius.circular(50),
            //                             border: Border.all(
            //                                 color: Color.fromRGBO(29, 123, 212, 1)
            //                             )
            //                         ),
            //                         child: ElevatedButton(
            //                           onPressed: (){
            //                             Get.to(LoginView());
            //                           },
            //                           style: ButtonStyle(
            //                               backgroundColor: MaterialStateProperty.all( Color.fromRGBO(95, 207, 255, 1)),
            //                               padding: MaterialStateProperty.all(EdgeInsets.zero),
            //                               elevation: MaterialStateProperty.all(0),
            //                               shape: MaterialStateProperty.all(
            //                                   RoundedRectangleBorder(
            //                                       borderRadius: BorderRadius.circular(50)
            //                                   )
            //                               )
            //                           ),
            //                           child: Text("Login",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 );
            //               },
            //             );
            //           }
            //
            //         },
            //         style: ButtonStyle(
            //             backgroundColor: MaterialStateProperty.all( Color.fromRGBO(95, 207, 255, 1)),
            //             padding: MaterialStateProperty.all(EdgeInsets.zero),
            //             elevation: MaterialStateProperty.all(0),
            //             shape: MaterialStateProperty.all(
            //                 RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(50)
            //                 )
            //             )
            //         ),
            //         child: Text(controller.buttonTitles[controller.count.value],style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
            //       ),
            //     )
            // )
        )
    );
  }
}