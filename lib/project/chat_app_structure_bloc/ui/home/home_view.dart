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
    final backgroundColor = Theme.of(context).backgroundColor;

    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Expanded(child:
                BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
              return IndexedStack(
                index: snapshot,
                children: [
                  ChatView(),
                  const SettingView(),
                ],
              );
            })),
            const HomeNavigationBar(),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context, listen: true);
    const navigationBarSize = 80.0;
    const buttonSize = 60.0;
    const buttonMargin = 10.0;
    const topMargin = buttonSize / 2 + buttonMargin / 2;

    final canvasColor = Theme.of(context).canvasColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shadowColor: Colors.black45,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          color: canvasColor,
          height: navigationBarSize + topMargin,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Stack(
            children: [
              Positioned.fill(
                top: topMargin,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _NavBarItem(
                            isSelected: cubit.state == 0,
                            iconData: Icons.chat_bubble_outline,
                            text: 'Chat',
                            onTap: () => cubit.changeIndex(0)),
                      ),
                      Expanded(
                        child: _NavBarItem(
                            isSelected: cubit.state == 1,
                            iconData: Icons.settings_outlined,
                            text: 'Setting',
                            onTap: () => cubit.changeIndex(1)),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration:
                      BoxDecoration(color: canvasColor, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(buttonMargin / 2),
                  child: FloatingActionButton(
                    onPressed: () {
                      pushToPage(context, const FriendSelectionView());
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final unSelectedColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
    final color = isSelected ? selectedColor : unSelectedColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
