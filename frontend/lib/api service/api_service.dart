import 'dart:convert';

import 'package:flutter_task/Model/login_model.dart';
import 'package:flutter_task/Model/login_response_model.dart';
import 'package:flutter_task/Model/register_request_model.dart';
import 'package:flutter_task/Model/register_response_model.dart';
import 'package:flutter_task/api%20service/shared_service.dart';
import 'package:flutter_task/config.dart';
import 'package:http/http.dart'as http;

class APIService{
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async{
    Map<String, String> requestHeaders = {
      'content-Type':'application/json',
    };
    var url = Uri.http(Config.apiUrl, Config.loginAPI);
    
    var response = await client.post(url, headers: requestHeaders,body: jsonEncode(model.toJson()));

    if(response.statusCode == 200){
      await SharedService.setLoginDetails(loginResponseJson(response.body));

      return true;
    }
    else{
      return false;
    }
  }
  static Future<RegisterResponseModel> register(RegisterRequestModel model) async{
    Map<String, String> requestHeaders = {
      'content-Type':'application/json',
    };
    var url = Uri.http(Config.apiUrl, Config.registerAPI);

    var response = await client.post(url, headers: requestHeaders,body: jsonEncode(model.toJson()));

    return registerResponseModel(response.body);
  }
  static Future<String> getUserProfile(LoginRequestModel model) async{
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'content-Type':'application/json',
      'Authorization':'Basic ${loginDetails!.data.token}'
    };
    var url = Uri.http(Config.apiUrl, Config.userProfileAPI);

    var response = await client.get(url, headers: requestHeaders);

    if(response.statusCode == 200){
      return response.body;
    }
    else{
      return "";
    }
  }
}