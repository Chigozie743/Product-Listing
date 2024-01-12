import 'dart:convert';
import 'dart:developer';
import 'package:product_listing_app/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final companyKey = "selectedOrganization";
  final userType = "userType";
  final userData = "userData";

  Future<String> organizationRead() async {
    final prefs = await SharedPreferences.getInstance();
    final readValue = prefs.getString(companyKey) ?? "";
    log('read: $readValue');
    return readValue;
  }

  void userDataSave(ResponseModel user) async {
    //1 technician 2 - supervisor
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userInJson = user.toJson();
    String dataToSave = jsonEncode(userInJson);
    prefs.setString(userData, dataToSave);
    log('saved $dataToSave');
  }

  Future<ResponseModel?> userDataRead() async {
    //1 technician 2 - supervisor
    final prefs = await SharedPreferences.getInstance();
    final readValue = prefs.getString(userData) ?? "";

    if (readValue.isNotEmpty) {
      Map<String, dynamic> userInJson = jsonDecode(readValue);
      return ResponseModel.fromJson(userInJson);
    } else {
      return null;
    }
  }

  void clearAllStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userType);
    prefs.remove(userData);
  }
}