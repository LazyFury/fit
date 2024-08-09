import 'package:flutter/cupertino.dart';

double _scale(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double scale = screenWidth / 375;
  return scale;
}

double rpx(BuildContext context, double value) {
  return value * _scale(context);
}
