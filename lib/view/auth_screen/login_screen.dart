import 'dart:developer';

import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/view/auth_screen/signup_Screen.dart';
import 'package:emart_app/view/home_Screen/bottom_nav_screen.dart';
import 'package:get/get.dart';

import '../../Widget_common/commonButton.dart';
import '../../Widget_common/common_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();
  var passController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              5.heightBox,
              "Log In To $appname".text.white.size(22).fontFamily(bold).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    10.heightBox,
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: controller.emailController,
                        isPass: false),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        controller: controller.passController,
                        isPass: true),
                    10.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : commonButton(
                                title: login,
                                color: redColor.withOpacity(0.90),
                                onPress: () async {
                                  FocusScope.of(context).unfocus();
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedIn);
                                      return Get.offAll(
                                          () => BottomNavScreen());
                                    } else {
                                      log("====>log fail");
                                      controller.isLoading(false);
                                    }
                                  });
                                },
                                textColor: whiteColor)
                            .box
                            .width(context.screenWidth - 70)
                            .make(),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //       onPressed: () {},
                    //       child: forgetPass.text.size(5).make()),
                    // ),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //         child: Divider(
                    //       thickness: 1,
                    //       color: fontGrey,
                    //     )),
                    //     loginwith.text
                    //         .color(fontGrey)
                    //         .size(5)
                    //         .make()
                    //         .paddingSymmetric(horizontal: 5),
                    //     const Expanded(
                    //         child: Divider(
                    //       thickness: 1,
                    //       color: fontGrey,
                    //     )),
                    //   ],
                    // ),
                    // 7.heightBox,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //       3,
                    //       (index) => Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: CircleAvatar(
                    //               backgroundColor: lightGrey,
                    //               radius: 30,
                    //               child: Image.asset(
                    //                 socialIconList[index],
                    //                 width: 30,
                    //               ),
                    //             ),
                    //           )),
                    // ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createNewAccount.text.color(fontGrey).size(5).make(),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: "SignUp".text.size(5).make(),
                        )
                      ],
                    ),
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
    ));
  }
}
