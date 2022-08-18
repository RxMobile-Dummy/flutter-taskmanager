
import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/repositories/profile_repositories.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';
import '../../../../../../core/failure/error_object.dart';

class UpdateUserProfileRepositoriesImpl extends UpdateProfileRepositories {
  ProfileDataSource? profileDataSource;

  UpdateUserProfileRepositoriesImpl({
    this.profileDataSource,
  });

  @override
  Stream<Either<Failure, UpdateUserProfileModel>> updateProfileCall(UpdateProfileParams params) async*{
    try {
      var response = await profileDataSource!.updateUserProfileCall(params);
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