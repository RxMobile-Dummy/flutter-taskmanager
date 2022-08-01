import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/repositories/profile_repositories.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';

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
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }


}