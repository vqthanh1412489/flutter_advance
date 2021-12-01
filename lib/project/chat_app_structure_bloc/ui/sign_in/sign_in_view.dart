import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/sign_in/sign_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.red,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login ....'),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SigninCubit>().onSignIn();
                  },
                  child: const Text('Login With Google'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
