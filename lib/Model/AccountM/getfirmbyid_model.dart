class GetFirmByIdModel {
  final bool success;
  final String message;
  final FirmData? data;

  GetFirmByIdModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory GetFirmByIdModel.fromJson(Map<String, dynamic> json) {
    return GetFirmByIdModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? FirmData.fromJson(json['data'])
          : null,
    );
  }
}

class FirmData {
  final int firmId;
  final String firmName;
  final String? phoneNo;
  final String? cityName;
  final String? address;

  FirmData({
    required this.firmId,
    required this.firmName,
    this.phoneNo,
    this.cityName,
    this.address,
  });

  factory FirmData.fromJson(Map<String, dynamic> json) {
    return FirmData(
      firmId: json['firmId'],
      firmName: json['firmName'] ?? "",
      phoneNo: json['phoneNo'],
      cityName: json['cityName'],
      address: json['address'],
    );
  }
}