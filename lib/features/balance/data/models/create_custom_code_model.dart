class CustomCodeModel {
  bool? status;
  String? message;
  String? messageAr;

  CustomCodeModel({this.status, this.message, this.messageAr});

  CustomCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    messageAr = json['message_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['message_ar'] = this.messageAr;
    return data;
  }
}
