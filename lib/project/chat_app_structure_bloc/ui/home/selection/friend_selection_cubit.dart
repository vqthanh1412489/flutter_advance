import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  const ChatUserState(this.chatUser, {this.selected = false});

  final ChatUser chatUser;
  final bool selected;
}

class FriendListUserCubit extends Cubit<List<ChatUserState>> {
  FriendListUserCubit(this._streamApiRepository) : super([]);

  final StreamApiRepository _streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected).toList();

  Future<void> init() async {
    final listChatUser = await _streamApiRepository.getChatUsers();
    final list = listChatUser.map((e) => ChatUserState(e)).toList();
    emit(list);
  }

  void selectUser(ChatUserState chatUserState) {
    final index = state.indexWhere((element) {
      return element.chatUser.id == chatUserState.chatUser.id;
    });

    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUserState.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {
    return await _streamApiRepository
        .createSimpleChat(chatUserState.chatUser.id);
  }
}

class FriendIsGroupCubit extends Cubit<bool> {
  FriendIsGroupCubit() : super(false);

  void changeToGroup() => emit(!state);
}
