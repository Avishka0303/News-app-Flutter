import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/strings.dart';
import 'package:news_app/core/models/newsinfo.dart';

class API_Manager{

  Future<NewsModel> getNews() async{

    var client = http.Client();
    var getUri = Uri.parse(Strings.get_url);
    var newsModel;

    try{
      var response = await client.get(getUri);

      if(response.statusCode == 200){
        var body = response.body;
        var jsonMap = json.decode(body);
        newsModel = NewsModel.fromJson(jsonMap);
      }
    }catch(Exception){
      return newsModel;
    }
    return newsModel;
  }
}