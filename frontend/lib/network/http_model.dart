import 'package:flutter/cupertino.dart';

class Post {
  late String status;
  late int statusCode;
  late String version;
  late String access;
  late List<Data> data;

  Post({required this.status, required this.statusCode, required this.version, required this.access, required this.data});

  Post.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status-code'];
    version = json['version'];
    access = json['access'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status-code'] = this.statusCode;
    data['version'] = this.version;
    data['access'] = this.access;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late int id;
  late String title;
  late String summary;
  late String link;
  late String published;
  late String image;

  Data(
      {required this.id,
        required this.title,
        required this.summary,
        required this.link,
        required this.published,
        required this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'].toString();
    link = json['link'];
    published = json['published'];
    image = json['image'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['link'] = this.link;
    data['published'] = this.published;
    data['image'] = this.image;
    return data;
  }
}