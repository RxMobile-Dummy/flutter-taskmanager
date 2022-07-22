/*
class UpdateTaskModel {
  bool? success;
  Data? data;
  String? message;

  UpdateTaskModel({this.success, this.data, this.message});

  UpdateTaskModel.fromJson(Map<String, dynamic> json) {
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
  String? projectId;
  String? name;
  String? comment;
  String? description;
  String? taskStatus;
  String? priority;
  String? createdAt;
  String? updatedAt;
  bool? isPrivate;
  String? tagId;
  String? reviewerId;
  String? assigneeId;
  String? startDate;
  String? endDate;

  Data(
      {this.id,
        this.userId,
        this.projectId,
        this.name,
        this.comment,
        this.description,
        this.taskStatus,
        this.priority,
        this.createdAt,
        this.updatedAt,
        this.isPrivate,
        this.tagId,
        this.reviewerId,
        this.assigneeId,
        this.startDate,
        this.endDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    projectId = json['project_id'];
    name = json['name'];
    comment = json['comment'];
    description = json['description'];
    taskStatus = json['task_status'];
    priority = json['priority'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPrivate = json['is_private'];
    tagId = json['tag_id'];
    reviewerId = json['reviewer_id'];
    assigneeId = json['assignee_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }*/
