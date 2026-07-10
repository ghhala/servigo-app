import 'package:servi_go_app/features/home/data/models/home_response_model.dart';

class SubServicesResponse {
  final bool success;
  final String message;
  final List<SubService> subServices;

  SubServicesResponse({
    required this.success,
    required this.message,
    required this.subServices,
  });

  factory SubServicesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['sub_services'] as List;
    List<SubService> subServicesList = list
        .map((i) => SubService.fromJson(i))
        .toList();

    return SubServicesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      subServices: subServicesList,
    );
  }
}
