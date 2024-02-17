import 'package:flutter/material.dart';
import 'package:glossy_tunes/desktop_view/desktop_main_screen.dart';
import 'package:glossy_tunes/mobile_view/mobile_main_screen.dart';
import 'package:glossy_tunes/responsive.dart';
import 'package:glossy_tunes/tablet_view/tablet_main_screen.dart';
import 'package:glossy_tunes/wave_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: /* SliderTheme(
          data: SliderThemeData(trackShape: RectangularSliderTrackShape()),
          child: Slider(value: 1, onChanged: (value) {
            
          },),
        ), */
      WaveSlider(
          sliderWidth: MediaQuery.of(context).size.width,
          sliderHight: MediaQuery.of(context).size.height), ),
     
      /* home: Responsive(
          mobile: MobileMainScreen(),
          tablet: TabletMainScreen(),
          desktop: DesktopMainScreen()), */
    );
  }
}
