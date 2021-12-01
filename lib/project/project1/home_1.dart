import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/project1/routes/app_navigation.dart';
import 'package:get/get.dart';

class Home1 extends StatelessWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home1"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LessionItem(
            onTab: () {
              Get.toNamed(RouteName.notification_listener_sample);
            },
            title: 'notification_listener_sample',
          ),
          LessionItem(
            onTab: () {
              Get.toNamed(RouteName.dynamic_size_button);
            },
            title: 'dynamic_size_button',
          ),
          LessionItem(
            onTab: () {
              Get.toNamed(RouteName.tips_performance);
            },
            title: 'tips_performance',
          ),
        ],
      ),
    );
  }
}

class LessionItem extends StatelessWidget {
  const LessionItem({
    Key? key,
    required this.onTab,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTab;
  final String title;

  @override
  Widget build(BuildContext context) {
    var _widthSize = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          width: _widthSize * 0.8,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.black12]),
          ),
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              onPressed: onTab,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ))),
    );
  }
}
