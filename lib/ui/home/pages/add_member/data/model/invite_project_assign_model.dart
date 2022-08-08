class InviteProjectAssignModel {
  String? message;
  String? error;
  bool? status;

  InviteProjectAssignModel({this.message, this.status,this.error});

  InviteProjectAssignModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}