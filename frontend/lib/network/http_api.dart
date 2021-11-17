import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/network/http_model.dart';
import 'package:http/http.dart';

class Network{
  Future<Post> getpost()async{
    var url = "https://api.first.org/data/v1/news";

    Response response = await get(Uri.parse(Uri.encodeFull(url)));

    if(response.statusCode == 200){
      //print("News data:${response.body[0]} ");
      return Post.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting the news");
    }
    }
  }
