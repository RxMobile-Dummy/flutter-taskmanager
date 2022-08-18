import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class UpdateProfileEvent extends BaseEvent {
  String first_name;
  String last_name;
  String email;
  String mobile_number;
  int role;
  int status_id;
  List<String>? profile_pic;

  UpdateProfileEvent({
    required this.status_id,
    required this.role,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.mobile_number,
    required this.profile_pic,
  });
}

class UpdateProfileSuccessEvent extends BaseEvent {
  UpdateUserProfileModel? model;

  UpdateProfileSuccessEvent({this.model});
}

class UpdatedUserDataGetSuccessEvent extends BaseEvent {
}

class UpdatedUserDataGetEvent extends BaseEvent{

}