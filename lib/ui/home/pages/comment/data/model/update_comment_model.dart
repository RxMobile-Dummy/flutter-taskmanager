class UpdateCommentModel {
  bool? success;
  Data? data;
  String? message;

  UpdateCommentModel({this.success, this.data, this.message});

  UpdateCommentModel.fromJson(Map<String, dynamic> json) {
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
  String? commentUserId;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<String>? files;

  Data(
      {this.id,
        this.userId,
        this.commentUserId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.files});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    commentUserId = json['comment_user_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    files = json['files'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['comment_user_id'] = this.commentUserId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['files'] = this.files;
    return data;
  }
}