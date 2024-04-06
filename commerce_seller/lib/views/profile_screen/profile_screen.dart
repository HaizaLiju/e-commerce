import 'package:commerce/const/const.dart';
import 'package:commerce/const/lists.dart';
// ignore: unused_import
import 'package:commerce/controllers/auth_controller.dart';
import 'package:commerce/controllers/home_controller.dart';
import 'package:commerce/controllers/profile_controller.dart';

import 'package:commerce/services/store_service.dart';
import 'package:commerce/theme/theme.dart';
import 'package:commerce/views/Authentication/signin_screen.dart';
import 'package:commerce/views/profile_screen/components/detail_card.dart';
import 'package:commerce/views/profile_screen/edit_profile_screen.dart';
import 'package:commerce/views/chat_screen/messaging_screen.dart';
import 'package:commerce/views/orders_screen/orders_screen.dart';

import 'package:commerce/views/widgets/bg_widget.dart';
import 'package:commerce/views/widgets/drop_down_btn.dart';
import 'package:commerce/views/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  var controller = Get.put(ProfileController());

  // ignore: prefer_typing_uninitialized_variables
  var data;

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await Get.put(AuthController()).signoutMethod(context);
      Get.offAll(() => const SignInScreen());
    }

    void edit() {
      controller.nameController.text = data['name'];

      Get.to(() => EditProFileScreen(
            data: data,
          ));
    }

// Define a map to map names to functions
    late Map<String, Function> functionMap = {
      'Log out': logOut,
      'Edit': edit,
    };
    return Container(
      child: Scaffold(
        body: StreamBuilder(
          stream: StoreService.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(darkColorScheme.primary),
                ),
              );
            } else {
              data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset("assets/icons/profile.png",
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.network(data['imageUrl'],
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['vendor_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkColorScheme.primary)
                                  .bold
                                  .make(),
                              "${data['email']}"
                                  .text
                                  .color(darkColorScheme.primary)
                                  .make(),
                            ],
                          )),
                          DropDownBtn(
                            items: const ['Edit', 'Log out'],
                            selectedItemText: 'More',
                            onSelected: (selectedValue) {
                              functionMap[selectedValue]!();
                            },
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                        future: StoreService.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else {
                            print(snapshot.data);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HomeController homeController =
                                        Get.find<HomeController>();
                                    homeController.changeTabIndex(
                                        2); // Change to the desired index
                                  },
                                  child: detailCard(
                                      count: "${snapshot.data[2]}",
                                      title: "Number Orders",
                                      width: context.screenWidth / 3.5),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const MessageScreen());
                                  },
                                  child: detailCard(
                                      count: "${snapshot.data[1]}",
                                      title: "Messages",
                                      width: context.screenWidth / 3.5),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const OrdersScreen());
                                  },
                                  child: detailCard(
                                      count: "${snapshot.data[2]}",
                                      title: "your orders",
                                      width: context.screenWidth / 3.5),
                                ),
                              ],
                            );
                          }
                        }),
                    40.heightBox,
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => const MessageScreen());
                              break;
                            // case 2:
                            //   Get.to(() => const MessageScreen());
                            //   break;
                          }
                        });
                        //   leading: Image.asset(
                        //     profileButtonIcon[index],
                        //     width: 22,
                        //   ),
                        //   title: profileButtonList[index]
                        //       .text
                        //       .fontFamily(semibold)
                        //       .color(darkFontGrey)
                        //       .make(),
                        // );
                      },
                    )
                    // .box
                    // .white
                    // .rounded
                    // .margin(const EdgeInsets.all(12))
                    // .padding(const EdgeInsets.symmetric(horizontal: 16))
                    // .shadowSm
                    // .make()
                    // .box
                    // .color(lightBlue)
                    // .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
