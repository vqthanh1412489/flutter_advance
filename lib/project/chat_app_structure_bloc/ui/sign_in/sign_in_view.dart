import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/sign_in/sign_in_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/splash/init_background_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).backgroundColor;

    return BlocProvider<SigninCubit>(
      create: (_) => SigninCubit(context.read()),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, snapshot) {
          if (snapshot == SigninState.none) {
            pushAndReplaceToPage(context, const ProfileVerifyView());
          } else {
            pushAndReplaceToPage(context, const HomeView());
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                const InitBackgroundView(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          'assets/logo.png',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        'Welcome to\nFluChat',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'A platform to chat with users very easly and friendly',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const LoginGoogleWidget(),
                    ],
                  ),
                ),
                const Positioned(
                  left: 20.0,
                  bottom: 30.0,
                  child: Text(
                      '"in the modern world the\nqulity of life is the quality\nof communication',
                      style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginGoogleWidget extends StatelessWidget {
  const LoginGoogleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: InkWell(
        onTap: () => context.read<SigninCubit>().onSignIn(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Hero(
                    tag: 'logo_hero',
                    child: Image.asset('assets/google_ic.png')),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Login with Google',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
