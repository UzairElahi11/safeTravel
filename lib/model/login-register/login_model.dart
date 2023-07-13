class LoginModel {
  Data? data;
  String? token;
  int? status;
  String? message;

  LoginModel({this.data, this.token, this.status, this.message});

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? avatar;
  int? apple;
  int? facebook;
  int? google;
  int? onTrip;
  String? createdAt;
  String? updatedAt;
  int? payment;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.avatar,
      this.apple,
      this.facebook,
      this.google,
      this.onTrip,
      this.createdAt,
      this.payment,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    apple = json['apple'];
    facebook = json['facebook'];
    google = json['google'];
    onTrip = json['on_trip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    payment = json["payment"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['avatar'] = avatar;
    data['apple'] = apple;
    data['facebook'] = facebook;
    data['google'] = google;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
