// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UIText extends Text {
  @override
  // ignore: overridden_fields
  final String data;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  @override
  // ignore: overridden_fields
  final TextStyle? style;
  const UIText(this.data,
      {super.key,
      this.color,
      this.fontSize,
      this.fontFamily,
      this.style = const TextStyle(
        color: Color.fromARGB(255, 25, 24, 24),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      )})
      : super('');

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: super.key,
      style: (style ?? const TextStyle()).copyWith(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily ?? 'ali',
      ),
    );
  }

  static UIText text(
    String data, {
    Color? color,
    TextStyle? style,
    double? fontSize,
    String? fontFamily = "pingfang",
  }) {
    return UIText(
      data,
      color: color,
      style: style,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );
  }

  // light
  static UIText light(
    String data, {
    Color? color = Colors.white,
    TextStyle? style,
    double? fontSize,
  }) {
    return UIText(data, color: color, style: style, fontSize: fontSize);
  }

  static UIText zcool(
    String data, {
    Color? color = Colors.black,
    TextStyle? style,
    double? fontSize,
  }) {
    return UIText(
      data,
      color: color,
      fontFamily: 'zcool',
      fontSize: fontSize,
      style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.w100),
    );
  }

  // ali
  static UIText ali(
    String data, {
    Color? color = Colors.black,
    TextStyle? style,
    double? fontSize,
  }) {
    return UIText(data, color: color, fontFamily: 'ali', fontSize: fontSize);
  }

  // zhuque ZhuqueFangsong
  static UIText zhuque(
    String data, {
    Color? color = Colors.black,
    TextStyle? style,
    double? fontSize,
  }) {
    return UIText(
      data,
      color: color,
      fontFamily: 'ZhuqueFangsong',
      fontSize: fontSize,
      style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.w100),
    );
  }
}
