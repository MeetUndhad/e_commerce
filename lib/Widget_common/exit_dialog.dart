import 'package:emart_app/Widget_common/commonButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want exit?".text.size(12).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            commonButton(
                title: "Yes",
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                color: redColor),
            commonButton(
                title: "No",
                onPress: () {
                  Get.back();
                },
                textColor: whiteColor,
                color: redColor),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
