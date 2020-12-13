
import 'dart:math';

import 'package:flutter_cresenity/extension/datetime_extension.dart';


mixin InteractsWithTime {

  int secondUntil(delay) {
    delay = parseDateInterval(delay);
    return delay is DateTime ? max(0, delay.secondsSinceEpoch- currentTime())
        : delay;
  }


  /// Get the "available at" UNIX timestamp.
  ///
  /// @param  \DateTime|Duration|int  $delay
  /// @return int
  int availableAt([delay = 0]) {
    delay = parseDateInterval(delay);

    return delay is DateTime ? delay.secondsSinceEpoch : DateTime.now().add(Duration(seconds: delay)).secondsSinceEpoch;
  }

  /// If the given value is an interval, convert it to a DateTime instance.
  ///
  /// @param  DateTime|Duration|int  delay
  /// @return DateTime|int
  dynamic parseDateInterval(delay)  {

    if (delay is Duration) {
      delay = DateTime.now().add(delay);
    }

    return delay;
  }

  int currentTime() {
    return DateTime.now().secondsSinceEpoch;
  }
}