class ApiError {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors; 

  ApiError({
    required this.message,
    this.statusCode,
    this.errors, 
  });

  

  @override
  String toString() {
    return ' $message ';
  }
}
