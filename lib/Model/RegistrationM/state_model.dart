class StateResponse {
  final bool success;
  final String message;
  final List<StateModel> data;

  StateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => StateModel.fromJson(e))
          .toList(),
    );
  }
}

class StateModel {
  final int stateId;
  final String stateName;
  final int countryId;
  final int? isActive;

  StateModel({
    required this.stateId,
    required this.stateName,
    required this.countryId,
    this.isActive,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      stateId: json['stateid'] ?? 0,
      stateName: json['state_name'] ?? '',
      countryId: json['countid'] ?? 0,
      isActive: json['isactive'],
    );
  }
}
