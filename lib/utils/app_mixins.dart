import 'package:intl/intl.dart';

mixin class AppMixins {
  String getDateFormate(DateTime date, String formate) {
    DateFormat dateFormat = DateFormat(formate);
    var result = dateFormat.format(date);
    return result;
  }

  DateTime getUTCDateformat(String date, String formate) {
    String dateString = date;
    DateFormat format = DateFormat(formate);
    DateTime dateTime = format.parse(dateString);

    return dateTime;
  }

  String convertUtcToFormatDate(
    String date,
    String existingFormat,
    String newFormat,
  ) {
    DateTime _date = getUTCDateformat(date, existingFormat);
    var result = getDateFormate(_date, newFormat);

    return result;
  }

  DateTime? parseFlexibleDate(String dateStr) {
    try {
      // Try ISO 8601
      return DateTime.parse(dateStr);
    } catch (_) {
      try {
        // Try DD-MM-YYYY
        return DateFormat("dd-MM-yyyy").parse(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  String getTimeFromString(String time, String format) {
    // String timeString = "08:00 PM";'HH:mm'
    DateTime parsedTime = DateFormat.jm().parse(time);
    String formattedTime = DateFormat(format).format(parsedTime);

    return formattedTime;
  }

  String capitalizeString(String? input) {
    if (input == null || input.isEmpty) {
      return input!;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  double checkValueDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value.toString().isEmpty) {
      return 0.0;
    } else if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }

  int checkValueInteger(dynamic value) {
    if (value == null) {
      return 0;
    } else if (value.toString().isEmpty) {
      return 0;
    } else if (value is String) {
      return int.parse(value);
    } else if (value is double) {
      return value.toInt();
    } else {
      return value;
    }
  }
}
