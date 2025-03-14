
import 'package:googleapis/blogger/v3.dart';

class ImageRes {
  int? id;
  String? contentType;
  int? contentSize;
  String? name;
  Null? extension;
  String? filePath;
  bool? isVideo;
  Post? posts;

  ImageRes(
      {this.id,
        this.contentType,
        this.contentSize,
        this.name,
        this.extension,
        this.filePath,
        this.isVideo,
        this.posts});

  ImageRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['contentType'];
    contentSize = json['contentSize'];
    name = json['name'];
    extension = json['extension'];
    filePath = json['filePath'];
    isVideo = json['isVideo'];
    posts = json['posts']  != null ? Post.fromJson(json['posts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contentType'] = contentType;
    data['contentSize'] = contentSize;
    data['name'] = name;
    data['extension'] = extension;
    data['filePath'] = filePath;
    data['isVideo'] = isVideo;
    if(posts != null) {
      data['posts'] = posts!.toJson();
    }
    return data;
  }
}