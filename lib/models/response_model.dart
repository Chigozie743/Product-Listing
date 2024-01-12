import 'package:flutter/material.dart';

class ResponseModel with ChangeNotifier {
  String? accessToken;
  String? refreshToken;

  ResponseModel({this.accessToken, this.refreshToken});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }

  static List<ResponseModel> responseFromSnapshot(List usersSnapshot){
    return usersSnapshot.map((data) {
      return ResponseModel.fromJson(data);
    }).toList();
  }
}

