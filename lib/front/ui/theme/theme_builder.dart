import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/front/ui/theme/additional_colors.dart';
import 'package:flutter/material.dart';

final class ThemeBuilder {
  static ThemeData buildTheme([String? themeType, String? fontFamily]) {
    fontFamily ??= AppearanceConstant.FF_DEFAULT;
    final appBarTitleTextStyle = TextStyle(
      fontSize: 26,
      color: Colors.white,
      fontFamily: fontFamily,
    );
    if (themeType == AppearanceConstant.THEME_GREEN) {
      return ThemeData(
        fontFamily: fontFamily,
        primaryColor: Colors.green[300],
        scaffoldBackgroundColor: Colors.green[300],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.green[300],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[300],
          titleTextStyle: appBarTitleTextStyle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
          style: ListTileStyle.drawer,
        ),
        extensions: <ThemeExtension<dynamic>>[
          const AdditionalColors(
            linenColor: const Color.fromRGBO(239, 255, 239, 0.5),
            linenTurbidColor: const Color.fromRGBO(239, 255, 239, 0.8),
            linenLucidColor: const Color.fromRGBO(239, 255, 239, 0.1),
          ),
        ],
      );
    }

    if (themeType == AppearanceConstant.THEME_RED) {
      return ThemeData(
        fontFamily: fontFamily,
        primaryColor: Colors.red[300],
        scaffoldBackgroundColor: Colors.red[300],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.red[300],
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.red[300],
            titleTextStyle: appBarTitleTextStyle),
        iconTheme: const IconThemeData(color: Colors.white),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          style: ListTileStyle.drawer,
        ),
        extensions: <ThemeExtension<dynamic>>[
          const AdditionalColors(
            linenColor: const Color.fromRGBO(255, 239, 239, 0.5),
            linenTurbidColor: const Color.fromRGBO(255, 239, 239, 0.8),
            linenLucidColor: const Color.fromRGBO(255, 239, 239, 0.1),
          ),
        ],
      );
    }

    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: Colors.blue[300],
      scaffoldBackgroundColor: Colors.blue[300],
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.blue[300],
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[300],
          titleTextStyle: appBarTitleTextStyle),
      iconTheme: const IconThemeData(color: Colors.white),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
        style: ListTileStyle.drawer,
      ),
      extensions: <ThemeExtension<dynamic>>[
        const AdditionalColors(
          linenColor: const Color.fromRGBO(239, 239, 255, 0.5),
          linenTurbidColor: const Color.fromRGBO(239, 239, 255, 0.8),
          linenLucidColor: const Color.fromRGBO(239, 239, 255, 0.1),
        ),
      ],
    );
  }
}
