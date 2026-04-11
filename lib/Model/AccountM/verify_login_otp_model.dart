class VerifyLoginOtpModel {
  final bool status;
  final String message;
  final Map<String, dynamic>? data;

  VerifyLoginOtpModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory VerifyLoginOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyLoginOtpModel(
      status: json["success"] ?? json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }
}