import 'package:tracking_app_demo/data/models/response/user_res.dart';

class NotificationRes {
  int? id;
  int? date;
  String? title;
  String? body;
  String? type;
  UserRes? user;

  NotificationRes(
      {this.id, this.date, this.title, this.body, this.type, this.user});

  NotificationRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['user'] = this.user;
    return data;
  }
}