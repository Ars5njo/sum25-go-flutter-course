import '../models/message.dart';

/// Base exception for API errors
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => "ApiException: $message";
}

/// Error for network issues
class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

/// Error for server-side issues
class ServerException extends ApiException {
  ServerException(String message) : super(message);
}

/// Error for validation failures
class ValidationException extends ApiException {
  ValidationException(String message) : super(message);
}

/// Stubbed API service for Lab03
class ApiService {
  ApiService();

  /// Dispose resources
  void dispose() {}

  Future<List<Message>> getMessages() async {
    throw UnimplementedError();
  }

  Future<Message> createMessage(CreateMessageRequest request) async {
    throw UnimplementedError();
  }

  Future<Message> updateMessage(int id, UpdateMessageRequest request) async {
    throw UnimplementedError();
  }

  Future<void> deleteMessage(int id) async {
    throw UnimplementedError();
  }

  Future<HTTPStatusResponse> getHTTPStatus(int code) async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> healthCheck() async {
    throw UnimplementedError();
  }
}
