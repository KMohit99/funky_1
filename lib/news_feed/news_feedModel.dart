class NewsFeedModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  NewsFeedModel({this.data, this.error, this.statusCode, this.message});

  NewsFeedModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? logo;
  String? userName;
  String? title;
  String? image;
  String? uploadVideo;
  String? description;

  Data(
      {this.id,
        this.logo,
        this.userName,
        this.title,
        this.image,
        this.uploadVideo,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    userName = json['userName'];
    title = json['title'];
    image = json['image'];
    uploadVideo = json['uploadVideo'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['userName'] = this.userName;
    data['title'] = this.title;
    data['image'] = this.image;
    data['uploadVideo'] = this.uploadVideo;
    data['description'] = this.description;
    return data;
  }
}