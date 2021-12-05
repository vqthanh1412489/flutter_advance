import 'dart:convert';

import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/chat_user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:stream_chat/src/client/channel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApiImpl extends StreamApiRepository {
  StreamApiImpl(this._client);
  final StreamChatClient _client;

  @override
  Future<bool> connectIfExists(String userId) async {
    try {
      final token = await getToken(userId);
      await _client.connectUser(User(id: userId), token);
      return _client.state.currentUser?.name != null;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<ChatUser> connectUser(ChatUser user, String? token) async {
    Map<String, dynamic> extraData = {};
    extraData['image'] = user.image;
    extraData['name'] = user.name;

    await _client.disconnectUser();
    await _client.connectUser(User(id: user.id, extraData: extraData),
        token ?? _client.devToken(user.id).rawValue);
    return user;
  }

  @override
  Future<Channel> createGroupChat(
      String idChannel, String name, List<String> members,
      {String? image}) async {
    final channel = _client.channel('messaging', id: idChannel, extraData: {
      'name': name,
      'image': image,
      'members': [_client.state.currentUser?.id, ...members]
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String idFriend) async {
    final channel = _client.channel('messaging',
        id: '${_client.state.currentUser?.id.hashCode}${idFriend.hashCode}',
        extraData: {
          'members': [idFriend, _client.state.currentUser?.id]
        });
    await channel.watch();
    return channel;
  }

  @override
  Future<List<ChatUser>> getChatUsers() async {
    final result =
        await _client.queryUsers(filter: Filter.equal('banned', false));
    final chatUsers = result.users
        .where((element) => element.id != _client.state.currentUser?.id)
        .map((e) => ChatUser(name: e.name, image: e.image ?? '', id: e.id))
        .toList();

    return chatUsers;
  }

  @override
  Future<String> getToken(String userId) async {
    final response = await http.post(
        Uri.parse(
            'https://test-stream-chat-flutter-default-rtdb.firebaseio.com/user/name'),
        body: jsonEncode(<String, String>{'id': userId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    print('response ${response.body}');

    return _client.devToken(userId).rawValue;
  }

  @override
  Future<void> logout() async {
    _client.disconnectUser();
  }
}
