part of 'base_bloc.dart';

abstract class BaseState {}

class Uninitialized extends BaseState {}

class Authenticated extends BaseState {}

class Unauthenticated extends BaseState {}

class StateInitial extends BaseState {}

class StateLoading extends BaseState {}

class StateNoData extends BaseState {}

class StateShowSearching extends BaseState {}

class StateSearchResult<T> extends BaseState {
  T response;

  StateSearchResult(this.response);
}

class StateInternetError extends BaseState {}

class StateError400 extends BaseState {}

class StateAuthError extends BaseState {}

class StateErrorServer extends BaseState {}

class StateOnSuccess<T> extends BaseState {
  T response;

  StateOnSuccess(this.response);
}

class ValidationError extends BaseState {
  String errorMessage;

  ValidationError(this.errorMessage);
}

class StateErrorGeneral extends BaseState {
  String errorMessage;

  StateErrorGeneral(this.errorMessage);
}

class StatePaginationSuccess extends BaseState implements Equatable {
  List data;
  bool isEndOfList;
  int index;
  int limit;
  bool isServerError;
  bool isInternetError;

  StatePaginationSuccess(this.data, this.isEndOfList, this.index, this.limit,
      {this.isServerError = false, this.isInternetError = false});

  StatePaginationSuccess copyWith({
    List? data,
    bool? isEndOfList,
    int? offset,
    int? limit,
    bool? isServerError,
    bool? isInternetError,
  }) =>
      StatePaginationSuccess(
        data ?? this.data,
        isEndOfList ?? this.isEndOfList,
        offset ?? this.index,
        limit ?? this.limit,
        isServerError: isServerError ?? this.isServerError,
        isInternetError: isInternetError ?? this.isInternetError,
      );

  @override
// TODO: implement props
  List<Object> get props => [data, isEndOfList, isServerError, isInternetError];

  @override
// TODO: implement stringify
  bool? get stringify => null;
}

class StatePaginationInternetError<T> extends BaseState {
  T response;

  StatePaginationInternetError(this.response);
}

class StatePaginationServerError<T> extends BaseState {
  T response;

  StatePaginationServerError(this.response);
}

class StateOnResponseSuccess<T> extends BaseState {
  T response;

  StateOnResponseSuccess(this.response);
}

