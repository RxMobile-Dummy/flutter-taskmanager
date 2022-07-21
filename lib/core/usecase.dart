import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failure/failure.dart';

abstract class UseCase<LoginModel, T> {
  Stream<Either<Failure, LoginModel>> call(T params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
