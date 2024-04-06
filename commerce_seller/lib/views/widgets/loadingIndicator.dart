import 'package:commerce/const/const.dart';

Widget loadingIndicator({circleColor = purpleColor}) {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(circleColor),
  );
}