import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class MaterialSpacer extends StatelessWidget {
  const MaterialSpacer({super.key, this.spacing = 24});

  final double spacing;

  @override
  Widget build(BuildContext context) => SizedBox(width: spacing);
}

class HorizontalSpacing extends EdgeInsets {
  const HorizontalSpacing._(final double value)
      : super.symmetric(horizontal: value);

  const HorizontalSpacing.compact() : this._(16);

  const HorizontalSpacing.mediumUp() : this._(24);

  factory HorizontalSpacing.centered(
    double windowWidth, [
    double maxWidth = 768,
  ]) =>
      HorizontalSpacing._(math.max((windowWidth - maxWidth) / 2, 16));
}
