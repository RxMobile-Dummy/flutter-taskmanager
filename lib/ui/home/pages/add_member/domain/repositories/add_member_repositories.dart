import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../data/model/invite_project_assign_model.dart';
import '../usecases/add_member_usecase.dart';
import '../usecases/invite_project_assign_usecase.dart';

abstract class AddMemberRepositories {
  Stream<Either<Failure, AddMemberModel>> addMemberCall(AddMemberParams params);
  Stream<Either<Failure, InviteProjectAssignModel>> inviteProjectAssignCall(InviteProjectAssignParams params);
}