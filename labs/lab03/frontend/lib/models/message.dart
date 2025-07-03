class Message {
  final int id;
  final String username;
  final String content;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.username,
    required this.content,
    required this.timestamp,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return (null as dynamic).fromJson(json);
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

/// Request to create a message
class CreateMessageRequest {
  final String username;
  final String content;

  CreateMessageRequest({required this.username, required this.content});

  /// Validates request fields; returns error message or null
  String? validate() {
    if (username.isEmpty) return 'username is required';
    if (content.isEmpty) return 'content is required';
    return null;
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

/// Request to update a message
class UpdateMessageRequest {
  final String content;

  UpdateMessageRequest({required this.content});

  /// Validates update request
  String? validate() {
    if (content.isEmpty) return 'content is required';
    return null;
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

/// HTTP status response model
class HTTPStatusResponse {
  final int statusCode;
  final String imageUrl;
  final String description;

  HTTPStatusResponse({
    required this.statusCode,
    required this.imageUrl,
    required this.description,
  });

  factory HTTPStatusResponse.fromJson(Map<String, dynamic> json) {
    return (null as dynamic).fromJson(json);
  }
}
