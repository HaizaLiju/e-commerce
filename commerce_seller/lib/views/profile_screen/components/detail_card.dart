import 'package:commerce/const/const.dart';
import 'package:commerce/theme/theme.dart';
import 'package:flutter/material.dart';

Widget detailCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).white.size(16).make(),
      5.heightBox,
      title!.text.white.make(),
    ],
  )
      .box
      .color(darkColorScheme.secondary)
      .rounded
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
