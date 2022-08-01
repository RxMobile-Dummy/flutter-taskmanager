import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class GetUserStatusState extends BaseState {
  GetUserStatusModel? model;

  GetUserStatusState({this.model});
}