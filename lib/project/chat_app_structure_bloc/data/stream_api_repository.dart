import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

abstract class StreamApiRepository {
  Future<List<ChatUser>> getChatUsers();
  Future<String> getToken(String userId);
  Future<bool> connectIfExists(String userId);
  Future<ChatUser> connectUser(ChatUser user, String? token);
  Future<Channel> createGroupChat(
      String idChannel, String name, List<String> members,
      {String image});
  Future<Channel> createSimpleChat(String idFriend);
  Future<void> logout();
}
