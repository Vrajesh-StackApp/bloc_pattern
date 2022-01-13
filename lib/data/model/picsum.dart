import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Picsum> picsumFromJson(String str) => List<Picsum>.from(json.decode(str).map((x) => Picsum.fromJson(x)));

String picsumToJson(List<Picsum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Picsum extends Equatable {
  Picsum({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  /*factory Picsum.fromJson(Map<String, dynamic> json) => Picsum(
    id: json["id"],
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );*/

  static Picsum fromJson(dynamic json) {
    return Picsum(
      id: json["id"],
      author: json["author"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      downloadUrl: json["download_url"]);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };

  @override
  List<Object?> get props => [
    id,
    author,
    width,
    height,
    url,
    downloadUrl
  ];
}
