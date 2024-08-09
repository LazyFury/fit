import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fit/components/ui/UIText.dart';
import 'package:fit/components/ui/UITouchAble.dart';

class Navbar extends StatelessWidget {
  final String title;
  final bool? isHome;
  final Widget? left;
  final Widget? right;
  final double? fontSize;
  const Navbar({
    super.key,
    this.title = "招财猫",
    this.left,
    this.right,
    this.isHome = false,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 244, 244, 244),
        border: Border.fromBorderSide(
            BorderSide(color: Color.fromARGB(255, 232, 232, 232), width: .5)),
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  child: (isHome! == false && left == null)
                      ? UITouchAble(
                          child: const Row(
                            children: [
                              Image(
                                image: Svg('assets/images/icon/arrow-left.svg'),
                                width: 20,
                                height: 20,
                              ),
                              UIText("返回"),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          })
                      : left,
                ),
                UIText.zhuque(title,
                    color: Colors.black,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.normal)),
                SizedBox(
                  width: 80,
                  child: right,
                )
              ],
            )),
      ),
    );
  }
}
