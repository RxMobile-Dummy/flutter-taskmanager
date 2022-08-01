import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';
import 'package:task_management/ui/home/pages/add_member/domain/repositories/add_member_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class GetMemberUsecase extends UseCase<AddMemberModel,AddMemberParams> {
  final AddMemberRepositories? addMemberRepositories;

  GetMemberUsecase({this.addMemberRepositories});

  @override
  Stream<Either<Failure, AddMemberModel>> call(AddMemberParams params) {
    return addMemberRepositories!.addMemberCall(params);
  }

}

class AddMemberParams extends Equatable {

  AddMemberParams();

  @override
  List<Object> get props => [id];

}