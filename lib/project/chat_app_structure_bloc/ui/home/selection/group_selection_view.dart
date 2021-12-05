import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/routes/navigator_utils.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/common/avatar_widget.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/common/loading_view.dart';
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
        return LoadingView(
          isLoading: snapshot.isLoading,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                  color: Theme.of(context).appBarTheme.titleTextStyle?.color),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New group',
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: context.read<GroupSelectionCubit>().createGroup,
              child: const Icon(Icons.arrow_right_alt_rounded),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarWidget(
                      onTap: context.read<GroupSelectionCubit>().pickImage,
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
                            )),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: context
                          .read<GroupSelectionCubit>()
                          .groupNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name of the group',
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
                  const SizedBox(height: 20),
                  Wrap(
                    children: List.generate(
                        selectedUsers.length,
                        (index) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: selectedUsers[index]
                                                .chatUser
                                                .image !=
                                            ''
                                        ? NetworkImage(
                                            selectedUsers[index].chatUser.image)
                                        : const NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                                  ),
                                ),
                              ],
                            )),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
