// ignore_for_file: unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fit/components/navbar.dart';
import 'package:fit/components/tabbar.dart';
import 'package:fit/components/ui/UIApp.dart';
import 'package:fit/components/ui/UIText.dart';
import 'package:fit/components/ui/UITouchAble.dart';
import 'package:fit/constants.dart';
import 'package:fit/pages/tabbar/home.dart';
import 'package:fit/utils/pixel.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class PageData {
  final TabData tab;
  final Widget page;
  final Widget? header;
  PageData({
    required this.tab,
    required this.page,
    this.header,
  });
}

class TabbarStack extends HookConsumerWidget {
  TabbarStack({super.key});

  final List<PageData> _pages = [
    PageData(
      tab: TabData(
        title: "Fit!",
        image: (color) => SvgPicture.asset(
          "assets/icons/rili.svg",
          color: color,
        ),
      ),
      page: const Home(),
    ),
    PageData(
      tab: TabData(
          title: "运动",
          image: (color) => SvgPicture.asset(
                "assets/icons/dangan.svg",
                color: color,
              )),
      page: Container(),
    ),
    PageData(
      // tab 的 child 留白占位，用自定义画笔给 tababr 话异型背景，positoned 定位新的自定义按钮
      tab: TabData(
          title: "记录",
          icon: Icons.record_voice_over,
          isPage: false,
          child: Builder(
            builder: (context) {
              return Container(
                width: rpx(context, 64),
              );
            },
          ),
          image: (color) => Container()),
      page: Container(),
      header: const Navbar(
        title: "分析",
        isHome: true,
      ),
    ),
    PageData(
      tab: TabData(
          title: "睡眠",
          image: (color) => SvgPicture.asset(
                "assets/icons/yejian.svg",
                color: color,
              )),
      page: Container(),
    ),
    PageData(
      tab: TabData(
          title: "我的",
          image: (color) => SvgPicture.asset(
                "assets/icons/wode.svg",
                color: color,
              )),
      page: const Text("我的"),
      header: const Navbar(
        title: "我的",
        isHome: true,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenWidth = MediaQuery.of(context).size.width;
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;

    var currentIndex = useState(0);
    var currentPage = _pages[currentIndex.value];

    return UIApp(
      header: currentPage.header ??
          Navbar(
            title: "Fit!",
            fontSize: 24,
            isHome: true,
            left: Row(
              children: [
                UITouchAble(
                  child: const TDAvatar(
                    size: TDAvatarSize.small,
                    type: TDAvatarType.customText,
                    text: 'A',
                  ),
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (BuildContext buildContext,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const TDConfirmDialog(
                          title: "hello",
                          content: "text",
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            right: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UITouchAble(
                  child: SvgPicture.asset(
                    "assets/icons/tixing.svg",
                    width: 25,
                    height: 25,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: currentIndex.value,
                  children: _pages.map((e) => e.page).toList(),
                ),
              ),
              CustomPaint(
                size: Size(screenWidth, 50),
                painter: TabbarBgPainter(),
                child: Tabbar(
                  _pages.map((e) => e.tab).toList(),
                  onClickTab: (item) {
                    currentIndex.value = item.key;
                  },
                  currentIndex: currentIndex.value,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0 + safeAreaBottom,
            left: screenWidth / 2 - 24,
            child: UITouchAble(
              onTap: () {
                Navigator.of(context).push(TDSlidePopupRoute(
                    modalBarrierColor: TDTheme.of(context).fontGyColor2,
                    slideTransitionFrom: SlideTransitionFrom.bottom,
                    open: () {
                      print('open');
                    },
                    opened: () {
                      print('opened');
                    },
                    builder: (context) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        height: 480,
                        child: Column(
                          children: [
                            Container(
                              height: 240,
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TDButton(
                                      text: "Close",
                                      type: TDButtonType.fill,
                                      theme: TDButtonTheme.primary,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      );
                    }));
              },
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: UIColors.primary,
                          borderRadius: BorderRadius.circular(30),
                          border: const Border.fromBorderSide(BorderSide(
                              color: Color.fromARGB(255, 232, 232, 232),
                              width: .5)),
                          boxShadow: [
                            BoxShadow(
                                color: UIColors.primary.withOpacity(.35),
                                blurRadius: 10)
                          ]),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "记录饮食",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 向上微微突出的异型背景,与向下的逻辑不同，向下需要多画一个半圆出来，才够深度
class TabbarBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var devModel = false;
    var center = size.width / 2;
    var width = 60.0;
    const radius = 20.0;
    var startPoint = center - radius - 36;
    var endPoint = center + radius + 36;
    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, 0);

    var p1 = Offset(startPoint, 0);
    var centerPoint = Offset(center, -radius);
    var p4 = Offset(endPoint, 0);
    var p1JoinPoint = Offset(p1.dx + 30, p1.dy);
    var centerToP1JoinPoint = Offset(center - 24, -radius);
    var centerToP4JoinPoint = Offset(center + 24, -radius);
    var p4JoinPoint = Offset(p4.dx - 30, p4.dy);

    paint.color = Colors.white;

    path.lineTo(p1.dx, p1.dy);
    //  curve p1 to center

    // path.cubicTo(p1.dx + 30, p1.dy, center - 24, -radius, center, -radius);
    path.cubicTo(p1JoinPoint.dx, p1JoinPoint.dy, centerToP1JoinPoint.dx,
        centerToP1JoinPoint.dy, centerPoint.dx, centerPoint.dy);
    // center to p4
    // path.cubicTo(center + 24, -radius, p4.dx - 30, p4.dy, p4.dx, p4.dy);
    path.cubicTo(centerToP4JoinPoint.dx, centerToP4JoinPoint.dy, p4JoinPoint.dx,
        p4JoinPoint.dy, p4.dx, p4.dy);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.transform(Matrix4.translationValues(0, -10, 0).storage);
    canvas.drawShadow(path, Colors.grey.withOpacity(.2), 12, false);
    canvas.transform(Matrix4.translationValues(0, 10, 0).storage);

    canvas.drawPath(path, paint);

    // 边框
    Paint borderPaint = Paint()
      ..color = Colors.grey.withOpacity(.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .2;

    // borderPath.close();
    canvas.drawPath(path, borderPaint);

    if (devModel) {
      // draw point
      paint.color = Colors.red;
      canvas.drawCircle(p1, 5, paint);
      canvas.drawCircle(p4, 5, paint);
      canvas.drawCircle(centerPoint, 5, paint);
      paint.color = Colors.black;
      // draw join Point
      canvas.drawCircle(p1JoinPoint, 2, paint);
      canvas.drawCircle(centerToP1JoinPoint, 2, paint);
      canvas.drawCircle(centerToP4JoinPoint, 2, paint);
      canvas.drawCircle(p4JoinPoint, 2, paint);
      // line join point to point
      canvas.drawLine(p1, p1JoinPoint, paint);
      canvas.drawLine(centerPoint, centerToP1JoinPoint, paint);
      canvas.drawLine(centerPoint, centerToP4JoinPoint, paint);
      canvas.drawLine(p4, p4JoinPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
