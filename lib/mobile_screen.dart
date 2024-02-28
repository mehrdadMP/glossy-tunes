import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XiaomiNote9S extends StatelessWidget {
  final Widget contents;
  const XiaomiNote9S({
    super.key,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 392.72727272727275,
        height: 872.7272727272727,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 50)],
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              _StatusBar(),
              _PhoneFrontCamera(),
              _StatusBarShadow(),
            ],
          ),
          _Contents(contents: contents),
        ]),
      ),
    );
  }
}

class XiaomiNote9S2 extends StatelessWidget {
  final Widget contents;
  const XiaomiNote9S2({
    super.key,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.72727272727275,
        height: 872.7272727272727,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 50)],
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              _StatusBar(),
              _PhoneFrontCamera(),
              _StatusBarShadow(),
            ],
          ),
          _Contents(contents: contents),
        ]),
      ),
    );
  }
}

class _Contents extends StatelessWidget {
  const _Contents({
    required this.contents,
  });

  final Widget contents;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: contents,
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
