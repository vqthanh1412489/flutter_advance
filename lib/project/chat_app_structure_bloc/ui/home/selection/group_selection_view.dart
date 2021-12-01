import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/selection/friend_selection_cubit.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/selection/group_selection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../friend_chat.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView({Key? key, required this.selectedUsers})
      : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupSelectionCubit(selectedUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
          listener: (context, snapshot) {
        if (snapshot.channel != null) {
          pushAndReplaceToPage(
              context,
              StreamChannel(
                  channel: snapshot.channel!, child: const ChannelPage()));
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
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
                    onPressed: context.read<GroupSelectionCubit>().pickImage,
                    icon: const Icon(Icons.photo)),
                TextField(
                  controller:
                      context.read<GroupSelectionCubit>().groupNameController,
                  decoration: const InputDecoration(
                    hintText: 'Name of the group',
                  ),
                ),
                Wrap(
                  children: List.generate(
                      selectedUsers.length,
                      (index) => Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: selectedUsers[index]
                                            .chatUser
                                            .image !=
                                        ''
                                    ? NetworkImage(
                                        selectedUsers[index].chatUser.image)
                                    : const NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                              ),
                              Text(selectedUsers[index].chatUser.name)
                            ],
                          )),
                ),
                ElevatedButton(
                    onPressed: context.read<GroupSelectionCubit>().createGroup,
                    child: const Text('Next')),
              ],
            ),
          ),
        );
      }),
    );
  }
}
