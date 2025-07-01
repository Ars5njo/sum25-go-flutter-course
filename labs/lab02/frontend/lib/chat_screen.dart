import 'dart:async';
import 'package:flutter/material.dart';
import 'chat_service.dart';

// ChatScreen displays the chat UI
class ChatScreen extends StatefulWidget {
  final ChatService chatService;
  const ChatScreen({Key? key, required this.chatService}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late final StreamSubscription<String> _subscription;
  final List<String> _messages = [];
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    widget.chatService.connect().then((_) {
      setState(() {
        _loading = false;
      });
    }).catchError((e) {
      setState(() {
        _error = e.toString();
      });
    });
    _subscription = widget.chatService.messageStream.listen((msg) {
      setState(() {
        _messages.add(msg);
      });
    }, onError: (err) {
      setState(() {
        _error = err.toString();
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    widget.chatService.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text;
    widget.chatService.sendMessage(text).catchError((e) {
      setState(() {
        _error = e.toString();
      });
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: Center(child: Text('Error: $_error')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_messages[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('messageField'),
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  key: const Key('sendButton'),
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
