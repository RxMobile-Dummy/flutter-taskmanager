class RefreshTokenModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  RefreshTokenModel({this.success, this.data, this.message});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  AccessToken? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] != null
        ? new AccessToken.fromJson(json['access_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accessToken != null) {
      data['access_token'] = this.accessToken!.toJson();
    }
    return data;
  }
}

class AccessToken {
  String? refresh;
  String? access;

  AccessToken({this.refresh, this.access});

  AccessToken.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}