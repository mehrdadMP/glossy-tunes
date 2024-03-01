import 'package:flutter/material.dart';
import 'package:glossy_tunes/mobile_view/mobile_main_screen.dart';

class CustomPageRoute extends PageRouteBuilder with texts {
  final Widget child;
  final TransitionMode transitionMode;

  CustomPageRoute({required this.child, required this.transitionMode})
      : super(
            transitionDuration: Duration(milliseconds: 700),
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) =>
                child);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return switch (transitionMode) {
      TransitionMode.up => SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .animate(animation),
          child: child),
      TransitionMode.down => SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1))
              .animate(animation),
          child: child),
      TransitionMode.left => SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .animate(animation),
          child: child),
      TransitionMode.right => SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .animate(animation),
          child: child),
    };
  }
}