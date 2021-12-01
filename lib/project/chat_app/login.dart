import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app/data_utils.dart';
import 'package:flutter_advance_widget/project/chat_app/friend_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();

  String? _usernameError;
  bool _isLoading = false;

  Future<void> _onAccess() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      final user = client.state.user;

      if (user == null) {
        setState(() {
          _isLoading = true;
        });
        await client.disconnectUser();
        client.connectUser(
            User(id: username, extraData: {
              'image': DataUtils.getUserImage(username),
            }),
            client.devToken(username).rawValue);

        setState(() {
          _isLoading = false;
        });
      }

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const FriendChat()));
    } else {
      setState(() {
        _usernameError = 'Username is invalid';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = StreamChat.of(context).client;
    return Scaffold(
      appBar: AppBar(title: const Text('Login Chat app')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Card(
                elevation: 10,
                margin: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Input username to join Chat App'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      client.state.user == null
                          ? TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  errorText: _usernameError),
                            )
                          : Text('Username: ${client.state.user?.id}'),
                      TextButton(
                        child: const Text('Access'),
                        onPressed: _onAccess,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
