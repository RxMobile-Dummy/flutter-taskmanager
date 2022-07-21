class UpdateProjectModel {
  bool? success;
  Data? data;
  String? message;

  UpdateProjectModel({this.success, this.data, this.message});

  UpdateProjectModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? color;
  String? name;
  String? description;
  String? statusId;
  String? duration;
  String? createdAt;
  String? updatedAt;
  bool? isPrivate;
  bool? archive;

  Data(
      {this.id,
        this.userId,
        this.color,
        this.name,
        this.description,
        this.statusId,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.isPrivate,
        this.archive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    color = json['color'];
    name = json['name'];
    description = json['description'];
    statusId = json['status_id'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPrivate = json['is_private'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['color'] = this.color;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status_id'] = this.statusId;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_private'] = this.isPrivate;
    data['archive'] = this.archive;
    return data;
  }
}