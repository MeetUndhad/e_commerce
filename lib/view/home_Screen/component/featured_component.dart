import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/home_Screen/category/category.dart';
import 'package:emart_app/view/home_Screen/category/category_detail.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .white
      .roundedSM
      .outerShadow
      .make()
      .onTap(() {
    Get.to(() => CategoryDetail(title: title));
  });
}
