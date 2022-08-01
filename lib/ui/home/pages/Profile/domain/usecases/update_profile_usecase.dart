

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/repositories/profile_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class UpdateProfileUsecase extends UseCase<UpdateUserProfileModel, UpdateProfileParams> {
  final UpdateProfileRepositories? updateProfileRepositories;

  UpdateProfileUsecase({this.updateProfileRepositories});

  @override
  Stream<Either<Failure, UpdateUserProfileModel>> call(UpdateProfileParams params) {
    return updateProfileRepositories!.updateProfileCall(params);
  }



}

class UpdateProfileParams extends Equatable {
  String first_name;
  String last_name;
  String email;
  String mobile_number;
  int role;
  int status_id;
  List<String>? profile_pic;

  UpdateProfileParams({
    required this.status_id,
    required this.role,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.mobile_number,
    required this.profile_pic,
});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    return data;
  }
}