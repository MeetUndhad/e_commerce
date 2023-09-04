import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/home_Screen/profile/account.dart';
import 'package:get/get.dart';

import '../../../Widget_common/bg_widget.dart';
import '../../../Widget_common/commonButton.dart';
import '../../../Widget_common/common_textfield.dart';
import '../../../controller/profile_controller.dart';

class EditScreen extends StatelessWidget {
  final dynamic data;
  EditScreen({Key? key, this.data}) : super(key: key);
  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //if data and controller is empty
                data['imageUrl'] == '' && controller.profileImg.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        fit: BoxFit.fill,
                        width: 115,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    :
                    //if data is not empty but controller is empty
                    data['imageUrl'] != '' && controller.profileImg.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            fit: BoxFit.cover,
                            width: 115,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImg.value),
                            fit: BoxFit.cover,
                            width: 115,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),

                commonButton(
                  color: redColor,
                  title: "Edit",
                  textColor: whiteColor,
                  onPress: () {
                    FocusScope.of(context).unfocus();

                    controller.changeImage(context);
                  },
                ),
                const Divider(),
                10.heightBox,
                customTextField(
                    title: nameHint,
                    isPass: false,
                    hint: name,
                    controller: controller.nameController),
                customTextField(
                    title: oldPass,
                    isPass: true,
                    hint: passwordHint,
                    controller: controller.oldpassController),
                customTextField(
                    title: newPass,
                    isPass: true,
                    hint: passwordHint,
                    controller: controller.newpassController),
                const Divider(),
                controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ))
                    : SizedBox(
                        width: context.screenWidth - 40,
                        child: commonButton(
                          color: redColor,
                          title: "Save",
                          textColor: whiteColor,
                          onPress: () async {
                            FocusScope.of(context).unfocus();
                            controller.isLoading(true);

                            //if image is not selected
                            if (controller.profileImg.value.isNotEmpty) {
                              await controller.uploadImage();
                            } else {
                              controller.profileImgLink = data['imageUrl'];
                            }

                            //if old pass match with data base
                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPass(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newPassword:
                                      controller.newpassController.text);

                              await controller.updateProfile(
                                  imgUrl: controller.profileImgLink,
                                  password: controller.newpassController.text,
                                  name: controller.nameController.text);
                              VxToast.show(context, msg: "Profile Updated");
                              Get.offAll(() => AccountScreen());
                            } else {
                              VxToast.show(context, msg: "Wrong Old password");
                              controller.isLoading(false);
                            }
                          },
                        ),
                      ),
              ],
            )
                .box
                .shadowSm
                .white
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    ));
  }
}
