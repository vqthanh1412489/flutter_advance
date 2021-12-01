import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app/login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  late StreamChatClient _client;

  @override
  void initState() {
    _client = StreamChatClient(
      '42gfxgefhfh5',
      logLevel: Level.INFO,
    );
    super.initState();
  }

  @override
  void dispose() {
    _client.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: RouteName.login,
      // getPages: RoutePages.pages,
      home: const Login(),
      builder: (context, child) {
        return StreamChat(client: _client, child: child);
      },
    );
  }
}
