import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glossy_tunes/desktop_view/desktop_main_screen.dart';
import 'package:glossy_tunes/mobile_screen.dart';
import 'package:glossy_tunes/mobile_view/mobile_main_screen.dart';
import 'package:glossy_tunes/responsive.dart';
import 'package:glossy_tunes/tablet_view/tablet_main_screen.dart';
import 'package:glossy_tunes/rrect_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHight = MediaQuery.of(context).size.height;
    debugPrint('$screenWidth');
    debugPrint('$screenHight');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Responsive(
          mobile: MobileMainScreen(),
          tablet: TabletMainScreen(),
          desktop: DesktopMainScreen()),
    );
  }
}
