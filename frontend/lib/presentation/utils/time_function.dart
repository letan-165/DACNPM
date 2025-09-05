import 'package:intl/intl.dart';

String formatDuration(Duration d) {
  if (d.inSeconds == 0) return "";
  final minutes = d.inMinutes;
  final seconds = d.inSeconds % 60;
  if (minutes > 0) {
    return seconds > 0 ? "$minutes phút ${seconds}s" : "$minutes phút";
  } else {
    return "$seconds giây";
  }
}

String formatSeconds(int totalSeconds) {
  if (totalSeconds == 0) return "";
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  if (minutes > 0) {
    return seconds > 0 ? "$minutes phút ${seconds}s" : "$minutes phút";
  } else {
    return "$seconds giây";
  }
}

String formatDate(DateTime dt) {
  final local = dt.toLocal();
  return DateFormat('dd/MM/yyyy HH:mm').format(local);
}
