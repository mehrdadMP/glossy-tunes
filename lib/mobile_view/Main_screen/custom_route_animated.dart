import 'package:flutter/material.dart';

enum TransitionMode { slideTransition, fadeTransition }

class CustomRouteAnimated extends ModalRoute<void> {
  Widget child;
  TransitionMode transitionMode;
  CustomRouteAnimated({required this.child, required this.transitionMode});

  @override
  Duration get transitionDuration => Duration(milliseconds: 600);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Color.fromARGB(15, 255, 255, 255).withOpacity(0.1);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    if (transitionMode == TransitionMode.fadeTransition) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    } else {
      return SlideTransition(
        position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
            .animate(animation),
        child: child,
      );
    }
  }
}
