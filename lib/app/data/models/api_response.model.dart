class ApiResponse {
  final bool isSuccessful;
  final int statusCode;
  final dynamic data;
  final String? message;
  final String? accessToken;
  final String? refreshToken;

  ApiResponse({
    required this.isSuccessful,
    required this.statusCode,
    this.data,
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccessful: json['isSuccessful'],
      statusCode: json['statusCode'],
      data: json['data'],
      message: json['message'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  factory ApiResponse.fromJson2(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccessful: json['success'],
      statusCode: json['statusCode'],
      data: json['data'],
      message: json['message'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
