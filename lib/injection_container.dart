import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/api_call/baseClient.dart';
import 'package:task_management/features/login/domain/repositories/login_repositories.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/get_user_role_usecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/features/login/domain/usecases/sign_up_usecase.dart';
import 'package:task_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source_impl.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/delete_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/update_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/datasource/add_task_data_sourse.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/datasource/add_task_data_sourse_impl.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/repositories/add_task_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/get_task_usecase.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/invite_project_assign_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/update_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source.dart';
import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source_impl.dart';
import 'package:task_management/ui/home/pages/Profile/data/repositories/profile_repositories.dart';
import 'package:task_management/ui/home/pages/Profile/domain/repositories/profile_repositories.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_bloc.dart';
import 'package:task_management/ui/home/pages/Project/data/datasource/project_data_source.dart';
import 'package:task_management/ui/home/pages/Project/data/datasource/project_data_source_impl.dart';
import 'package:task_management/ui/home/pages/Project/data/repositories/project_repositories.dart';
import 'package:task_management/ui/home/pages/Project/domain/repositories/project_repositories.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/delete_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/get_all_projects_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/update_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_bloc.dart';
import 'package:task_management/ui/home/pages/add_member/data/datasource/add_member_data_source.dart';
import 'package:task_management/ui/home/pages/add_member/data/datasource/add_member_data_source_impl.dart';
import 'package:task_management/ui/home/pages/add_member/data/repositories/add_member_repositories.dart';
import 'package:task_management/ui/home/pages/add_member/domain/repositories/add_member_repositories.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/add_member_usecase.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_bloc.dart';
import 'package:task_management/ui/home/pages/comment/data/datasource/comment_data_source.dart';
import 'package:task_management/ui/home/pages/comment/data/datasource/comment_data_source_impl.dart';
import 'package:task_management/ui/home/pages/comment/data/repositories/comment_repositories.dart';
import 'package:task_management/ui/home/pages/comment/domain/repositories/comment_repositories.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/presentation/bloc/comment_bloc.dart';
import 'package:task_management/ui/home/pages/user_status/data/datasource/user_status_data_source.dart';
import 'package:task_management/ui/home/pages/user_status/data/datasource/user_status_data_source_impl.dart';
import 'package:task_management/ui/home/pages/user_status/data/repositories/user_status_repositories.dart';
import 'package:task_management/ui/home/pages/user_status/domain/repositories/user_status_repositories.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_bloc.dart';

import 'core/api_call/custom_dio_client.dart';
import 'features/login/data/datasource/login_data_sourse.dart';
import 'features/login/data/datasource/login_data_sourse_impl.dart';
import 'features/login/data/repositories/login_repositories.dart';
import 'features/login/domain/usecases/login.dart';
import 'ui/home/fab_menu_option/add_task/data/repositories/add_task_repositories.dart';

final Sl = GetIt.instance;

Future<void> init() async {
  var dio = await createDioClient();
  Sl.registerFactory<Dio>(() => dio);

  Sl.registerSingleton(ApiClient(Sl.get()));

  // bloc
  Sl.registerFactory(() => LoginBloc(
      getUserRoleUsecase: Sl.call(),
      loginCase: Sl.call(),
      forgotPasswardUsecase: Sl.call(),
      resetPasswardUsecase: Sl.call(),
      signUpUsecase: Sl.call()));
  Sl.registerFactory(() => UserStatusBloc(getUserStatusUsecase: Sl.call()));
  Sl.registerFactory(() => UpdateProfileBloc(updateProfileUsecase: Sl.call()));
  Sl.registerFactory(() => AddMemberBloc(getMemberUsecase: Sl.call(),inviteProjectAssignUsecase: Sl.call()));
  Sl.registerFactory(() => AddTaskBloc(
      addTaskUsecase: Sl.call(),
      deleteTaskUsecase: Sl.call(),
      updateTaskUsecase: Sl.call(),
      getTaskUsecase: Sl.call()));
  Sl.registerFactory(() => AddNoteBloc(
      addNoteUsecase: Sl.call(),
      getNoteUsecase: Sl.call(),
      updateNoteUsecase: Sl.call(),
      deleteNoteUsecase: Sl.call()));
  Sl.registerFactory(() => ProjectBloc(
      addProjectUsecase: Sl.call(),
      getAllPeojectsUsecase: Sl.call(),
      updateProjectUsecase: Sl.call(),
      deleteProjectUsecase: Sl.call()));
  Sl.registerFactory(() => CommentBloc(
      addCommentUsecase: Sl.call(),
      updateCommentUsecase: Sl.call(),
      deleteCommentUsecase: Sl.call(),
      getCommentUsecase: Sl.call()));
  // Use cases
  Sl.registerLazySingleton(() => LoginCase(loginRepositories: Sl()));
  Sl.registerLazySingleton(() => GetMemberUsecase(addMemberRepositories: Sl()));
  Sl.registerLazySingleton(() => SignUpUsecase(loginRepositories: Sl()));
  Sl.registerLazySingleton(
          () => ForgotPasswardUsecase(loginRepositories: Sl()));
  Sl.registerLazySingleton(() => ResetPasswardUsecase(loginRepositories: Sl()));
  Sl.registerLazySingleton(() => GetUserStatusUsecase(userStatusRepositories: Sl()));
  Sl.registerLazySingleton(() => AddTaskUsecase(addTaskRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateTaskUsecase(addTaskRepositories: Sl()));
  Sl.registerLazySingleton(() => DeleteTaskUsecase(addTaskRepositories: Sl()));
  Sl.registerLazySingleton(() => GetTaskUsecase(addTaskRepositories: Sl()));
  Sl.registerLazySingleton(() => AddNoteUsecase(addNoteRepositories: Sl()));
  Sl.registerLazySingleton(() => AddProjectUsecase(projectRepositories: Sl()));
  Sl.registerLazySingleton(() => GetNoteUsecase(addNoteRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateNoteUsecase(addNoteRepositories: Sl()));
  Sl.registerLazySingleton(() => DeleteNoteUsecase(addNoteRepositories: Sl()));
  Sl.registerLazySingleton(() => GetUserRoleUsecase(loginRepositories: Sl()));
  Sl.registerLazySingleton(() => UpdateProfileUsecase(updateProfileRepositories: Sl()));
  Sl.registerLazySingleton(
          () => InviteProjectAssignUsecase(addMemberRepositories: Sl()));
  Sl.registerLazySingleton(
          () => AddCommentUsecase(addCommentRepositories: Sl()));
  Sl.registerLazySingleton(
          () => UpdateCommentUsecase(addCommentRepositories: Sl()));
  Sl.registerLazySingleton(
          () => DeleteCommentUsecase(addCommentRepositories: Sl()));
  Sl.registerLazySingleton(
          () => GetCommentUsecase(addCommentRepositories: Sl()));
  Sl.registerLazySingleton(
          () => GetAllPeojectsUsecase(projectRepositories: Sl()));
  Sl.registerLazySingleton(
          () => UpdateProjectUsecase(projectRepositories: Sl()));
  Sl.registerLazySingleton(
          () => DeleteProjectUsecase(projectRepositories: Sl()));

  // Repository
  Sl.registerLazySingleton<LoginRepositories>(
        () => LoginRepositoriesImpl(localDataSource: Sl()),
  );

  Sl.registerLazySingleton<AddMemberRepositories>(
        () => AddMemberRepositoriesImpl(addMemberDataSource: Sl()),
  );

  Sl.registerLazySingleton<UpdateProfileRepositories>(
        () => UpdateUserProfileRepositoriesImpl(profileDataSource: Sl()),
  );

  Sl.registerLazySingleton<UserStatusRepositories>(
        () => UserStatusRepositoriesImpl(userStatusDataSource: Sl()),
  );


  Sl.registerLazySingleton<AddTaskRepositories>(
        () => AddTaskRepositoriesImpl(addTaskDataSource: Sl()),
  );

  Sl.registerLazySingleton<AddNoteRepositories>(
        () => AddNotesRepositoriesImpl(addNoteDataSource: Sl()),
  );
  Sl.registerLazySingleton<ProjectRepositories>(
        () => ProjectRepositoriesImpl(projectDataSource: Sl()),
  );
  Sl.registerLazySingleton<AddCommentRepositories>(
        () => AddCommentRepositoriesImpl(addCommentDataSource: Sl()),
  );
/*  Sl.registerLazySingleton<CharRepository>(
        () => CharRepositoryImpl(
        charRemoteDataSource: Sl()),
  );*/

  // Local Data sources
  Sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AddMemberDataSource>(
        () => AddMemberDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<ProfileDataSource>(
        () => UpdateProfileDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<UserStatusDataSource>(
        () => UserStatusDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AddTaskDataSource>(
        () => AddTaskDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AddNoteDataSource>(
        () => AddNotesDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<ProjectDataSource>(
        () => ProjectDataSourceImpl(Sl.get()),
  );

  Sl.registerLazySingleton<AddCommentDataSource>(
        () => AddCommentDataSourceImpl(Sl.get()),
  );

  /*Sl.registerLazySingleton<CharRemoteDataSource>(
        () => CharRemoteDataSourceImpl(),
  );*/
}

Future<Dio> createDioClient() async {
  Dio dio = Dio();
  // Authorization Headers
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString('access');
  Map<String, dynamic> headers = {};
  if (authToken != null && authToken != "") {
    headers["Accept"] = 'application/json';
    headers["Authorization"] = authToken;
  }

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers = headers;
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) async {
        if (authToken != null && authToken != ''){
          request.headers['Authorization'] = 'Bearer $authToken';
        }else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var authToken = prefs.getString('access');
         // var authToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTk2NzI5MTIsImVtYWlsIjoicmVlY2hhOTk5QGdtYWlsLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE3MDA0MjQyOTU0In0.68SG-dqGiFRSsqQJqp0hqlHsSnvtaQhRjREk_OmpSdM";
          Map<String, dynamic> headers = {};
          if (authToken != null && authToken != "") {
            request.headers['Authorization'] = 'Bearer $authToken';
          }
        }
        return handler.next(request);
      },
      onError: (err, handler) async {
        if (err.response?.statusCode == 401) {
          try {
            await refreshTokenCall();
            var authToken = prefs.getString('access');
            if (authToken != null || authToken != "") {
              headers["Accept"] = 'application/json';
              headers["Authorization"] = authToken;
              dio.options.headers = headers;
              dio.interceptors
                  .add(LogInterceptor(responseBody: true, requestBody: true));
            }
          } catch (err, st) {}
        }
      },
    ),
  );
  return dio;
}
