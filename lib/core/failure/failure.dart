import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  String message = "";
  ServerFailure(this.message) : super('');
}
class InternetFailure extends Failure {
  String message = "";
  InternetFailure(this.message) : super('');
}

class ServerFailureMessage extends Failure {
  String message;
  ServerFailureMessage(this.message) : super('');
}


class FailureMessage extends Failure {
  String message;
  FailureMessage(this.message) : super('');
}


class CacheFailure extends Failure {
  const CacheFailure() : super('');
}
class AuthFailure extends Failure {
  const AuthFailure() : super('');
}
