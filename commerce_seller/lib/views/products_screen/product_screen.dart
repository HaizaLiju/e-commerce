import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/const/const.dart';
import 'package:commerce/controllers/product_controller.dart';
import 'package:commerce/services/store_service.dart';
import 'package:commerce/views/products_screen/add_product.dart';
import 'package:commerce/views/products_screen/product_detail.dart';
import 'package:commerce/views/widgets/appbar_widget.dart';
import 'package:commerce/views/widgets/loadingIndicator.dart';
import 'package:commerce/views/widgets/text_style.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddProduct());
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
        stream: StoreService.getProduct(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetail(
                                        data: data[index],
                                      ));
                                },
                                leading: Image.network(
                                  data[index]['imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['name']}",
                                    color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    normalText(
                                        text: "\$${data[index]['price']}",
                                        color: darkGrey),
                                    10.widthBox,
                                    boldText(
                                        text: data[index]['is_featured'] == true
                                            ? "Featured"
                                            : '',
                                        color: green),
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                          children: List.generate(
                                            popupMenuTitles.length,
                                            (i) => Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    popupMenuIcons[i],
                                                    color:
                                                        data[index]['featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? green
                                                            : darkGrey,
                                                  ),
                                                  10.widthBox,
                                                  normalText(
                                                      text: popupMenuTitles[i],
                                                      color: darkGrey)
                                                ],
                                              ).onTap(() {
                                                if (popupMenuTitles[i] ==
                                                    ("Featured")) {
                                                  if (controller.isFea.value) {
                                                    controller
                                                        .removeFromFeatured(
                                                            data[index].id,
                                                            context);
                                                    controller.isFea(false);
                                                  } else {
                                                    controller.addToFeatured(
                                                        data[index].id,
                                                        context);
                                                    controller.isFea(true);
                                                  }
                                                } else if (popupMenuTitles[i] ==
                                                    ("Remove")) {
                                                  controller.removeProduct(
                                                      data[index].id, context);
                                                }

                                                print(popupMenuTitles[i]);
                                              }),
                                            ),
                                          ),
                                        ).box.white.rounded.width(200).make(),
                                    clickType: VxClickType.singleClick,
                                    child: const Icon(Icons.more_vert_rounded)),
                              ),
                            )),
                  ),
                ));
          }
        },
      ),
    );
  }
}
