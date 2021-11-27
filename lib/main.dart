import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/project1/app1.dart';
import 'package:flutter_advance_widget/project/project2/app2.dart';
import 'package:flutter_advance_widget/project/project3/app3.dart';

enum AppType {
  app1,
  app2,
  app3,
}
void main() {
  // Config appType
  const AppType appSelected = AppType.app3;

  final Widget currentWidget;

  switch (appSelected) {
    case AppType.app1:
      currentWidget = const App1();
      break;
    case AppType.app2:
      currentWidget = const App2();
      break;
    case AppType.app3:
      currentWidget = const App3();
      break;
  }

  runApp(currentWidget);
}
