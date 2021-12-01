import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendChat extends StatefulWidget {
  const FriendChat({Key? key}) : super(key: key);

  @override
  State<FriendChat> createState() => _FriendChatState();
}

class _FriendChatState extends State<FriendChat> {
  final _keyChannel = GlobalKey<ChannelsBlocState>();

  Future<void> _onCreateChannel() async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          final _channelController = TextEditingController();

          return AlertDialog(
            title: const Text('Create channel'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _channelController,
                  decoration: const InputDecoration(hintText: 'Channel Name'),
                ),
                TextButton(
                  child: const Text('Access'),
                  onPressed: () =>
                      Navigator.of(context).pop(_channelController.text),
                )
              ],
            ),
          );
        });

    if (result != null) {
      print('object $result');
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging', id: result, extraData: {
        'image': DataUtils.getChannelImage(),
      });

      await channel.create();
      _keyChannel.currentState?.queryChannels();
      print(
          '_keyChannel.currentState?.queryChannels(); ${_keyChannel.currentState?.queryChannels()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FriendChat'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onCreateChannel,
        label: const Text('Create new channel'),
      ),
      body: ChannelsBloc(
          key: _keyChannel,
          child: ChannelListView(
            channelWidget: const ChannelPage(),
          )),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: const [
          Expanded(child: MessageListView()),
          MessageInput(attachmentLimit: 3),
        ],
      ),
    );
  }
}
