class CountryResponse {
  final bool success;
  final String message;
  final List<Country> data;

  CountryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => Country.fromJson(e))
          .toList(),
    );
  }
}

class Country {
  final int countryId;
  final String countryName;
  final String? countryCode;
  final int isActive;

  Country({
    required this.countryId,
    required this.countryName,
    this.countryCode,
    required this.isActive,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['countryid'],
      countryName: json['country_name'],
      countryCode: json['country_code'],
      isActive: json['isactive'],
    );
  }
}
