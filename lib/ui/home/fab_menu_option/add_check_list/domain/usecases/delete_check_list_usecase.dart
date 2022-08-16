import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/check_list_repositories.dart';

class DeleteCheckListUsecase extends UseCase<DeleteCheckListModel, DeleteCheckListParams> {
  final AddCheckListRepositories? addCheckListRepositories;

  DeleteCheckListUsecase({this.addCheckListRepositories});

  @override
  Stream<Either<Failure, DeleteCheckListModel>> call(DeleteCheckListParams params) {
    return addCheckListRepositories!.deleteCheckListCall(params);
  }

}

class DeleteCheckListParams extends Equatable {
  String? id1;

  DeleteCheckListParams({required this.id1});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id1'] = this.id1;

    return data;
  }
}