import 'package:flutter_advance_widget/project/project1/dynamic_size_button.dart';
import 'package:flutter_advance_widget/project/project1/home_1.dart';
import 'package:flutter_advance_widget/project/project1/notification_listener_sample.dart';
import 'package:get/route_manager.dart';

class RouteName {
  static const String notification_listener_sample =
      '/notification_listener_sample';
  static const String dynamic_size_button = '/dynamic_size_button';
  static const String home_1 = '/home_1';
}

class RoutePages {
  static final pages = [
    GetPage(name: RouteName.home_1, page: () => const Home1()),
    GetPage(
        name: RouteName.notification_listener_sample,
        page: () => const NotificationListenerSample()),
    GetPage(
        name: RouteName.dynamic_size_button,
        page: () => const DynamicSizeButton())
  ];
}
