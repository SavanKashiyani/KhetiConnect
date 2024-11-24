import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kheticonnect/util/app_const.dart';

// const String dateTimeFormatPattern = 'dd/MM/yyyy';
// const String displayDateFormat = 'MM/dd/yyyy';

extension DateTimeExtension on DateTime {
  String format({
    String pattern = AppConst.dateDisplayFormat,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

//extention for change timezone of given date MM/dd/yyyy string local to utc

extension StringExtension on String {
  String fromLocalToUtc() {
    final inputDate = DateFormat(AppConst.dateDisplayFormat).parse(this).toLocal();
    // final utcDate = inputDate.toUtc();
    final outputFormat = DateFormat(AppConst.serverUTCFormat);
    return outputFormat.format(inputDate);
  }

  String fromLocalToUtcWithTime(String time) {
    final inputDate = DateFormat('${AppConst.dateDisplayFormat} hh:mm a').parse('$this $time').toLocal();
    final utcDate = inputDate.toUtc();
    final outputFormat = DateFormat(AppConst.serverUTCFormat);
    return outputFormat.format(utcDate);
  }
}

Map<Duration, String> getDayTimeSlots({
  required Duration startTime,
  required Duration endTime,
  required Duration slotDuration,
}) {
  var timeSlots = <Duration, String>{};
  var currentTime = startTime;

  while (currentTime <= endTime) {
    final hour = currentTime.inHours % 24;
    final minute = currentTime.inMinutes % 60;

    final dateTime = DateTime(2024, 1, 1, hour, minute);
    final formattedTime = dateTime.format(pattern: "hh:mm a");
    timeSlots[currentTime] = formattedTime;
    currentTime += slotDuration;
  }
  return timeSlots;
}
