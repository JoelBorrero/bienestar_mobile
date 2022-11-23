String? isNotEmpty(dynamic value, String message) {
  if (value == null || (value.runtimeType == String && value.isEmpty)) {
    return message;
  }
  return null;
}
