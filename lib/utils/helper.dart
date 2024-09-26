import 'package:intl/intl.dart';

abstract class Helper {
  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat dateFormat = DateFormat('dd MMM, yyyy');
    return dateFormat.format(dateTime);
  }

  static String formatTime(String timeString) {
    DateTime time = DateTime.parse(timeString);
    DateFormat timeFormat = DateFormat.Hm();
    return timeFormat.format(time);
  }
}
