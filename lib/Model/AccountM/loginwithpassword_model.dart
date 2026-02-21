class LoginWithPasswordModel {
  final bool status;
  final String message;

  LoginWithPasswordModel({required this.status, required this.message});

  factory LoginWithPasswordModel.fromJson(Map<String, dynamic> json) {
    return LoginWithPasswordModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}