import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/pages/add_member/data/datasource/add_member_data_source.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';
import 'package:task_management/ui/home/pages/add_member/domain/repositories/add_member_repositories.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/add_member_usecase.dart';

import '../../domain/usecases/invite_project_assign_usecase.dart';
import '../model/invite_project_assign_model.dart';

class AddMemberRepositoriesImpl extends AddMemberRepositories {
  AddMemberDataSource? addMemberDataSource;

  AddMemberRepositoriesImpl({
    this.addMemberDataSource,
  });





  @override
  Stream<Either<Failure, AddMemberModel>> addMemberCall(AddMemberParams params) async* {
    try {
      var response = await addMemberDataSource!.addMemberCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, InviteProjectAssignModel>> inviteProjectAssignCall(InviteProjectAssignParams params) async* {
    try {
      var response = await addMemberDataSource!.inviteProjectAssignCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }




}