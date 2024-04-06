import 'package:commerce/const/const.dart';

Widget bgWidget({Widget? child}) {
  return Theme(
    data: ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent),
      fontFamily: regular,
    ),
    child: Container(
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage("assets/images/bg1.png"), fit: BoxFit.fill),
      ),
      child: child,
    ),
  );
}
