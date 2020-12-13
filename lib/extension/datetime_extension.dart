





extension DateTimeExtension on DateTime {
  int get secondsSinceEpoch => (this.millisecondsSinceEpoch / 1000).floor();


}