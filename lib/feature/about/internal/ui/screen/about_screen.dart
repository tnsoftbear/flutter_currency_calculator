import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/front/ui/theme/additional_colors.dart';
import 'package:currency_calc/front/ui/widget/front_header_bar.dart';
import 'package:currency_calc/front/ui/widget/front_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;

    return Scaffold(
      appBar: FrontHeaderBar(titleText: tr.aboutTitle),
      drawer: const FrontMainMenu(),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image:
                const AssetImage(AppearanceConstant.BG_IMAGE_FOR_ABOUT_SCREEN),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: additionalColors.linenTurbidColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              tr.aboutContent,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
