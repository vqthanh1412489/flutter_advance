import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/common/avatar_widget.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_view.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyView extends StatelessWidget {
  const ProfileVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).backgroundColor;

    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileVerifyState>(
          listener: (context, snapshot) {
        if (snapshot.success) {
          pushAndReplaceToPage(context, const HomeView());
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify your identify',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              AvatarWidget(
                onTap: context.read<ProfileVerifyCubit>().pickImage,
                child: snapshot.file == null
                    ? Icon(
                        Icons.person_outline,
                        size: 100,
                        color: Colors.grey[400],
                      )
                    : Image.file(
                        snapshot.file!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name and access to our platform...',
                    hintStyle:
                        TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    fillColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const ButtonChatingNowWidget(),
            ],
          ),
        );
      }),
    );
  }
}

class ButtonChatingNowWidget extends StatelessWidget {
  const ButtonChatingNowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'home_hero',
      child: Material(
        elevation: 3,
        shadowColor: Colors.black45,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => context.read<ProfileVerifyCubit>().startChatting(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Text('Start chating now',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
