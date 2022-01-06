import 'package:equatable/equatable.dart';

enum NotifierState { initial, loading, loaded}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}



abstract class Failures extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failures {}

class CacheFailure extends Failures {}


class ServerException implements Exception{}
class CacheException implements Exception {}