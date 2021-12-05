import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/app_theme_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/common/avatar_widget.dart';
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

    final textColor = Theme.of(context).appBarTheme.titleTextStyle?.color;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                SettingSwichCubut(context.read<AppThemeCubit>().isDart)),
        BlocProvider(create: (context) => SettingLogoutCubut(context.read())),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Setting',
            ),
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarWidget(
                  onTap: () {}, // TODO: implement update avatar...
                  child: image == null
                      ? Icon(
                          Icons.person_outline,
                          size: 100,
                          color: Colors.grey[400],
                        )
                      : Image.network(
                          image.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  user?.name ?? '',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                _DarkModeWidget(textColor: textColor!),
                Builder(builder: (context) {
                  return _LogoutWidget(
                      textColor: textColor,
                      onTap: () =>
                          context.read<SettingLogoutCubut>().onLogout());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkModeWidget extends StatelessWidget {
  const _DarkModeWidget({
    Key? key,
    required this.textColor,
  }) : super(key: key);

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.nights_stay_outlined),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          'Dark Mode',
          style: TextStyle(
            fontSize: 16.0,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        BlocBuilder<SettingSwichCubut, bool>(builder: (context, snapshot) {
          return Switch(
              activeColor: Theme.of(context).primaryColor,
              value: snapshot,
              onChanged: (val) {
                context.read<SettingSwichCubut>().onChangeDarkMode(val);
                context.read<AppThemeCubit>().updateTheme(val);
              });
        }),
      ],
    );
  }
}

class _LogoutWidget extends StatelessWidget {
  const _LogoutWidget({
    Key? key,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.logout_outlined),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          'Logout',
          style: TextStyle(
            fontSize: 16.0,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        BlocListener<SettingLogoutCubut, void>(
          listener: (context, snapshot) {
            popAllAndPush(context, const SigninView());
          },
          child:
              IconButton(onPressed: onTap, icon: const Icon(Icons.arrow_right)),
        )
      ],
    );
  }
}
