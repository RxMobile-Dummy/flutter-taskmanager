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
  String? id;
  String? projectId;
  String? name;
  String? comment;
  String? taskStatus;
  String? description;
  String? isPrivate;
  String? priority;
  String? assigneeId;
  String? reviewerId;
  String? tagId;
  String? startDate;
  String? endDate;

  Data(
      {this.id,
        this.projectId,
        this.name,
        this.comment,
        this.taskStatus,
        this.description,
        this.isPrivate,
        this.priority,
        this.assigneeId,
        this.reviewerId,
        this.tagId,
        this.startDate,
        this.endDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    name = json['name'];
    comment = json['comment'];
    taskStatus = json['task_status'];
    description = json['description'];
    isPrivate = json['is_private'];
    priority = json['priority'];
    assigneeId = json['assignee_id'];
    reviewerId = json['reviewer_id'];
    tagId = json['tag_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['task_status'] = this.taskStatus;
    data['description'] = this.description;
    data['is_private'] = this.isPrivate;
    data['priority'] = this.priority;
    data['assignee_id'] = this.assigneeId;
    data['reviewer_id'] = this.reviewerId;
    data['tag_id'] = this.tagId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}