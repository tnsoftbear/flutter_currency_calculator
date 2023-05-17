import 'package:currency_calc/front/app/route/app_router.dart';
import 'package:currency_calc/front/ui/theme/theme_builder.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

final class FrontMaterialApp extends StatelessWidget {
  const FrontMaterialApp({Key? key}) : super(key: key);

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
