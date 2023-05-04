import 'package:currency_calc/feature/setting/app/view/screen/setting_screen.dart';
import 'package:flutter/material.dart';

class FrontHeaderBar extends AppBar {
  FrontHeaderBar({required this.titleText, bool this.isSettingMenu = true, this.bottom});

  final String titleText;
  final bool isSettingMenu;
  final PreferredSizeWidget? bottom;

  @override
  _HeaderBarState createState() => _HeaderBarState();
}

class _HeaderBarState extends State<FrontHeaderBar> {
  @override
  Widget build(BuildContext context) {
    final actions = widget.isSettingMenu
        ? <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen())),
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
