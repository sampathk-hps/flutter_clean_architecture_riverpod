import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toDisplayDate() => DateFormat('dd MMM yyyy, hh:mm a').format(this);
}
