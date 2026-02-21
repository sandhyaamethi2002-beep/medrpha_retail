class CityResponse {
  final bool success;
  final String message;
  final List<CityModel> data;

  CityResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    return CityResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => CityModel.fromJson(e))
          .toList(),
    );
  }
}

class CityModel {
  final int cityId;
  final String cityName;
  final int stateId;
  final int countryId;
  final int? isActive;

  CityModel({
    required this.cityId,
    required this.cityName,
    required this.stateId,
    required this.countryId,
    this.isActive,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['cityid'],
      cityName: json['city_name'],
      stateId: json['statid'],
      countryId: json['counttid'],
      isActive: json['isactive'],
    );
  }
}
