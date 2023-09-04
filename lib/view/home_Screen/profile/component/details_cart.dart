import 'package:emart_app/consts/consts.dart';

Widget detailsCart({width, int? number, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      number!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).size(12).make(),
    ],
  )
      .box
      .width(width)
      .height(85)
      .rounded
      .white
      .padding(const EdgeInsets.all(4))
      .make();
}
