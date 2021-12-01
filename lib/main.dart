import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/chat_app_structure_bloc.dart';
import 'package:flutter_advance_widget/project/project1/app1.dart';
import 'package:flutter_advance_widget/project/project3/app3.dart';

import 'project/chat_app/chat_app.dart';

enum AppType {
  app1,
  chatapp,
  chatapp_structure_bloc,
  app3,
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Config appType
  const AppType appSelected = AppType.chatapp_structure_bloc;

  final Widget currentWidget;

  switch (appSelected) {
    case AppType.app1:
      currentWidget = const App1();
      break;
    case AppType.chatapp:
      currentWidget = const ChatApp();
      break;
    case AppType.chatapp_structure_bloc:
      currentWidget = const ChatAppStructureBLOC();
      break;
    case AppType.app3:
      currentWidget = const App3();
      break;
  }

  runApp(currentWidget);
}
