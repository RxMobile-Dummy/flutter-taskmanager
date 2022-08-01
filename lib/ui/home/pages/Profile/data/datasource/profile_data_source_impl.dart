import 'dart:collection';
import 'dart:io';


import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as pathManager;

class UpdateProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient _apiClient;

  UpdateProfileDataSourceImpl(this._apiClient);

  @override
  Future<UpdateUserProfileModel> updateUserProfileCall(UpdateProfileParams params) async {
    var map = new HashMap<String, dynamic>();

    /*List multipartArray = [];

    for (var i = 0; i < params.profile_pic!.length; i++){
      multipartArray.add(MultipartFile.fromFileSync(params.profile_pic![i], filename:
      pathManager.basename(params.profile_pic![i])));
    }*/

    List<MultipartFile> multipartImageList = [];
    List<File> fileList = [];
    
    if(params.profile_pic!.isNotEmpty) {
      if(!params.profile_pic![0].contains("static")) {
        MultipartFile multipartFile =
        await MultipartFile.fromFile(params.profile_pic![0], filename: pathManager.basename(params.profile_pic![0]));
        multipartImageList.add(multipartFile);
      }
    }
    
    map['first_name'] = params.first_name;
    map['last_name'] = params.last_name;
    map['email'] = params.email;
    map['mobile_number'] = params.mobile_number;
    map['role'] = params.role;
    map['status_id'] = params.status_id;
    map['profile_pic'] = params.profile_pic!.isNotEmpty ? multipartImageList : params.profile_pic;
    FormData formData = FormData.fromMap(map);
    final response = await _apiClient.updateUserprofile(formData);
    var data;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }



}