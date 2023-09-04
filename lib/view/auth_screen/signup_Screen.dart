import 'dart:developer';

import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Widget_common/commonButton.dart';
import '../../Widget_common/common_textfield.dart';
import '../home_Screen/bottom_nav_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  final controller = Get.find<AuthController>();

  final nameController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final retypePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the $appname".text.white.size(22).fontFamily(bold).make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: nameHint,
                          title: name,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          hint: emailHint,
                          title: email,
                          controller: emailController,
                          isPass: false,
                          keyboardType: TextInputType.emailAddress),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passController,
                          isPass: true),
                      customTextField(
                          title: retypePassword,
                          hint: passwordHint,
                          controller: retypePassController,
                          isPass: true),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //       onPressed: () {}, child: forgetPass.text.make()),
                      // ),
                      // 5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.green,
                            checkColor: redColor,
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                      color: fontGrey, fontFamily: regular)),
                              TextSpan(
                                  text: termAndCondition,
                                  style: TextStyle(
                                      color: redColor, fontFamily: regular)),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                      color: redColor, fontFamily: regular)),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                      color: redColor, fontFamily: regular)),
                            ])),
                          )
                        ],
                      ),
                      10.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : commonButton(
                                  title: signup,
                                  color:
                                      isChecked == true ? redColor : lightGrey,
                                  onPress: () async {
                                    FocusScope.of(context).unfocus();

                                    if (isChecked != false) {
                                      controller.isLoading(true);

                                      try {
                                        await controller
                                            .signupMethod(
                                                context: context,
                                                password: passController.text,
                                                email: emailController.text)
                                            .then((value) {
                                          log('======USERID${currentUser!.uid}');
                                          controller.storeUserData(
                                              name: nameController.text,
                                              password: passController.text,
                                              email: emailController.text);
                                        }).then((value) {
                                          VxToast.show(context, msg: loggedIn);
                                          return Get.offAll(BottomNavScreen());
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                        controller.isLoading(false);
                                      }
                                    }
                                  },
                                  textColor: whiteColor)
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                      10.heightBox,
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "Already Have An Account? ",
                            style:
                                TextStyle(fontFamily: bold, color: fontGrey)),
                        TextSpan(
                            text: "Log In",
                            style: TextStyle(fontFamily: bold, color: redColor))
                      ])).onTap(() {
                        Get.back();
                      })
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .shadowSm
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
