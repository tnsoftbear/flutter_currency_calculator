import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class StandardErrorLabel extends StatefulWidget {
  final String errorText;

  const StandardErrorLabel(this.errorText, {Key? key}) : super(key: key);

  @override
  State<StandardErrorLabel> createState() => _StandardErrorLabelState();
}

final class _StandardErrorLabelState extends State<StandardErrorLabel> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(tr.generalError(widget.errorText)),
          ),
        ]));
  }
}
