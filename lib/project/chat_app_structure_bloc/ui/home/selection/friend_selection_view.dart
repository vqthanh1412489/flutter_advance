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
                  ? FloatingActionButton(onPressed: () {
                      pushToPage(context,
                          GroupSelectionView(selectedUsers: selectedUsers));
                    })
                  : null,
              body: Column(
                children: [
                  isGroup
                      ? Row(
                          children: [
                            BackButton(
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const Text('New Group'),
                          ],
                        )
                      : Row(
                          children: [
                            BackButton(
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const Text('People'),
                          ],
                        ),
                  if (!isGroup)
                    ElevatedButton(
                        onPressed: () {
                          context.read<FriendIsGroupCubit>().changeToGroup();
                        },
                        child: const Text('Crate Group'))
                  else if (isGroup && selectedUsers.isEmpty)
                    Column(
                      children: [
                        CircleAvatar(),
                        const Text('Add a friend'),
                      ],
                    )
                  else
                    SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedUsers.length,
                            itemBuilder: (context, index) {
                              final chatUserState = selectedUsers[index];

                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: chatUserState
                                                    .chatUser.image !=
                                                ''
                                            ? NetworkImage(
                                                chatUserState.chatUser.image)
                                            : const NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                                      ),
                                      Text(chatUserState.chatUser.name),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () => context
                                          .read<FriendListUserCubit>()
                                          .selectUser(chatUserState),
                                      icon: const Icon(Icons.delete)),
                                ],
                              );
                            })),
                  Expanded(
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
                          })),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
