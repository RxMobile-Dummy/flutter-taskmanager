import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/check_list_repositories.dart';

class UpdateCheckListUsecase extends UseCase<UpdateCheckListModel, UpdateCheckListParams> {
  final AddCheckListRepositories? addCheckListRepositories;

  UpdateCheckListUsecase({this.addCheckListRepositories});

  @override
  Stream<Either<Failure, UpdateCheckListModel>> call(UpdateCheckListParams params) {
    return addCheckListRepositories!.updateCheckListCall(params);
  }

}

class UpdateCheckListParams extends Equatable {
  int id1;
  String is_completed;

  UpdateCheckListParams({required this.id1, required this.is_completed});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id1;
    data['is_completed'] = this.is_completed;
    return data;
  }
}