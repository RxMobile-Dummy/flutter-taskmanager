import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';

import '../../domain/usecases/update_profile_usecase.dart';

abstract class ProfileDataSource {
  Future<UpdateUserProfileModel> updateUserProfileCall(UpdateProfileParams params);
}