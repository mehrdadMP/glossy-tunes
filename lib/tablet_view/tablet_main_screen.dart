import 'package:flutter/material.dart';

class TabletMainScreen extends StatelessWidget {
  const TabletMainScreen({super.key});

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
              height: 300,
              width: 300,
              decoration: BoxDecoration(color: Colors.teal),
            )
          ],
        )
      ]),
    ));
  }
}
