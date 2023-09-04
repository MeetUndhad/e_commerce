import 'package:emart_app/consts/consts.dart';

typedef OnPress = void Function();

Widget commonButton({color, textColor, String? title, OnPress? onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      onPressed: onPress,
      child: title!.text.fontFamily(bold).color(textColor).make());
}
