import 'package:flutter_advance_widget/project/chat_app/friend_chat.dart';
import 'package:flutter_advance_widget/project/chat_app/login.dart';
import 'package:get/route_manager.dart';

class RouteName {
  static const String friend_chat = '/friend_chat';
  static const String dynamic_size_button = '/friend_chat';
  static const String login = '/login';

  static const String tips_performance = '/tips_performance';
  static const String prevent_rebuild_all_widget =
      '/prevent_rebuild_all_widget';
  static const String listview_performance = '/listview_performance';
  static const String avoid_rebuild_unnecessary_inside_animatedbuilder =
      '/avoid_rebuild_unnecessary_inside_animatedbuilder';
}

class RoutePages {
  static final pages = [
    GetPage(name: RouteName.login, page: () => const Login()),
    GetPage(name: RouteName.friend_chat, page: () => const FriendChat()),
    // GetPage(
    //     name: RouteName.dynamic_size_button,
    //     page: () => const DynamicSizeButton()),
    // GetPage(
    //     name: RouteName.tips_performance, page: () => const TipsPerformance()),
    // GetPage(
    //     name: RouteName.prevent_rebuild_all_widget,
    //     page: () => const PreventRebuildAllWidgets()),
    // GetPage(
    //     name: RouteName.listview_performance,
    //     page: () => const ListViewPerformance()),
    // GetPage(
    //     name: RouteName.avoid_rebuild_unnecessary_inside_animatedbuilder,
    //     page: () => const AvoidRebuildWidgetInsideAnimatedBuilder()),
  ];
}
