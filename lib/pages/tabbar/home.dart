
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fit/components/navbar.dart';
import 'package:fit/components/ui/UIApp.dart';
import 'package:fit/components/ui/UICard.dart';
import 'package:fit/components/ui/UIText.dart';
import 'package:fit/components/ui/UITouchAble.dart';
import 'package:fit/constants.dart';
import 'package:fit/utils/pixel.dart';
// ignore: depend_on_referenced_packages

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: EasyRefresh(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Column(
              children: [
                const PersistenceMessage(days: 3),
                chartView(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      UIText.zhuque(
                        "戒掉坏习惯",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                cardGroup(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container cardGroup() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              UICard(
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(12),
                    child: CustomPaint(
                      painter: CircularChartPainter(
                          value: .7256,
                          color: UIColors.primary,
                          strokeWidth: 16),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: UITouchAble(
                  onTap: () {},
                  child: UICard(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 247, 247, 247),
                    ),
                    height: 120,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UIText.text("点击记录", color: Colors.grey),
                          UIText.ali(
                            "今天不喝可乐",
                            fontSize: 20,
                            color: UIColors.primary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              UIText.text("已坚持", color: Colors.grey),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: UIText.text("3",
                                    fontSize: 20,
                                    color: UIColors.primary,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              UIText.text("天", color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: UICard(
                  height: 120,
                  margin: const EdgeInsets.all(4),
                  child: CustomPaint(
                    painter: LineChartPainter(),
                    child: UIText.zhuque("运动达人（每日步数）",
                        color: const Color.fromARGB(255, 58, 58, 58)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  UICard chartView(BuildContext context) {
    return UICard(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              UIText.zhuque("10日健康数据", fontSize: 14),
            ],
          ),
          StatChart(
            height: rpx(context, 110),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text("pass"),
                  Container(
                    color: UIColors.primary,
                    width: 10,
                    height: 10,
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  const Text("no pass"),
                  Container(
                    color: const Color.fromARGB(255, 245, 192, 59),
                    width: 10,
                    height: 10,
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  const Text("dangerous"),
                  Container(
                    color: const Color.fromARGB(255, 245, 75, 59),
                    width: 10,
                    height: 10,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Detail extends HookConsumerWidget {
  const Detail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var count = useState(0);
    return UIApp(
      body: Center(
        child: Column(
          children: <Widget>[
            const Navbar(
              title: "detail",
            ),
            Text(
              'You have pushed the button this many times: ${count.value}',
            ),
            UITouchAble(
                child: const Text("Add"),
                onTap: () {
                  count.value++;
                }),
            UITouchAble(child: const UIText("click"), onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;

  CircularChartPainter(
      {required this.value, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // draw value
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // draw background
    paint.color = Colors.grey[200]!;
    canvas.drawArc(rect, 0, 3.1415926 * 2, false, paint);

    paint.color = color;
    var startAngle = -90 * 3.1415926 / 180;
    var sweepAngle = value * 3.1415926 * 2;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // draw Text
    var textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
    var textPainter = TextPainter(
        text: TextSpan(text: "${(value * 100).toInt()}%", style: textStyle),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 2,
            size.height / 2 - textPainter.height / 2 - 8));

    // label text "坚持周期"
    var labelStyle = const TextStyle(
      color: Color.fromARGB(255, 92, 92, 92),
      fontSize: 10,
    );

    var labelPainter = TextPainter(
        text: TextSpan(text: "坚持周期", style: labelStyle),
        textDirection: TextDirection.ltr);

    labelPainter.layout();

    labelPainter.paint(
        canvas,
        Offset(size.width / 2 - labelPainter.width / 2,
            size.height / 2 + labelPainter.height / 2 - 5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class IconItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconItem({
    super.key,
    this.text = "icon",
    this.icon = Icons.circle_notifications_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return UITouchAble(
      onTap: () {},
      child: UICard(
        margin: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
            UIText(text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 63, 62, 62),
                    fontSize: 10,
                    fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class StatChart extends StatelessWidget {
  final double height;
  const StatChart({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
            child: Container(
              padding: const EdgeInsets.all(2),
              clipBehavior: Clip.antiAlias,
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: CustomPaint(
                painter: BarChartPainter(
                  color: UIColors.primary,
                  data: [
                    {"value": .2},
                    {"value": .5},
                    {"value": .2},
                    {"value": .4},
                    {"value": .1},
                    {"value": .4},
                    {"value": .9},
                    {"value": .1},
                    {"value": .4},
                    {"value": 1.0},
                  ],
                  gap: rpx(context, 4),
                ),
                isComplex: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final Color color;
  final List<Map<String, dynamic>> data;
  double? barWidth;
  final double? gap;

  BarChartPainter(
      {required this.color, required this.data, this.barWidth, this.gap = 2});

  @override
  void paint(Canvas canvas, Size size) {
    var barWidth = size.width / data.length;
    barWidth = barWidth;
  
    var gap = 2.0;
    gap = gap;
  
    var passLine = 0.3;
    var dangerousLine = 0.15;
    var passLineColor = UIColors.primary;
    var noPassLineColor = const Color.fromARGB(255, 245, 192, 59);
    var dangerousLineColor = const Color.fromARGB(255, 245, 75, 59);

    // draw line vertical
    final linePaint = Paint()
      ..color = const Color.fromARGB(255, 211, 211, 211)
      ..strokeWidth = .2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < data.length; i++) {
      canvas.drawLine(Offset(i * barWidth + barWidth * .5, 0),
          Offset(i * barWidth + barWidth * .5, size.height), linePaint);
    }

    // draw bar bg
    final bgPaint = Paint()
      ..color = const Color.fromARGB(255, 244, 244, 244)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < data.length; i++) {
      // ignore: unused_local_variable
      final barHeight = (data[i]["value"] as double) * size.height;
      canvas.drawRRect(
          RRect.fromLTRBR(i * barWidth + gap, 1, (i + 1) * barWidth - gap,
              size.height, const Radius.circular(4)),
          bgPaint);
    }

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    for (var i = 0; i < data.length; i++) {
      paint.color = (data[i]["value"] as double) >= passLine
          ? passLineColor
          : noPassLineColor;

      if ((data[i]["value"] as double) < dangerousLine) {
        paint.color = dangerousLineColor;
      }
      final barHeight = (data[i]["value"] as double) * size.height;
      canvas.drawRRect(
          RRect.fromLTRBR(
              i * barWidth + gap,
              size.height - barHeight,
              (i + 1) * barWidth - gap,
              size.height,
              const Radius.circular(4)),
          paint);
    }

    const textStyle = TextStyle(
      color: Color.fromARGB(255, 81, 81, 81),
      fontSize: 8,
    );

    for (var i = 0; i < data.length; i++) {
      final text = (data[i]["value"] as double).toStringAsFixed(2);
      final barHeight = (data[i]["value"] as double) * size.height;
      final textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(i * barWidth + barWidth / 2 - textPainter.width / 2,
              size.height - barHeight - textPainter.height - 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LineChartPainter extends CustomPainter {
  // 0 - 1
  var data = [
    {"value": .1},
    {"value": .1},
    {"value": .02},
    {"value": .14},
    {"value": .1},
    {"value": .4},
    {"value": .29},
    {"value": .4},
    {"value": .1},
    {"value": .4},
    {"value": .2},
    {"value": .1},
    {"value": .7},
    {"value": .6},
    {"value": .4},
    {"value": .5},
    {"value": .4},
    {"value": .3},
    {"value": .4},
    {"value": .8},
    {"value": .9},
    {"value": .98},
  ];

  @override
  void paint(Canvas canvas, Size size) {
    var offsetX = 10;
    Paint linePaint = Paint()
      ..color = UIColors.primary
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    var height = size.height;
    var width = size.width;

    // draw
    var points = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      points.add(Offset(i * width / data.length + offsetX,
          height - data[i]["value"]! * height));
    }

    var linePath = Path();
    linePath.moveTo(0, height);
    for (var i = 0; i < data.length; i++) {
      if (i == 0) {
        linePath.moveTo(points[i].dx, points[i].dy);
      }

      if (i == data.length - 1) {
        continue;
      }

      var currentOffset = points[i];

      var nextOffset = points[i + 1];

      var currentRightController = Offset(
        (currentOffset.dx + nextOffset.dx) / 2,
        currentOffset.dy,
      );

      var nextLeftController = Offset(
        (nextOffset.dx + currentOffset.dx) / 2,
        nextOffset.dy,
      );

      linePath.cubicTo(
          currentRightController.dx,
          currentRightController.dy,
          nextLeftController.dx,
          nextLeftController.dy,
          nextOffset.dx,
          nextOffset.dy);
    }

    // canvas.drawPoints(PointMode.polygon, points, linePaint);
    canvas.drawPath(linePath, linePaint);

    // draw gradient color
    var paint = Paint()
      ..color = UIColors.primary
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(10, height);
    for (var i = 0; i < data.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      }
      if (i == data.length - 1) {
        continue;
      }

      var currentOffset = points[i];
      var nextOffset = points[i + 1];

      var currentRightController = Offset(
        (currentOffset.dx + nextOffset.dx) / 2,
        currentOffset.dy,
      );

      var nextLeftController = Offset(
        (nextOffset.dx + currentOffset.dx) / 2,
        nextOffset.dy,
      );

      path.cubicTo(
          currentRightController.dx,
          currentRightController.dy,
          nextLeftController.dx,
          nextLeftController.dy,
          nextOffset.dx,
          nextOffset.dy);
    }

    var last = (data.length - 1) * width / data.length + offsetX;
    path.lineTo(last, height);
    path.lineTo(points[0].dx, height);

    // 渐变
    var rect = Rect.fromLTWH(0, 0, width, height);
    var gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [UIColors.primary, Colors.white],
    ).createShader(rect);

    paint.shader = gradient;

    canvas.drawPath(path, paint);

    // draw circle
    for (var i = 0; i < data.length; i++) {
      canvas.drawCircle(points[i], 2, linePaint);
    }

    // draw value label
    const textStyle = TextStyle(
      color: Color.fromARGB(255, 81, 81, 81),
      fontSize: 6,
    );

    for (var i = 0; i < data.length; i++) {
      final text = (data[i]["value"] as double).toStringAsFixed(2);
      final barHeight = (data[i]["value"] as double) * height;
      final textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              i * width / data.length +
                  width / data.length / 2 -
                  textPainter.width / 2,
              height - barHeight - textPainter.height - 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PersistenceMessage extends StatelessWidget {
  final int days;

  const PersistenceMessage({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          UIText.ali("你已经坚持了 $days 天\n不要放弃！", fontSize: 24),
        ],
      ),
    );
  }
}
