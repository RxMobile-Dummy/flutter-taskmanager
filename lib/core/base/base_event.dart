part of 'base_bloc.dart';

class BaseEvent {}

class AppStarted extends BaseEvent {}

class LoggedOut extends BaseEvent {}

class EventLoading extends BaseEvent {}

class EventNoData extends BaseEvent {}

class EventShowSearching extends BaseEvent {}

class EventError400 extends BaseEvent {}

class EventErrorServer extends BaseEvent {}

class EventInternetError extends BaseEvent {}

class EventOnSuccess<T> extends BaseEvent {
  T response;
  EventOnSuccess(this.response);
}

class ResponseEvent<T> extends BaseEvent {
  T response;
  ResponseEvent(this.response);
}

class SaveEvent<T> extends BaseEvent {
  T response;
  SaveEvent(this.response);
}

class EventRequest<T> extends BaseEvent {
  T request;
  EventRequest(this.request);
}

class EventErrorGeneral extends BaseEvent {
  String message;
  EventErrorGeneral(this.message);
}

class EventValidationError extends BaseEvent {
  String errorMessage;
  EventValidationError(this.errorMessage);
}

/*
* only for pagination
* */
class PaginationSuccess<T> extends BaseEvent {
  T response;
  PaginationSuccess(this.response);
}

class PaginationSuccessOnUpdate<T,I> extends BaseEvent {
  T response;
  I index;
  PaginationSuccessOnUpdate(this.response,this.index);
}

class DeletePaginationSuccess<T> extends BaseEvent {
  T response;
  T index;
  DeletePaginationSuccess(this.response,this.index);
}

class PaginationInternetError extends BaseEvent {
  PaginationInternetError();
}

class PaginationServerError extends BaseEvent {
  PaginationServerError();
}

class PaginationEmpty<T> extends BaseEvent {
  T response;
  PaginationEmpty(this.response);
}

class EventLogout extends BaseEvent {
  EventLogout();
}

class PaginationError<T> extends BaseEvent {
  T response;
  PaginationError(this.response);
}

class PaginationReset<T> extends BaseEvent {
  T request;
  PaginationReset(this.request);
}
class EventResponseOnSuccess<T> extends BaseEvent {
  T response;
  EventResponseOnSuccess(this.response);
}