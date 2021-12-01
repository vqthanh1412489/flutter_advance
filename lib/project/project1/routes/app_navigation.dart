import 'package:flutter_advance_widget/project/project1/dynamic_size_button.dart';
import 'package:flutter_advance_widget/project/project1/home_1.dart';
import 'package:flutter_advance_widget/project/project1/notification_listener_sample.dart';
import 'package:flutter_advance_widget/project/project1/tips_performance/avoid_rebuild_unnecessary_inside_animatedbuilder.dart';
import 'package:flutter_advance_widget/project/project1/tips_performance/listview_performance.dart';
import 'package:flutter_advance_widget/project/project1/tips_performance/prevent_rebuild_all_widget.dart';
import 'package:flutter_advance_widget/project/project1/tips_performance/tips_performance.dart';
import 'package:get/route_manager.dart';

class RouteName {
  static const String notification_listener_sample =
      '/notification_listener_sample';
  static const String dynamic_size_button = '/dynamic_size_button';
  static const String home_1 = '/home_1';

  static const String tips_performance = '/tips_performance';
  static const String prevent_rebuild_all_widget =
      '/prevent_rebuild_all_widget';
  static const String listview_performance = '/listview_performance';
  static const String avoid_rebuild_unnecessary_inside_animatedbuilder =
      '/avoid_rebuild_unnecessary_inside_animatedbuilder';
}

class RoutePages {
  static final pages = [
    GetPage(name: RouteName.home_1, page: () => const Home1()),
    GetPage(
        name: RouteName.notification_listener_sample,
        page: () => const NotificationListenerSample()),
    GetPage(
        name: RouteName.dynamic_size_button,
        page: () => const DynamicSizeButton()),
    GetPage(
        name: RouteName.tips_performance, page: () => const TipsPerformance()),
    GetPage(
        name: RouteName.prevent_rebuild_all_widget,
        page: () => const PreventRebuildAllWidgets()),
    GetPage(
        name: RouteName.listview_performance,
        page: () => const ListViewPerformance()),
    GetPage(
        name: RouteName.avoid_rebuild_unnecessary_inside_animatedbuilder,
        page: () => const AvoidRebuildWidgetInsideAnimatedBuilder()),
  ];
}
