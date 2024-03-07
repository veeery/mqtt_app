class ServerException implements Exception {

}

class ConnectionException implements Exception {
  final String message;

  ConnectionException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}