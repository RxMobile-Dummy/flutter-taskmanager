
import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/user_status/data/datasource/user_status_data_source.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/repositories/user_status_repositories.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';
import '../../../../../../core/failure/error_object.dart';
import '../../../../../../core/failure/failure.dart';



class UserStatusRepositoriesImpl extends UserStatusRepositories {
  UserStatusDataSource? userStatusDataSource;

  UserStatusRepositoriesImpl({
    this.userStatusDataSource,
  });

  @override
  Stream<Either<Failure, GetUserStatusModel>> getUserStatusCall(GetUserStatusParams params) async* {
    try {
      var response = await userStatusDataSource!.getUserStatusCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

}
