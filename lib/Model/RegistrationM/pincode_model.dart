class PincodeResponse {
  final bool success;
  final String message;
  final List<PincodeModel> data;

  PincodeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PincodeResponse.fromJson(Map<String, dynamic> json) {
    return PincodeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => PincodeModel.fromJson(e))
          .toList(),
    );
  }
}


class PincodeModel {
  final int areaid;
  final int counttid;
  final int statid;
  final int cityid;
  final String areaName;
  final int commission;
  final int comid;

  PincodeModel({
    required this.areaid,
    required this.counttid,
    required this.statid,
    required this.cityid,
    required this.areaName,
    required this.commission,
    required this.comid,
  });

  factory PincodeModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return PincodeModel(
      areaid: parseInt(json['areaid']),
      counttid: parseInt(json['counttid']),
      statid: parseInt(json['statid']),
      cityid: parseInt(json['cityid']),
      areaName: json['area_name'] ?? '',
      commission: parseInt(json['commission']),
      comid: parseInt(json['comid']),
    );
  }
}