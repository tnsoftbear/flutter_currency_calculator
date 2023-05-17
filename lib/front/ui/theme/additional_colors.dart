import 'package:flutter/material.dart';

@immutable
final class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    this.linenColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.linenTurbidColor = const Color.fromRGBO(255, 255, 255, 0.8),
    this.linenLucidColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.menuItemStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  });

  final Color? linenColor;
  final Color? linenTurbidColor;
  final Color? linenLucidColor;
  final TextStyle? menuItemStyle;

  @override
  AdditionalColors copyWith(
      {Color? linenColor,
      Color? linenTurbidColor,
      Color? linenLucidColor,
      TextStyle? menuItemStyle}) {
    return AdditionalColors(
      linenColor: linenColor ?? this.linenColor,
      linenTurbidColor: linenTurbidColor ?? this.linenTurbidColor,
      linenLucidColor: linenLucidColor ?? this.linenLucidColor,
      menuItemStyle: menuItemStyle ?? this.menuItemStyle,
    );
  }

  @override
  AdditionalColors lerp(AdditionalColors? other, double t) {
    if (other is! AdditionalColors) {
      return this;
    }
    return AdditionalColors(
      linenColor: Color.lerp(linenColor, other.linenColor, t),
      linenTurbidColor: Color.lerp(linenTurbidColor, other.linenTurbidColor, t),
      linenLucidColor: Color.lerp(linenLucidColor, other.linenLucidColor, t),
      menuItemStyle: TextStyle.lerp(menuItemStyle, other.menuItemStyle, t),
    );
  }

  // Optional
  @override
  String toString() =>
      'AdditionalColors(linenColor: $linenColor, ' +
      'linenTurbidColor: $linenTurbidColor, ' +
      'linenLucidColor: $linenLucidColor), ' +
      'menuItemStyle: $menuItemStyle';
}
