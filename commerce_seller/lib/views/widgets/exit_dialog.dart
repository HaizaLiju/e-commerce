import 'package:commerce/const/const.dart';
import 'package:commerce/views/widgets/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(Colors.grey).make(),
        const Divider(),

        10.heightBox,
        "Are you sure to exit?".text.size(18).color(Colors.grey).make(),

        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              color: Colors.blue,
              onPress: (){
                SystemNavigator.pop();
              },
              title: "Yes"
            ),
            ourButton(
              color: Colors.blue,
              onPress: (){
                Navigator.pop(context);
              },
              title: "No"
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}