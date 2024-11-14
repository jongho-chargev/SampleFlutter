import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//기본 예제
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

// extension DoubleExtension on double {
//   SizedBox height() {
//     return SizedBox(
//       height: this,
//     );
//   }

//   SizedBox width() {
//     return SizedBox(
//       width: this,
//     );
//   }
// }

// extension IntExtension on int? {
// SizedBox width() {
//   return SizedBox(
//     width: toDouble(),
//   );
// }

// Widget width() => SizedBox(width: this?.toDouble());
// Widget height() => SizedBox(height: this?.toDouble());
// }

var logger = Logger(
  printer: PrettyPrinter(
      stackTraceBeginIndex: 1, methodCount: 3, noBoxingByDefault: true),
);

extension StringExtension on String {
  void get printlog {
    logger.e(this);
  }

  String get log {
    logger.e(this);
    return this;
  }
}

extension WidgetEvExtension on Widget? {
  Widget padding({
    double? all,
    double? vertical,
    double? horizontal,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: all ?? vertical ?? 0, horizontal: all ?? horizontal ?? 0),
      child: this,
    );
  }
}
