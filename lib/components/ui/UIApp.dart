import 'package:flutter/material.dart';

class UIApp extends StatefulWidget {
  final Widget body;
  final Widget? header;

  const UIApp({super.key, required this.body, this.header});

  @override
  _UIAppState createState() => _UIAppState();
}

class _UIAppState extends State<UIApp> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              if (widget.header != null) widget.header!,
              Expanded(
                child: widget.body,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
