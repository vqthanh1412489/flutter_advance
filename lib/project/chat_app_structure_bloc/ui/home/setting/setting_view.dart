import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/app_theme_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/setting/setting_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/sign_in/sign_in_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.currentUser;
    final image = user?.extraData['image'];

    print('user $user');
    print('image $image');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                SettingSwichCubut(context.read<AppThemeCubit>().isDart)),
        BlocProvider(create: (context) => SettingLogoutCubut(context.read())),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ? Image.network(
                      image.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(),
              BlocBuilder<SettingSwichCubut, bool>(
                  builder: (context, snapshot) {
                return Switch(
                    value: snapshot,
                    onChanged: (val) {
                      context.read<SettingSwichCubut>().onChangeDarkMode(val);
                      context.read<AppThemeCubit>().updateTheme(val);
                    });
              }),
              Builder(builder: (context) {
                return BlocListener<SettingLogoutCubut, void>(
                  listener: (context, snapshot) {
                    popAllAndPush(context, const SigninView());
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<SettingLogoutCubut>().onLogout();
                      },
                      child: const Text('Logout')),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
