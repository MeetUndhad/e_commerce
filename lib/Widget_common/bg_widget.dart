import 'package:emart_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Material(
    child: Container(
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
      ),
      child: child,
    ),
  );
}
