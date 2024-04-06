import 'package:commerce/views/Authentication/signin_screen.dart';
import 'package:commerce/views/Authentication/signup_screen.dart';
// import 'package:commerce/views/cart_screen/cart_screen.dart';
// import 'package:commerce/views/category_screen/category_screen.dart';
import 'package:commerce/views/home_screen/home.dart';
import 'package:commerce/views/welcome_screen.dart';
// import 'package:commerce/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/sign-in', page: () => SignInScreen()),
    GetPage(name: '/sign-up', page: () => SignUpScreen()),
    GetPage(name: '/welcome', page: () => WelcomeScreen()),
    // GetPage(name: '/cart', page: () => CartScreen()),
    // GetPage(name: '/profile', page: () => ProfileScreen()),
  ];
}
