// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UICard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;
  final BoxDecoration? decoration;
  final double radius;
  const UICard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(10),
      this.margin = const EdgeInsets.all(2),
      this.width,
      this.height,
      this.decoration,
      this.color = const Color.fromARGB(255, 250, 250, 250),
      this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
              color: color,
              border: const Border.fromBorderSide(BorderSide(
                  color: Color.fromARGB(255, 252, 252, 252), width: .5)),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.02),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(.02),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, -1), // changes position of shadow
                ),
              ]),
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: child,
    );
  }
}
