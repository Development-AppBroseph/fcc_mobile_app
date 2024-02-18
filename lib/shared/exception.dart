final class ServerException {
  final String message;

  ServerException({required this.message});

  @override
  String toString() {
    return message;
  }
}
