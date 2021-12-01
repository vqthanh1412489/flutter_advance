import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/chat_view.dart';
import 'selection/friend_selection_view.dart';
import 'setting/setting_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
              child: BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
            return IndexedStack(
              index: snapshot,
              children: [
                ChatView(),
                SettingView(),
              ],
            );
          })),
          HomeNavigationBar(),
        ],
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().changeIndex(0);
              },
              child: const Text('Chat')),
          FloatingActionButton(
            onPressed: () {
              pushToPage(context, const FriendSelectionView());
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().changeIndex(1);
              },
              child: const Text('Setting')),
        ],
      ),
    );
  }
}
