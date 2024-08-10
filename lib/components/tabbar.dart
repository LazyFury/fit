import 'package:flutter/material.dart';
import 'package:fit/components/ui/UIText.dart';
import 'package:fit/components/ui/UITouchAble.dart';
import 'package:fit/constants.dart';

class TabData {
  final String title;
  final IconData? icon;
  final Widget Function(Color?) image;
  final bool isPage;
  final Widget? child;
  TabData(
      {required this.title,
      required this.image,
      this.icon,
      this.isPage = true,
      this.child});
}

// ignore: non_constant_identifier_names
Container Tabbar(List<TabData> tabs,
    {required Function onClickTab, int currentIndex = 0}) {
  return Container(
    decoration: const BoxDecoration(),
    child: SafeArea(
      top: false,
      bottom: true,
      child: Container(
        decoration: const BoxDecoration(),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs.asMap().entries.map((entry) {
            if (entry.value.child != null) {
              return entry.value.child!;
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: UITouchAble(
                  onTap: () {
                    onClickTab(entry);
                  },
                  child: Column(
                    children: [
                      entry.value.icon != null
                          ? Icon(
                              entry.value.icon,
                              size: 30,
                              color: currentIndex == entry.key
                                  ? UIColors.primary
                                  : Colors.black,
                            )
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: entry.value.image(currentIndex == entry.key
                                  ? UIColors.primary
                                  : Colors.black),
                            ),
                      UIText.text(
                        entry.value.title,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        fontSize: 12,
                        color: currentIndex == entry.key
                            ? UIColors.primary
                            : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
