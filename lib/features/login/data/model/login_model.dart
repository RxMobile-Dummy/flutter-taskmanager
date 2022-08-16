class LoginModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  LoginModel({this.success, this.data, this.message,this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? statusId;
  String? profilePic;
  String? email;
  String? mobileNumber;
  String? role_id;
  String? createdAt;
  String? updatedAt;
  AuthenticationToken? authenticationToken;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.statusId,
        this.profilePic,
        this.email,
        this.mobileNumber,
        this.role_id,
        this.createdAt,
        this.updatedAt,
        this.authenticationToken
       });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    statusId = json['status_id'];
    profilePic = json['profile_pic'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    role_id = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    authenticationToken = json['authentication_token'] != null
        ? new AuthenticationToken.fromJson(json['authentication_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['status_id'] = this.statusId;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['role_id'] = this.role_id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.authenticationToken != null) {
      data['authentication_token'] = this.authenticationToken!.toJson();
    }
    return data;
  }
}

class AuthenticationToken {
  String? refresh;
  String? access;

  AuthenticationToken({this.refresh, this.access});

  AuthenticationToken.fromJson(Map<String, dynamic> json) {
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