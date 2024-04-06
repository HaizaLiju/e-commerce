import 'package:commerce/const/const.dart';
import 'package:commerce/views/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress, 
    child: normalText(text: title, size: 16.0)
  );
}