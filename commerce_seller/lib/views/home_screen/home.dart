import 'package:commerce/const/const.dart';
import 'package:commerce/controllers/home_controller.dart';
import 'package:commerce/views/home_screen/home_screen.dart';
import 'package:commerce/views/orders_screen/orders_screen.dart';
import 'package:commerce/views/products_screen/product_screen.dart';

import 'package:commerce/views/profile_screen/profile_screen.dart';
import 'package:commerce/views/widgets/exit_dialog.dart';
// ignore: unused_import
import 'package:commerce/views/widgets/text_style.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
       ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneral,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];
 return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
      },
    child :Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottomNavbar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    ),);
  }
}
