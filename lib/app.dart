import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_storyview/routes/pages.dart';
import 'package:flutter_storyview/routes/routes.dart';
import 'package:get/get.dart';

import 'core/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Story Viewer',
      theme: appTheme,
      supportedLocales: const [
        Locale('tr', ''),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.chooseAccount,
      //initialBinding: InitialBindings(),
      getPages: appPages,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
