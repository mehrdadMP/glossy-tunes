import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XiaomiNote9S extends StatelessWidget {
  final Widget home;
  final bool debugShowCheckedModeBanner;
  final bool enableStatusBar;

  XiaomiNote9S({
    super.key,
    required this.home,
    required this.debugShowCheckedModeBanner,
    required this.enableStatusBar,
  }) {
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 392.72727272727275,
        height: 872.7272727272727,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 35,
                spreadRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          enableStatusBar
              ? const Stack(
                  alignment: Alignment.center,
                  children: [
                    _StatusBar(),
                    _PhoneFrontCamera(),
                    _StatusBarShadow(),
                  ],
                )
              : Container(),
          _Home(
            home: home,
            enableStatusBar: enableStatusBar,
          ),
        ]),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  final bool enableStatusBar;
  const _Home({
    required this.home,
    required this.enableStatusBar,
  });

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: enableStatusBar
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: enableStatusBar
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))
              : BorderRadius.circular(30),
          child: MaterialApp(
              debugShowCheckedModeBanner: debugDisableShadows, home: home),
        ),
      ),
    );
  }
}

class _StatusBarShadow extends StatelessWidget {
  const _StatusBarShadow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          height: 35,
          decoration: const BoxDecoration(
              color: Color.fromARGB(52, 0, 0, 0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        ));
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '2:27 PM | 1.8KB/s',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.wifi,
                size: 21,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                CupertinoIcons.chart_bar_fill,
                color: Color.fromARGB(155, 24, 20, 20),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(CupertinoIcons.battery_25_percent),
              SizedBox(
                width: 5,
              ),
              Text('67%', style: TextStyle(fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}

class _PhoneFrontCamera extends StatelessWidget {
  const _PhoneFrontCamera();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.5,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(blurRadius: 5)],
            border: Border.all(
                width: 6.5, color: const Color.fromARGB(134, 0, 0, 0)),
            color: const Color.fromARGB(183, 133, 122, 122),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

class ScreenSize {
  static Size _xiaomiNote9S = Size.zero;

  static Size setXiaomiNote9sScreenSize({bool enableStatusBar = false}) {
    _xiaomiNote9S = Size(392.72727272727275,
        enableStatusBar ? (872.7272727272727 - 35) : 872.7272727272727);
    return _xiaomiNote9S;
  }
}
