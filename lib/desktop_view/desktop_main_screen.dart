import 'package:flutter/material.dart';

class DesktopMainScreen extends StatelessWidget {
  const DesktopMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(color: Colors.indigo),
            )
          ],
        )
      ]),
    ));
  }
}
