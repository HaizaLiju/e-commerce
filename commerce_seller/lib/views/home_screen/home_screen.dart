import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/const/const.dart';
import 'package:commerce/controllers/home_controller.dart';
import 'package:commerce/controllers/orders_controller.dart';
import 'package:commerce/controllers/product_controller.dart';
import 'package:commerce/services/store_service.dart';
import 'package:commerce/views/orders_screen/orders_screen.dart';
import 'package:commerce/views/products_screen/product_detail.dart';
import 'package:commerce/views/products_screen/product_screen.dart';
import 'package:commerce/views/widgets/appbar_widget.dart';
import 'package:commerce/views/widgets/dashboard_button.dart';
import 'package:commerce/views/widgets/loadingIndicator.dart';
import 'package:commerce/views/widgets/text_style.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreService.getProduct(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else {
            var data = snapshot.data!.docs;

            var n = data.sortedBy(
                (a, b) => b['wishlist'].length.compareTo(a['wishlist'].length));

            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: StoreService.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    dashboardButton(context,
                                            title: products,
                                            count: "${snapshot.data[0]}",
                                            icon: icProducts)
                                        .onTap(() {
                                      homeController.changeTabIndex(1);
                                    }),
                                    dashboardButton(context,
                                            title: orders,
                                            count: "${snapshot.data[2]}",
                                            icon: icOrders)
                                        .onTap(() {
                                      homeController.changeTabIndex(2);
                                    })
                                  ],
                                ),
                                10.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    dashboardButton(context,
                                        title: rating,
                                        count: "${snapshot.data[0]}",
                                        icon: icStar),
                                    dashboardButton(context,
                                        title: totalSale,
                                        count: "${snapshot.data[0]}",
                                        icon: icOrders)
                                  ],
                                )
                              ],
                            );
                          }
                        }),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['wishlist'].length == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(
                                      () => ProductDetail(data: data[index]));
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
                                subtitle: normalText(
                                    text: "\$${data[index]['price']}",
                                    color: darkGrey),
                              ),
                      ),
                    ),
                  ],
                ));
          }
        },
      ),
    );
  }
}
