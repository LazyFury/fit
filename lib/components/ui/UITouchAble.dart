// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

class UITouchAble extends StatefulWidget {
  const UITouchAble(
      {super.key,
      required this.child,
      required this.onTap,
      this.duration = 200,
      this.behavior = HitTestBehavior.translucent});

  final Widget child;
  final void Function() onTap;
  final int duration;
  final HitTestBehavior behavior;

  @override
  State<UITouchAble> createState() => _UITouchAbleState();
}

class _UITouchAbleState extends State<UITouchAble> {
  double opacity = 1;

  onTapHandler() {
    widget.onTap();
    Future.delayed(Duration(milliseconds: widget.duration), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  void onTapDownHandler(details) {
    setState(() {
      opacity = 0.8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTapHandler,
      onTapDown: onTapDownHandler,
      child: Opacity(
        opacity: opacity,
        child: widget.child,
      ),
    );
  }
}
