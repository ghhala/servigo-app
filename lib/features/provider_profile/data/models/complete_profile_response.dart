class CompleteProfileResponse {
  final String message;
  final bool status;

  CompleteProfileResponse({required this.message, required this.status});

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponse(
      message: json['message'] ?? 'Success',
      status: json['status'] ?? true,
    );
  }
}