import 'dart:io';
import 'package:http/http.dart' as http;

sealed class Failure {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  const Failure(this.message, {this.error, this.stackTrace});
  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {Object? error, StackTrace? stackTrace})
      : super(message, error: error, stackTrace: stackTrace);
}

class ServerFailure extends Failure {
  final int statusCode;
  const ServerFailure(this.statusCode, String message,
      {Object? error, StackTrace? stackTrace})
      : super(message, error: error, stackTrace: stackTrace);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message, {Object? error, StackTrace? stackTrace})
      : super(message, error: error, stackTrace: stackTrace);
}

Failure mapHttpError(http.Response res) {
  final code = res.statusCode;
  return ServerFailure(code, 'Error HTTP $code');
}

Failure failureFromException(Object e, [StackTrace? st]) {
  if (e is SocketException) {
    return NetworkFailure('Sin conexión a internet', error: e, stackTrace: st);
  }
  if (e is HttpException) {
    return ServerFailure(-1, 'Error HTTP', error: e, stackTrace: st);
  }
  if (e is TlsException) {
    return NetworkFailure('Problema SSL/TLS', error: e, stackTrace: st);
  }
  return UnknownFailure('Ocurrió un error inesperado', error: e, stackTrace: st);
}
