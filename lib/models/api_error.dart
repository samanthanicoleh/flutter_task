import 'dart:convert';

class ApiError {
  final String message;

  ApiError({
    required this.message,
  });

  ApiError copyWith({
    String? message,
  }) =>
      ApiError(
        message: message ?? this.message,
      );

  Map<String, dynamic> toMap() => {
        'message': message,
      };

  factory ApiError.fromMap(Map<String, dynamic> map) => ApiError(
        message: map['message'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) => ApiError.fromMap(json.decode(source));

  @override
  String toString() => 'ApiError(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ApiError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
