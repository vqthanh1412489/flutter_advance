import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/dependencies.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/app_theme_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/splash/splash_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatAppStructureBLOC extends StatefulWidget {
  const ChatAppStructureBLOC({Key? key}) : super(key: key);

  @override
  State<ChatAppStructureBLOC> createState() => _ChatAppStructureBLOCState();
}

class _ChatAppStructureBLOCState extends State<ChatAppStructureBLOC> {
  final _streamChatClient = StreamChatClient('42gfxgefhfh5');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _streamChatClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
          create: (context) => AppThemeCubit(context.read())..init(),
          child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: snapshot ? Themes.themeDark : Themes.themeLight,
              home: const SplashView(),
              builder: (context, child) {
                return StreamChat(client: _streamChatClient, child: child);
              },
            );
          })),
    );
  }
}
