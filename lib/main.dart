import 'package:currency_calc/front/app/boot/bootstrapper.dart';
import 'package:flutter/material.dart';

void main() async {
  final app = await Bootstrapper.setup();
  runApp(app);
}
