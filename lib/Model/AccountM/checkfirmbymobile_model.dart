class CheckFirmByMobileModel {
  final bool success;
  final int firmId;
  final int completeReg;

  CheckFirmByMobileModel({
    required this.success,
    required this.firmId,
    required this.completeReg,
  });

  factory CheckFirmByMobileModel.fromJson(Map<String, dynamic> json) {
    return CheckFirmByMobileModel(
      success: json['success'] ?? false,
      firmId: json['firmId'] ?? 0,
      completeReg: json['completeReg'] ?? 0,
    );
  }
}