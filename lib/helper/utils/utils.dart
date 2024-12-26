import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';

class Utils{
  String formatDate(DateTime? parsedDate) {
    if(parsedDate==null){
      return "Unknown";
    }
    String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
    return formattedDate;
  }
  Color getRandomDarkColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(128),
      random.nextInt(128),
      random.nextInt(128),
    );
  }

}