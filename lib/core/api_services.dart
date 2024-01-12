import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:product_listing_app/core/api_endpoints.dart';
import 'package:product_listing_app/models/categories_model.dart';
import 'package:product_listing_app/models/create_users_model.dart';
import 'package:product_listing_app/models/products_model.dart';
import 'package:product_listing_app/models/response_model.dart';
import 'package:product_listing_app/models/secure_storage.dart';
import 'package:product_listing_app/models/users_model.dart';

class APIServices {

  static Future<List<dynamic>> getData({
    required String target,
    String? limit,
  }) async{
    try{
      var uri = Uri.https(
          Endpoint.baseUrl,
          "/api/v1/$target",
          target == "products"
              ? {
              "offset": "0",
              "limit": limit,
              }
              : {}
      );

      var response = await http.get(uri);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      if(response.statusCode !=200){
        throw data["message"];
      }
      for (var v in data){
        tempList.add(v);
      }
      return tempList;
    }catch(error){
      log("An error occured $error");
      throw error.toString();
    }
  }


  //*********************************************************************************/
  //                    GET ALL PRODUCTS API
  //*********************************************************************************/
  static Future<List<ProductsModel>> getALlProducts({required String? limit}) async{
    List temp = await getData(target: "products", limit: limit);
    return ProductsModel.productsFromSnapshot(temp);
  }

  //*********************************************************************************/
  //                    GET ALL PRODUCTS CATEGORIES API
  //*********************************************************************************/
  static Future<List<CategoriesModel>> getALlCategories() async{
    List temp = await getData(target: "categories");
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  //*********************************************************************************/
  //                    GET ALL USEERS API
  //*********************************************************************************/
  static Future<List<UsersModel>> getALlUsers() async{
    List temp = await getData(target: "users");
    return UsersModel.usersFromSnapshot(temp);
  }

  //*********************************************************************************/
  //                    GET ALL USEERS API
  //*********************************************************************************/
  static Future<UsersModel> singleUser() async{
    try{
      var uri = Uri.https(Endpoint.baseUrl, "/api/v1/auth/profile");
       ResponseModel? user = await SecureStorage().userDataRead();

      var response = await http.get(uri, headers: {
        "Authorization": "Bearer ${ user != null ? user.accessToken ?? "": ""}",
      });

      print(response.body);
      print(response.statusCode);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);



      if(response.statusCode !=200){
        throw data["message"];
      }

      return UsersModel.fromJson(data);
    }catch(error) {
      log("error occured while getting product info $error");
      throw error.toString();
    }
  }

  //*********************************************************************************/
  //                    GET ALL PRODUCTS BY THEIR IDs API
  //*********************************************************************************/
  static Future<ProductsModel> getProductsById({required String id}) async{
    try{
      var uri = Uri.https(Endpoint.baseUrl, "api/v1/products/$id");
      var response = await http.get(uri);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      if(response.statusCode !=200){
        throw data["message"];
      }

      return ProductsModel.fromJson(data);
    }catch(error) {
      log("error occured while getting product info $error");
      throw error.toString();
    }
  }


  //*********************************************************************************/
  //                    REGISTER USER ACCOUNT
  //*********************************************************************************/
  static Future<UsersModel> registerUser({required CreateUserModel payload}) async{
    try{
      print({
          "email": payload.email,
          "password": payload.password,
          "name": payload.name,
          "role": payload.role,
          "avatar": payload.avatar
          });
      var uri = Uri.https(Endpoint.baseUrl, "/api/v1/users");
      var response = await http.post(
        uri,
        body: jsonEncode({
          "email": payload.email,
          "password": payload.password,
          "name": payload.name,
          "role": payload.role,
          "avatar": payload.avatar
          }),
        headers: {
          "Content-Type": "application/json",
        }
      );

      print("response: ${response.body}");
      var data = jsonDecode(response.body);


      if(response.statusCode !=201){
        throw data["message"];
      }

      return UsersModel.fromJson(data);
    }catch(error) {
      log("error occured while getting product info $error");
      throw error.toString();
    }
  }


  //*********************************************************************************/
  //                    LOGIN USER 
  //*********************************************************************************/
  static Future<ResponseModel> loginUser({required CreateUserModel payload}) async{
    try{
      print({
          "email": payload.email,
          "password": payload.password,
          });
      var uri = Uri.https(Endpoint.baseUrl, "/api/v1/auth/login");
      var response = await http.post(
        uri,
        body: jsonEncode({
          "email": payload.email,
          "password": payload.password,
          }),
        headers: {
          "Content-Type": "application/json",
        }
      );

      print("response: ${response.body}");
      var data = jsonDecode(response.body);


      if(response.statusCode !=201){
        throw data["message"];
      }

      return ResponseModel.fromJson(data);
    }catch(error) {
      log("error occured while getting product info $error");
      throw error.toString();
    }
  }
}