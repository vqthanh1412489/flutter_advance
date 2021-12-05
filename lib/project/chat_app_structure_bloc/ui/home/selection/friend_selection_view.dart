import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/selection/group_selection_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../friend_chat.dart';
import 'friend_selection_cubit.dart';

class FriendSelectionView extends StatelessWidget {
  const FriendSelectionView({Key? key}) : super(key: key);

  void _createFriendChannel(
      BuildContext context, ChatUserState chatUserState, bool isGroup) async {
    if (isGroup) {
      context.read<FriendListUserCubit>().selectUser(chatUserState);
    } else {
      final channel = await context
          .read<FriendListUserCubit>()
          .createFriendChannel(chatUserState);
      pushAndReplaceToPage(
          context, StreamChannel(channel: channel, child: const ChannelPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    const heightHorizontalList = 110.0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FriendListUserCubit(context.read())..init()),
        BlocProvider(create: (_) => FriendIsGroupCubit()),
      ],
      child: BlocBuilder<FriendIsGroupCubit, bool>(builder: (context, isGroup) {
        return BlocBuilder<FriendListUserCubit, List<ChatUserState>>(
          builder: (context, listUsers) {
            final selectedUsers =
                context.read<FriendListUserCubit>().selectedUsers;

            return Scaffold(
              floatingActionButton: isGroup && selectedUsers.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        pushToPage(context,
                            GroupSelectionView(selectedUsers: selectedUsers));
                      },
                      child: const Icon(Icons.arrow_right_alt_rounded),
                    )
                  : null,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isGroup
                        ? Row(
                            children: [
                              BackButton(
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              Text(
                                'New Group',
                                style: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              BackButton(
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              Text(
                                'People',
                                style: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle,
                              ),
                            ],
                          ),
                    if (!isGroup)
                      SizedBox(
                        height: heightHorizontalList,
                        child: ListTile(
                          onTap:
                              context.read<FriendIsGroupCubit>().changeToGroup,
                          leading: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: const Icon(Icons.group_outlined)),
                          title: const Text('Create group',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w700)),
                          subtitle: Text(
                            'Tale with 2 or more contacts',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[400]),
                          ),
                        ),
                      )
                    else if (isGroup && selectedUsers.isEmpty)
                      SizedBox(
                        height: heightHorizontalList,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: primaryColor,
                                child: const Icon(Icons.add_outlined),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Add a friend',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Container(
                          height: 110,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedUsers.length,
                              itemBuilder: (context, index) {
                                final chatUserState = selectedUsers[index];

                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 26,
                                            backgroundImage: chatUserState
                                                        .chatUser.image !=
                                                    ''
                                                ? NetworkImage(chatUserState
                                                    .chatUser.image)
                                                : const NetworkImage(
                                                    'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                                          ),
                                          // const SizedBox(
                                          //   height: 6,
                                          // ),
                                          // Text(chatUserState.chatUser.name),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 32,
                                        right: -5,
                                        child: InkWell(
                                          onTap: () => context
                                              .read<FriendListUserCubit>()
                                              .selectUser(chatUserState),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: primaryColor,
                                            child: const Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    Expanded(
                        child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount: listUsers.length,
                          itemBuilder: (context, index) {
                            final chatUserState = listUsers[index];
                            return ListTile(
                              onTap: () {
                                _createFriendChannel(
                                    context, chatUserState, isGroup);
                              },
                              leading: CircleAvatar(
                                backgroundImage: chatUserState.chatUser.image !=
                                        ''
                                    ? NetworkImage(chatUserState.chatUser.image)
                                    : const NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                              ),
                              title: Text(chatUserState.chatUser.name),
                              trailing: isGroup
                                  ? Checkbox(
                                      value: chatUserState.selected,
                                      onChanged: (val) => context
                                          .read<FriendListUserCubit>()
                                          .selectUser(chatUserState))
                                  : null,
                            );
                          }),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
