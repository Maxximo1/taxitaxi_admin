import 'package:flutter/material.dart';

class SpinningIconButton extends AnimatedWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final AnimationController controller;
  const SpinningIconButton(
      {Key? key,
      required this.controller,
      required this.iconData,
      required this.onPressed})
      : super(key: key, listenable: controller);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      // Use whatever curve you would like, for more details refer to the Curves class
      curve: Curves.linearToEaseOut,
    );

    return RotationTransition(
      turns: animation,
      child: IconButton(
        icon: Icon(iconData),
        onPressed: onPressed,
      ),
    );
  }
}
