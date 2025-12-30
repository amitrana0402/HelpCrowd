class ApiErrorModel {
  final String message;
  final Map<String, List<String>>? errors;
  final int? statusCode;

  ApiErrorModel({
    required this.message,
    this.errors,
    this.statusCode,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json, int? statusCode) {
    return ApiErrorModel(
      message: json['message'] ?? 'An error occurred',
      errors: json['errors'] != null
          ? Map<String, List<String>>.from(
              json['errors'].map(
                (key, value) => MapEntry(
                  key,
                  List<String>.from(value),
                ),
              ),
            )
          : null,
      statusCode: statusCode,
    );
  }

  // Get first error message for a specific field
  String? getFieldError(String fieldName) {
    if (errors == null || !errors!.containsKey(fieldName)) {
      return null;
    }
    final fieldErrors = errors![fieldName];
    return fieldErrors != null && fieldErrors.isNotEmpty
        ? fieldErrors.first
        : null;
  }

  // Get all error messages as a single string
  String getAllErrors() {
    if (errors == null || errors!.isEmpty) {
      return message;
    }

    final errorMessages = <String>[];
    errors!.forEach((key, value) {
      errorMessages.addAll(value);
    });

    return errorMessages.join(', ');
  }
}

