import 'dart:async';

// ChatService handles chat logic and backend communication
class ChatService {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  bool _connected = false;

  ChatService();

  Future<void> connect() async {
    _connected = true;
  }

  Future<void> sendMessage(String msg) async {
    if (!_connected) throw Exception('Not connected');
    _controller.add(msg);
  }

  /// Stream of incoming messages
  Stream<String> get messageStream => _controller.stream;

  /// Clean up resources
  void dispose() {
    _controller.close();
  }
}
