import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/repositories/check_list_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../../../add_note/data/model/add_note_model.dart';

class AddCheckListUsecase extends UseCase<AddCheckListModel, AddCheckListParams> {
  final AddCheckListRepositories? addCheckListRepositories;

  AddCheckListUsecase({this.addCheckListRepositories});

  @override
  Stream<Either<Failure, AddCheckListModel>> call(AddCheckListParams params) {
    return addCheckListRepositories!.addCheckListCall(params);
  }

}

class AddCheckListParams extends Equatable {
  String title;
  List<String> options;
  String? color;

  AddCheckListParams({required this.title,required this.options,required this.color});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['options'] = this.options;
    data['color'] = this.color;

    return data;
  }
}