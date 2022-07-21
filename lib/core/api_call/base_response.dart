import 'dart:convert';

import 'package:dio/dio.dart';


BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.message,
    this.statusCode,
    this.errorMessage,
    this.data,
  });

  String? message;
  int? statusCode;
  String? errorMessage;
  dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    message: json["Message"],
    statusCode: json["StatusCode"],
    errorMessage: json["errorMessage"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "errorMessage": errorMessage,
    "data": data.toJson(),
  };
}



enum Status { loading, completed, error }

class ApiResponse {
  Status status;
  BaseResponse? baseResponse;
  String? errMessage;

  ApiResponse(
      {required this.status,
        this.baseResponse,
        this.errMessage});

  static Future<ApiResponse?> parse(dynamic value) async {
    try {
      if (value is Response) {
        if (value.data is List<dynamic>) {
          BaseResponse(message: '', statusCode: 200, data: value.data);
          return ApiResponse(
              status: Status.completed,
              baseResponse:
              BaseResponse(message: '', statusCode: 200, data: value.data));
        } else {
          return ApiResponse(
              status: Status.completed,
              baseResponse:
              BaseResponse(message: '', statusCode: 200, data: value.data));
        }
      } else if (value is DioError) {
        var errorMsg = DioErrorHandler.dioErrorToString(value);
        return ApiResponse(status: Status.error, errMessage: errorMsg);
      } else {
        return ApiResponse(
            status: Status.error, errMessage: 'Something went wrong!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  String toString() {
    return "Status : $status \n Message : $errMessage \n Data : ${baseResponse?.data}";
  }
}

class DioErrorHandler {
  static String? dioErrorToString(DioError dioError) {
    String? errorMessage;
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        errorMessage =
        "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout in connection with API server";
        break;
      case DioErrorType.sendTimeout:
        errorMessage =
        "Send timeout in connection with API server";
        break;
      case DioErrorType.response:
        errorMessage = _errorBaseOnHttpStatusCode(dioError);
        break;
      case DioErrorType.other:
        errorMessage =
        "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.cancel:
        errorMessage =
        "Request to API server was cancelled";
        break;
    }
    return errorMessage;
  }

  static String _errorBaseOnHttpStatusCode(DioError dioError) {
    String errorText;
    if (dioError.response != null) {
      if (dioError.response!.statusCode == 401) {
        errorText =
        "Something went wrong, please close the app and login again.";
      } else if (dioError.response!.statusCode == 404) {
        errorText =
        "Something went wrong, please close the app and login again.";
      } else if (dioError.response!.statusCode == 500) {
        errorText = "We couldn't connect to the product server";
      } else if (dioError.response!.statusCode == 400) {
        if (dioError.response?.data != '') {
          var data = jsonDecode(dioError.response?.data);
          if (data != null) {
            errorText = data['errors']['Error Message'][0];
          } else {
            errorText =
            "Something went wrong, please close the app and login again.";
          }
        } else {
          errorText =
          "Something went wrong, please close the app and login again.";
        }
      } else {
        errorText =
        "Something went wrong, please close the app and login again.";
      }
    } else {
      errorText = "Something went wrong, please close the app and login again.";
    }
    return errorText;
  }
}

