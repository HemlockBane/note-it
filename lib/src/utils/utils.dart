  import 'package:date_format/date_format.dart';

String beautifyDate(String rawDate) {
    return formatDate(DateTime.parse(rawDate), [d, ' ', M, ' ', yyyy]);
  }


  String beautifyTime(String rawDate) {
    return formatDate(DateTime.parse(rawDate), [HH, ':', nn,]);
  }
