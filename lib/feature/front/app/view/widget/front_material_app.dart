import 'package:currency_calc/feature/front/app/route/app_router.dart';
import 'package:currency_calc/feature/front/app/view/theme/theme_builder.dart';
import 'package:currency_calc/feature/setting/app/manage/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class FrontMaterialApp extends StatefulWidget {
  const FrontMaterialApp({Key? key}) : super(key: key);

  State<FrontMaterialApp> createState() => _FrontMaterialAppState();

  // static void assignFontFamily(
  //     BuildContext context, String? newFontFamily) async {
  //   if (newFontFamily == null) {
  //     return;
  //   }
  //
  //   _FrontMaterialAppState state =
  //       context.findAncestorStateOfType<_FrontMaterialAppState>()!;
  //   state.setFontFamily(newFontFamily);
  //
  //   SettingManager.saveFontFamily(newFontFamily);
  // }
  //
  // static String getFontFamily(BuildContext context) {
  //   _FrontMaterialAppState state =
  //       context.findAncestorStateOfType<_FrontMaterialAppState>()!;
  //   return state._fontFamily;
  // }
}

class _FrontMaterialAppState extends State<FrontMaterialApp> {
  //String _fontFamily = AppearanceConstant.FF_DEFAULT;

  @override
  void initState() {
    // SettingManager.detectFontFamily()
    //     .then((fontFamily) => _fontFamily = fontFamily);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingModel = context.watch<SettingModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: ThemeBuilder.buildTheme(settingModel.themeType, settingModel.fontFamily),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settingModel.detectLocale(),
      initialRoute: AppRouter.R_DEFAULT,
      routes: AppRouter.init(),
    );
  }
}
