import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_management/features/login/data/model/refresh_token_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/invite_project_assign_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/tag/data/model/add_tag.dart';

part 'baseClient.g.dart';

@RestApi(baseUrl: 'http://10.10.10.23:3008/task_app/')
abstract class  ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;
  //
  @POST('signin/')
  Future<LoginModel> login(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('signup/')
  Future<SignUpModel> signUp(
      @Body() HashMap<String, dynamic> hashMap,);

  @POST('forgot_password/')
  Future<ForgotPasswordModel> forgotPassward(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('reset_password/')
  Future<ResetPasswardModel> resetPassward(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('add_new_task/')
  Future<AddTaskModel> addTask(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('delete_task/')
  Future<DeleteTaskModel> deleteTask(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('add_new_note/')
  Future<AddNotesModel> addNote(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('update_task/')
  Future<UpdateTaskModel> updateTask(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('refresh_token/')
  Future<RefreshTokenModel> refreshToken();

  @POST('addnewproject/')
  Future<AddProjectModel> addProject(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('getallprojects/')
  Future<GetAllProjectsModel> getAllPerojects(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('updateproject/')
  Future<UpdateProjectModel> updateProject(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('deleteproject/')
  Future<DeleteProjectModel> deleteProject(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('inviteprojectassignees/')
  Future<InviteProjectAssignModel> inviteProjectAssign(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('add_new_comment/')
  Future<AddCommentModel> addComment(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('update_comment/')
  Future<UpdateCommentModel> updateComment(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('delete_comment/')
  Future<DeleteCommentModel> deleteComment(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('getcomments/')
  Future<GetCommentModel> getComment(
      @Body() HashMap<String, dynamic> hashMap);

  @POST('addtag/')
  Future<AddTagModel> addTag(
      @Body() HashMap<String, dynamic> hashMap);
/*  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
 // final Dio _dio = Dio();
  String api = "https://8ebf-180-211-112-179.in.ngrok.io/";

  @POST('task_app/')
  Future<LoginModel> login(String email, String password) async {
  *//*  BaseOptions options = BaseOptions(
      baseUrl: api,
      connectTimeout: 10000,
      receiveTimeout: 10000,);
    final dioClient = Dio(options);
    final params = <String, dynamic>{
      'email': email,
      'password': password,
    };*//*
    try {
      Response response = await _dio.post(
        "signin",
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTc4NjMxOTMsImVtYWlsIjoicmVlY2hhLnBhdGVsQHJhZGl4d2ViLmNvbSIsInBhc3N3b3JkIjoiUmFkaXh3ZWJAMTUifQ.7FyEWh4Wx1bMwJvZRqz7T9et2MWGfh_7yflT_JDbZLE',
          },),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }*/

}