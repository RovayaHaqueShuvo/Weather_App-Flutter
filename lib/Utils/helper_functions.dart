import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

String getIconUrl(String icon) => '$iconPrefixName$icon$iconUrlSuffixx';
// String getFormattedDateTime(num dt, {String pattern = 'MMM dd, hh:mm a'}) {
//   return DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000, isUtc: true).toLocal());
// }

String getFormattedDateTime(num dt, {String pattern = 'MMM dd, hh:mm a'}) {
  // Convert the Unix timestamp to DateTime, adjust for local time, and format it
  return DateFormat(pattern)
      .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000, isUtc: false).toLocal());
}

String getLocalTime(DateTime localTime ){
 final formattedLocalTime = DateFormat('hh:mm:ss a').format(localTime);
  return formattedLocalTime;
}
