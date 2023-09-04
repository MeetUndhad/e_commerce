import 'package:emart_app/consts/consts.dart';

Widget OrderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).fontFamily(semibold).make(),
          showDone
              ? Icon(
                  Icons.done,
                  color: redColor,
                ).box.rounded.make()
              : Container(),
        ],
      ),
    ),
  );
}
