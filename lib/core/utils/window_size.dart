import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum WindowSize {
  compact._(0, 600),

  medium._(600, 839),

  expanded._(840, 1199),

  large._(1200, 1599),

  extraLarge._(1600, double.infinity);

  final double min;

  final double max;

  bool isInRange(double width) => width >= min && width <= max;

  bool operator <(WindowSize other) => max < other.min;

  bool operator >(WindowSize other) => min > other.max;

  bool operator <=(WindowSize other) => max <= other.max;

  bool operator >=(WindowSize other) => min >= other.min;

  bool get isCompact => this == WindowSize.compact;

  bool get isMedium => this == WindowSize.medium;

  bool get isExpanded => this == WindowSize.expanded;

  bool get isLarge => this == WindowSize.large;

  bool get isExtraLarge => this == WindowSize.extraLarge;

  const WindowSize._(this.min, this.max);
}

extension WindowSizeConstrainsExtension on BoxConstraints {
  WindowSize get materialBreakpoint {
    final side = biggest.width;

    if (WindowSize.compact.isInRange(side)) {
      return WindowSize.compact;
    } else if (WindowSize.medium.isInRange(side)) {
      return WindowSize.medium;
    } else if (WindowSize.expanded.isInRange(side)) {
      return WindowSize.expanded;
    } else if (WindowSize.large.isInRange(side)) {
      return WindowSize.large;
    }

    return WindowSize.extraLarge;
  }
}
