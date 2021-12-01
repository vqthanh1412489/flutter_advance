import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/project1/home_1.dart';
import 'package:flutter_advance_widget/project/project1/routes/app_navigation.dart';
import 'package:get/route_manager.dart';

class TipsPerformance extends StatefulWidget {
  const TipsPerformance({Key? key}) : super(key: key);

  @override
  _TipsPerformanceState createState() => _TipsPerformanceState();
}

class _TipsPerformanceState extends State<TipsPerformance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TipsPerformance'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LessionItem(
                  onTab: () {}, title: 'Use const widget where posiable'),
              LessionItem(
                  onTab: () {},
                  title:
                      'Not split Widget with method, We should create StatelessWidget'),
              LessionItem(
                  onTab: () {
                    Get.toNamed(RouteName.prevent_rebuild_all_widget);
                  },
                  title: 'Prevent rebuild all widgets when setState'),
              LessionItem(
                  onTab: () {
                    Get.toNamed(RouteName.listview_performance);
                  },
                  title: 'listview_performance'),
              LessionItem(
                  onTab: () {
                    Get.toNamed(RouteName
                        .avoid_rebuild_unnecessary_inside_animatedbuilder);
                  },
                  title: 'avoid_rebuild_unnecessary_inside_animatedbuilder'),
            ],
          ),
        ));
  }
}
