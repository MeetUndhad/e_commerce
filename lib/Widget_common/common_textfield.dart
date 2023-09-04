import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';

Widget customTextField(
    {String? title,
    String? hint,
    controller,
    bool? isPass,
    keyboardType,
    int? inputFormatter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.size(12).fontFamily(semibold).color(redColor).make(),
      10.heightBox,
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "required this field";
          }
        },
        obscureText: isPass!,
        keyboardType: keyboardType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputFormatter),
        ],
        controller: controller,
        decoration: InputDecoration(
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            filled: true,
            border: InputBorder.none,
            fillColor: lightGrey,
            isDense: true,
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      10.heightBox,
    ],
  );
}
