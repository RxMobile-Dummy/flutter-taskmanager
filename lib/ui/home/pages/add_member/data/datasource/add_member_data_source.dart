import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';

import '../../domain/usecases/add_member_usecase.dart';
import '../../domain/usecases/invite_project_assign_usecase.dart';
import '../model/invite_project_assign_model.dart';

abstract class AddMemberDataSource {
  Future<AddMemberModel> addMemberCall(AddMemberParams params);
  Future<InviteProjectAssignModel> inviteProjectAssignCall(InviteProjectAssignParams params);
}