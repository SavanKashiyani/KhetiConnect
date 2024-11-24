import 'package:intl/intl.dart';

class DateTimeService {
  DateTime getDateFromString(
          {required String dateString, required String format}) =>
      DateFormat(format).parse(dateString);

  String getStingFromDate({required DateTime date, required String pattern}) =>
      DateFormat(pattern).format(date);

  DateTime getDateFromMillis({required int millis}) =>
      DateTime.fromMillisecondsSinceEpoch(millis);

  String formatDateStringToUTC({required String dateString,
    required String inputPattern,
    required String outputPattern}) {
    if (outputPattern.isEmpty) {
      outputPattern = inputPattern;
    }
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(dateString).toUtc());
  }

  String formatDateStringToLocal({required String dateString,
    required String inputPattern,
    required String? outputPattern}) {
    if (outputPattern == null || outputPattern.isEmpty) {
      outputPattern = inputPattern;
    }
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(dateString).toLocal());
  }

  String changeDateFormat(
      {required String? outputPattern, required DateTime dateString}) {
    return DateFormat(outputPattern ?? 'dd MMM, yyyy').format(dateString);
  }

  String changeDateStringFormat({required String dateString,
    required String inputPattern,
    required String outputPattern}) =>
      DateFormat(outputPattern)
          .format(DateFormat(inputPattern).parse(dateString));

  String dateStartEndTime(DateTime? date, String? startTime, String? endTime) {
    return '${changeDateFormat(
      outputPattern: 'dd MMM, yyyy',
      dateString: date ?? DateTime.now(),
    )} - ${startTime ?? '00:00'}-${endTime ?? '00:00'}';
  }

  //create a method to check given date  is today or not
  bool isToday(DateTime? date) {
    final now = DateTime.now();
    return now.day == date?.day &&
        now.month == date?.month &&
        now.year == date?.year;
  }

  String timeAgoString(int millis, {bool numericDates = true}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

