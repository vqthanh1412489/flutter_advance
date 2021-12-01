import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyView extends StatelessWidget {
  const ProfileVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileVerifyState>(
          listener: (context, snapshot) {
        if (snapshot.success) {
          pushAndReplaceToPage(context, const HomeView());
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ProfileVerifyView'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Verify your identify'),
              snapshot.file == null
                  ? const Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    )
                  : Image.file(
                      snapshot.file!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
              IconButton(
                  onPressed: () {
                    context.read<ProfileVerifyCubit>().pickImage();
                  },
                  icon: const Icon(Icons.photo)),
              const Text('Your name'),
              const TextField(
                decoration: InputDecoration(hintText: 'Or just how to ...'),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<ProfileVerifyCubit>().startChatting();
                  },
                  child: const Text('Start chating now')),
            ],
          ),
        );
      }),
    );
  }
}
