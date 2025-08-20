import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final String? status;
  final String? message;
  final dynamic data;

  const ApiResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] ?? json,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}