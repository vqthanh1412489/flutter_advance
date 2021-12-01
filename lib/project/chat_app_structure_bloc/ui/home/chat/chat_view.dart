import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
          child: ChannelListView(
        // filter: {
        //   'members': {
        //     '\$in': [StreamChat.of(context).user.id],
        //   }
        // },
        sort: [SortOption('last_message_at')],
        channelWidget: const _ChannelPage(),
      )),
    );
  }
}

class _ChannelPage extends StatelessWidget {
  const _ChannelPage({Key? key}) : super(key: key);

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
