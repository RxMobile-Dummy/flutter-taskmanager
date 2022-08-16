import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/repositories/check_list_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../../../add_note/data/model/add_note_model.dart';

class GetCheckListUsecase extends UseCase<GetCheckListModel, GetCheckListParams> {
  final AddCheckListRepositories? addCheckListRepositories;

  GetCheckListUsecase({this.addCheckListRepositories});

  @override
  Stream<Either<Failure, GetCheckListModel>> call(GetCheckListParams params) {
    return addCheckListRepositories!.getCheckListCall(params);
  }

}

class GetCheckListParams extends Equatable {

  GetCheckListParams();

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}