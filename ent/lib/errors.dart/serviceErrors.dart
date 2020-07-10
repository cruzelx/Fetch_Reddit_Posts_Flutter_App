class ErrorFetchingDataException implements Exception {
  String errorMessage() => 'Error Fetching Data';
}

class BadRequestException implements Exception {
  String errorMessage() => 'Bad Request';
}
