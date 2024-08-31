import 'package:intl/intl.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

String getIconUrl(String icon) => '$iconPrefixName$icon$iconUrlSuffixx';
String getFormattedDateTime(num dt, {String pattern = 'MMM dd, hh:mm a'}) {
  return DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000));
}