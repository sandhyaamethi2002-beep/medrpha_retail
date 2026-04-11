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
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? FirmData.fromJson(json['data']) : null,
    );
  }
}

class FirmData {
  final int firmId;
  final String firmName;
  final String? phoneNo;
  final String? personName;
  final String? email;
  final String? address;
  final String? cityName;
  final String? stateName;
  final String? countryName;
  final String? gstNo;
  final int? completeRegStatus;
  final int? hdnDrugsyesno;
  final int status;

  FirmData({
    required this.firmId,
    required this.firmName,
    this.phoneNo,
    this.personName,
    this.email,
    this.address,
    this.cityName,
    this.stateName,
    this.countryName,
    this.gstNo,
    this.completeRegStatus,
    this.hdnDrugsyesno,
    required this.status,
  });

  factory FirmData.fromJson(Map<String, dynamic> json) {
    return FirmData(
      firmId: json['firmId'] ?? 0,
      firmName: json['firmName'] ?? "",
      phoneNo: json['phoneNo'],
      personName: json['personName'],
      email: json['email'],
      address: json['address'],
      cityName: json['cityName'],
      stateName: json['stateName'],
      countryName: json['countryName'],
      gstNo: json['gstNo'],
      completeRegStatus: json['completeRegStatus'],
      hdnDrugsyesno: json['hdnDrugsyesno'],
      status: json['status'],
    );
  }
}