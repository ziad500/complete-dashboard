import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final Widget? child;
  final int duration;
  final double paddingAnimation;

  const FadeAnimation(
      {Key? key, this.child, this.duration = 700, this.paddingAnimation = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInQuart,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: value * paddingAnimation),
              child: child,
            ),
          );
        },
        child: child);
  }
}
