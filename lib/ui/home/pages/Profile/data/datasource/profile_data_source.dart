import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';

import '../../domain/usecases/update_profile_usecase.dart';

abstract class ProfileDataSource {
  Future<UpdateUserProfileModel> updateUserProfileCall(UpdateProfileParams params);
}