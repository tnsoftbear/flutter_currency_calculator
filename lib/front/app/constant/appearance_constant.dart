final class AppearanceConstant {
  // Language Codes
  static const String LC_DEFAULT = LC_EN;
  static const String LC_EN = 'en';
  static const String LC_RU = 'ru';

  static const Map<String, Map<String, String>> CONFIG = {
    LC_EN: {'countryCode': 'US'},
    LC_RU: {'countryCode': 'RU'},
  };

  // Font Families
  static const String FF_DEFAULT = 'Roboto';
  static const List<String> FONT_FAMILIES = [
    'Roboto',
    'Montserrat',
    'IndieFlower',
  ];

  static const String BG_IMAGE_FOR_ABOUT_SCREEN =
      'assets/images/white-tree-portrait.jpg';
  static const String BG_IMAGE_FOR_SETTING_SCREEN =
      'assets/images/riga-cloudy-sky-landscape.jpg';
  static const String BG_IMAGE_FOR_CURRENCY_CONVERSION_SCREEN =
      'assets/images/portugal-sea.jpg';
  static const String BG_IMAGE_FOR_CURRENCY_CONVERSION_ALL_HISTORY_SCREEN =
      'assets/images/cloudy-sky-portrait.jpg';
  static const String BG_IMAGE_FOR_MAIN_MENU_AVATAR = 'assets/images/rio.jpg';

  static const String THEME_BLUE = 'blue';
  static const String THEME_GREEN = 'green';
  static const String THEME_RED = 'red';
  static const String THEME_DEFAULT = THEME_BLUE;

  static const List<String> THEMES = [
    THEME_BLUE,
    THEME_GREEN,
    THEME_RED,
  ];
}
