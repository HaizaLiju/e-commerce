import 'package:commerce/const/colors.dart';
import 'package:commerce/const/styles.dart';
import 'package:flutter/material.dart';

class CustomTheme extends StatelessWidget {
  final Widget child;

  const CustomTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      child: child,
    );
  }
}
