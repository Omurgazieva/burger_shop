import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String dateTimeFormater(String dateTime) {
    var date = DateTime.parse(dateTime);
    DateFormat dateTimeFormatter = DateFormat('dd.MM.yyyy');

    return dateTimeFormatter.format(date);
  }

  static String dateTimeToString(DateTime dateTime) {
    DateFormat dateTimeFormatter = DateFormat('dd.MM.yyyy');

    return dateTimeFormatter.format(dateTime);
  }

  static String timestampToString(Timestamp date) {
    var _formatter = DateFormat("dd.MM.yyyy").add_Hm();
    var _formattedDate = _formatter.format(date.toDate());
    return _formattedDate;
  }

  Timestamp intToTimestamp(int timestamp) {
    return Timestamp.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  bool isNew(String createdDate) {
    var now = DateTime.now();
    var date = DateTime.parse(createdDate);
    var diff = now.difference(date);

    if (diff.inDays != 0) {
      return true;
    } else {
      return false;
    }
  }
}
