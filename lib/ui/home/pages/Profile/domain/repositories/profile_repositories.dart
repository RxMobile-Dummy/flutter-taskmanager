import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/update_profile_usecase.dart';

abstract class UpdateProfileRepositories {
  Stream<Either<Failure, UpdateUserProfileModel>> updateProfileCall(UpdateProfileParams params);
}