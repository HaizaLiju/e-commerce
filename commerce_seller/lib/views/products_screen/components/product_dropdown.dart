import 'package:commerce/const/const.dart';
import 'package:commerce/controllers/product_controller.dart';
import 'package:commerce/views/widgets/text_style.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget productDropdown(hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () =>DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(), 
        onChanged: (newValue) 
        {
          if(hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubcategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        },
      ),
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}
