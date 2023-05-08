import 'package:currency_calc/feature/front/app/route/app_router.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/ui/theme/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FrontMainMenu extends StatelessWidget {
  const FrontMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;

    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                height: 100,
                child: const CircleAvatar(
                    backgroundImage: const AssetImage(
                        AppearanceConstant.BG_IMAGE_FOR_MAIN_MENU_AVATAR)),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                size: 20,
              ),
              title: Text(
                tr.aboutTitle,
                style: additionalColors.menuItemStyle,
              ),
              onTap: () {
                Navigator.pop(context); // To close the Drawer
                Navigator.pushNamed(context, AppRouter.R_ABOUT);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calculate,
                size: 20,
              ),
              title: Text(
                tr.conversionTitle,
                style: additionalColors.menuItemStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.R_CALCULATE);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                size: 20,
              ),
              title: Text(
                tr.conversionHistoryTitle,
                style: additionalColors.menuItemStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.R_HISTORY);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 20,
              ),
              title: Text(
                tr.settingTitle,
                style: additionalColors.menuItemStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.R_SETTING);
              },
            ),
          ],
        ),
      ),
    );
  }
}
