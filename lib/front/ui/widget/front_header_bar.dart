import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final class FrontHeaderBar extends AppBar {
  final String titleText;
  final bool isSettingMenu;
  final PreferredSizeWidget? bottom;

  FrontHeaderBar(
      {required this.titleText, bool this.isSettingMenu = true, this.bottom});

  @override
  _HeaderBarState createState() => _HeaderBarState();
}

final class _HeaderBarState extends State<FrontHeaderBar> {
  @override
  Widget build(BuildContext context) {
    final actions = widget.isSettingMenu
        ? <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => context
                          .read<SettingFeatureFacade>()
                          .createSettingScreen())),
            )
          ]
        : <Widget>[];

    return AppBar(
      title: Text(widget.titleText),
      actions: actions,
      bottom: widget.bottom,
    );
  }
}
