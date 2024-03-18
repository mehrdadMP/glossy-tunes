import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glossy_tunes/desktop_view/desktop_main_screen.dart';
import 'package:glossy_tunes/mobile_screen.dart';
import 'package:glossy_tunes/mobile_view/Main%20screen/mobile_main_screen.dart';
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
    //When you use mobile_screen.dart library, if you want to set your widget
    //sizes by [MediaQuery.of(context).size] then to use mobile phone's
    //screen's size as the context size, use the currect size from [ScreenSize].
    final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData(),
      home: Scaffold(
        body: Responsive(
          mobile: MobileMainScreen(screenSize: screenSize),

          // ),
          tablet: TabletMainScreen(),
          desktop: DesktopMainScreen(),
        ),
      ),
    );
  }
}
