// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.10.10.23:3008/task_app/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginModel> login(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'signin/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUpModel> signUp(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignUpModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'signup/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUpModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPasswordModel> forgotPassward(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPasswordModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'forgot_password/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPasswordModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswardModel> resetPassward(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswardModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'reset_password/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetPasswardModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddTaskModel> addTask(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddTaskModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'add_new_task/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddTaskModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteTaskModel> deleteTask(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteTaskModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'delete_task/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteTaskModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddNotesModel> addNote(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddNotesModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'add_new_note/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddNotesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateTaskModel> updateTask(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateTaskModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'update_task/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateTaskModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RefreshTokenModel> refreshToken() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RefreshTokenModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'refresh_token/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RefreshTokenModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddProjectModel> addProject(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddProjectModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'addnewproject/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddProjectModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllProjectsModel> getAllPerojects(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllProjectsModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'getallprojects/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllProjectsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateProjectModel> updateProject(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateProjectModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'updateproject/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateProjectModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteProjectModel> deleteProject(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteProjectModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'deleteproject/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteProjectModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InviteProjectAssignModel> inviteProjectAssign(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InviteProjectAssignModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'inviteprojectassignees/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InviteProjectAssignModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddCommentModel> addComment(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCommentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'add_new_comment/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddCommentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateCommentModel> updateComment(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateCommentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'update_comment/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateCommentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteCommentModel> deleteComment(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteCommentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'delete_comment/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteCommentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCommentModel> getComment(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCommentModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'getcomments/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCommentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddTagModel> addTag(hashMap) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(hashMap);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddTagModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'addtag/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddTagModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
