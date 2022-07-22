class GetCommentModel {
  bool? success;
  List<Data>? data;
  String? message;

  GetCommentModel({this.success, this.data, this.message});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? commentUserId;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? files;
  UserData? userData;

  Data(
      {this.id,
        this.userId,
        this.commentUserId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.files,
        this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    commentUserId = json['comment_user_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['files'] != null) {
      files = <dynamic>[];
      json['files'].forEach((v) {
        files!.add(v);
      });
    }
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['comment_user_id'] = this.commentUserId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? firstName;
  String? userId;
  String? lastName;
  String? statusId;
  String? profilePic;
  String? email;
  String? mobileNumber;
  String? password;
  String? role;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  bool? isDelete;

  UserData(
      {this.id,
        this.firstName,
        this.userId,
        this.lastName,
        this.statusId,
        this.profilePic,
        this.email,
        this.mobileNumber,
        this.password,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.isDelete});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    userId = json['user_id'];
    lastName = json['last_name'];
    statusId = json['status_id'];
    profilePic = json['profile_pic'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    password = json['password'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['user_id'] = this.userId;
    data['last_name'] = this.lastName;
    data['status_id'] = this.statusId;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['password'] = this.password;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    return data;
  }
}