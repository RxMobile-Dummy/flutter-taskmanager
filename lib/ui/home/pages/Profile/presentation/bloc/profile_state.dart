import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class UpdateProfileState extends BaseState {
  UpdateUserProfileModel? model;

  UpdateProfileState({this.model});
}


class UpdatedProfileDataState extends BaseState {
  Map<String, dynamic>? userData;

  UpdatedProfileDataState({this.userData});
}