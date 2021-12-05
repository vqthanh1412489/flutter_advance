import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/sign_in/sign_in_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/splash/init_background_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).backgroundColor;

    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none) {
            pushAndReplaceToPage(context, const SigninView());
          } else if (snapshot == SplashState.existing_user) {
            pushAndReplaceToPage(context, const HomeView());
          } else {
            pushAndReplaceToPage(context, const ProfileVerifyView());
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: const InitBackgroundView(),
        ),
      ),
    );
  }
}
