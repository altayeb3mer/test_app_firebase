import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataModel with ChangeNotifier {
  String description;
  String src;
  String date;
  String imgUrl;

  DataModel({this.description, this.src, this.date, this.imgUrl});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        description: json["description"],
        src: json["src"],
        date: json["date"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "src": src,
        "date": date,
        "imgUrl": imgUrl,
      };
}
