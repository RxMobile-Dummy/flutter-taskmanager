class SignUpModel {
  bool? success;
  Data? data;
  String? message;

  SignUpModel({this.success, this.data, this.message});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
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
  String? role;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.statusId,
        this.profilePic,
        this.email,
        this.mobileNumber,
        this.role,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    statusId = json['status_id'];
    profilePic = json['profile_pic'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}