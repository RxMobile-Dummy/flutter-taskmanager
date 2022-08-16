class UpdateCheckListModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  UpdateCheckListModel({this.success, this.data, this.message, this.error});

  UpdateCheckListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? title;
  String? color;
  List<OptionsDetails>? optionsDetails;

  Data({this.id, this.userId, this.title, this.color, this.optionsDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    color = json['color'];
    if (json['options_details'] != null) {
      optionsDetails = <OptionsDetails>[];
      json['options_details'].forEach((v) {
        optionsDetails!.add(new OptionsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['color'] = this.color;
    if (this.optionsDetails != null) {
      data['options_details'] =
          this.optionsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionsDetails {
  int? id;
  String? userId;
  String? checklistId;
  String? checklistDetail;
  bool? isCompleted;

  OptionsDetails(
      {this.id,
        this.userId,
        this.checklistId,
        this.checklistDetail,
        this.isCompleted});

  OptionsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    checklistId = json['checklist_id'];
    checklistDetail = json['checklist_detail'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['checklist_id'] = this.checklistId;
    data['checklist_detail'] = this.checklistDetail;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}