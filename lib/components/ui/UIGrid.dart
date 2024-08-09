// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

class UIGrid extends StatelessWidget {
  final List<Widget> children;
  final int columns;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final bool isHorizontal;
  const UIGrid(
      {super.key,
      required this.children,
      this.columns = 2,
      this.spacing = 2,
      this.padding = const EdgeInsets.all(0),
      this.isHorizontal = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isHorizontal) {
            final width = constraints.maxWidth;
            final lines = (children.length / columns).ceil();
            final itemWidth = (width - (columns - 1) * spacing) / columns;
            return HorizontalGridRender(
                lines: lines,
                columns: columns,
                itemWidth: itemWidth,
                spacing: spacing,
                children: children);
          } else {
            final height = constraints.maxHeight -
                padding.vertical -
                spacing * (columns - 1);
            final lines = (children.length / columns).ceil();
            final itemHeight = (height - (lines - 1) * spacing) / columns;
            return VerticalGridRender(
                lines: lines,
                columns: columns,
                itemHeight: itemHeight,
                spacing: spacing,
                children: children);
          }
        },
      ),
    );
  }
}

class VerticalGridRender extends StatelessWidget {
  const VerticalGridRender({
    super.key,
    required this.lines,
    required this.columns,
    required this.children,
    required this.itemHeight,
    required this.spacing,
  });

  final int lines;
  final int columns;
  final List<Widget> children;
  final double itemHeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(lines, (line) {
        return Column(
          children: List.generate(columns, (column) {
            final index = line * columns + column;
            if (index >= children.length) {
              return Expanded(child: Container());
            }
            return Container(
              height: itemHeight,
              margin: EdgeInsets.only(
                bottom: column < columns - 1 ? spacing : 0,
                right: line < lines - 1 ? spacing : 0,
              ),
              child: children[index],
            );
          }),
        );
      }),
    );
  }
}

class HorizontalGridRender extends StatelessWidget {
  const HorizontalGridRender({
    super.key,
    required this.lines,
    required this.columns,
    required this.children,
    required this.itemWidth,
    required this.spacing,
  });

  final int lines;
  final int columns;
  final List<Widget> children;
  final double itemWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(lines, (line) {
        return Row(
          children: List.generate(columns, (column) {
            final index = line * columns + column;
            if (index >= children.length) {
              return Expanded(child: Container());
            }
            return Container(
              width: itemWidth,
              margin: EdgeInsets.only(
                right: column < columns - 1 ? spacing : 0,
                bottom: line < lines - 1 ? spacing : 0,
              ),
              child: children[index],
            );
          }),
        );
      }),
    );
  }
}
