import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glossy_tunes/desktop_view/desktop_main_screen.dart';
import 'package:glossy_tunes/mobile_view/Main_screen/mobile_main_screen.dart';
import 'package:glossy_tunes/responsive.dart';
import 'package:glossy_tunes/tablet_view/tablet_main_screen.dart';
import 'package:glossy_tunes/theme.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Color.fromARGB(0, 0, 0, 0),
));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.themeData(),
        home: MobileMainScreen()
        /* Responsive(
          desktop: DesktopMainScreen(),
          mobile: MobileMainScreen(),
          tablet: TabletMainScreen(),
        ) */);
  }
}
