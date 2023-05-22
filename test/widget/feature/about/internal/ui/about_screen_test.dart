import 'package:currency_calc/feature/about/internal/ui/screen/about_screen.dart';
import 'package:currency_calc/front/ui/theme/theme_builder.dart';
import 'package:currency_calc/front/ui/widget/front_header_bar.dart';
import 'package:currency_calc/front/ui/widget/front_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AboutScreen should display correct content',
      (WidgetTester tester) async {
    // Set up the test
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeBuilder.buildTheme(),
        home: AboutScreen(),
      ),
    );

    // Verify the content
    final tr = AppLocalizations.of(tester.element(find.byType(Scaffold)));

    final frontHeaderBarFinder = find.byType(FrontHeaderBar);
    expect(frontHeaderBarFinder, findsOneWidget, reason: "Expect 1 header bar");
    expect(tester.widget<FrontHeaderBar>(frontHeaderBarFinder).titleText,
        tr.aboutTitle);

    final aboutContentText =
        tester.widget<Text>(find.byKey(Key('wid_about_content')));
    expect(aboutContentText.style?.fontSize, 20, reason: "Expect font size 20");
    expect(aboutContentText.data, tr.aboutContent,
        reason: "Expect correct content");

    /**
     * We have to open drawer to find FrontMainMenu widget.
     */
    final ScaffoldState scaffoldState =
        tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();
    expect(find.byType(FrontMainMenu), findsOneWidget);
  });
}
