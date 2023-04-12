import 'package:date_format/date_format.dart';

String getDateInString(DateTime time) {
  String timeFormat = formatDate(time, [DD, ', ', d, ' ', MM, ', ', yyyy]);
  return timeFormat;
}

String getDateInStringWithSeconds(DateTime time) {
  String timeFormat = formatDate(
      time, [DD, ', ', d, ' ', MM, ', ', yyyy, ', ', hh, ':', mm, ':', ss]);
  return timeFormat;
}

String getDateInStringWithTime(DateTime time) {
  String timeFormat = "${time.hour} : ${time.minute}";
  return timeFormat;
}
