class ApiResponse {
  final bool isSuccessful;
  final int statusCode;
  final dynamic data;
  final String? message;

  ApiResponse({
    required this.isSuccessful,
    required this.statusCode,
    this.data,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccessful: json['isSuccessful'],
      statusCode: json['statusCode'],
      data: json['data'],
      message: json['message'],
    );
  }
}
