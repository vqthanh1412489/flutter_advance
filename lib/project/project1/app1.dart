import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/project1/routes/app_navigation.dart';
import 'package:get/route_manager.dart';

class App1 extends StatelessWidget {
  const App1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.home_1,
      getPages: RoutePages.pages,
    );
  }
}
