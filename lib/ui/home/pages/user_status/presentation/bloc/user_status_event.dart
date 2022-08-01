import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class GetUserStatusEvent extends BaseEvent {


  GetUserStatusEvent();
}

class GetUserStatusSuccessEvent extends BaseEvent {
  GetUserStatusModel? model;

  GetUserStatusSuccessEvent({this.model});
}
