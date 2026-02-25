class GetFirmDetailModel {
  final bool success;
  final FirmData data;

  GetFirmDetailModel({
    required this.success,
    required this.data,
  });

  factory GetFirmDetailModel.fromJson(Map<String, dynamic> json) {
    return GetFirmDetailModel(
      success: json['success'] ?? false,
      data: FirmData.fromJson(json['data']),
    );
  }
}

class FirmData {
  final int firmId;
  final String firmName;
  final String gstNo;
  final String phoneNo;
  final String address;
  final String personName;
  final String alternateNumber;
  final String fssaiNo;

  FirmData({
    required this.firmId,
    required this.firmName,
    required this.gstNo,
    required this.phoneNo,
    required this.address,
    required this.personName,
    required this.alternateNumber,
    required this.fssaiNo,
  });

  factory FirmData.fromJson(Map<String, dynamic> json) {
    return FirmData(
      firmId: json['firm_id'] ?? 0,
      firmName: json['firm_name'] ?? "",
      gstNo: json['gstno'] ?? "",
      phoneNo: json['phoneno'] ?? "",
      address: json['address'] ?? "",
      personName: json['personName'] ?? "",
      alternateNumber: json['alternateNumber'] ?? "",
      fssaiNo: json['fssaiNo'] ?? "",
    );
  }
}