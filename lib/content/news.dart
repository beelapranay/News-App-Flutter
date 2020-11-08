import 'dart:convert';

import 'package:apinewsapp/models/newsmodel.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsModel> news = [];
  String url =
      "http://newsapi.org/v2/top-headlines?country=in&apiKey=32bf087eec784c6c902e065df844c0cb";
  //"https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher";

  Future<void> getData() async {
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((item) {
        if (item["urlToImage"] != null && item["description"] != null) {
          NewsModel newsModel = NewsModel(
              author: item["author"],
              title: item["title"],
              description: item["description"],
              url: item["url"],
              urlToImage: item["urlToImage"],
              content: item["content"]);
          news.add(newsModel);
        }
      });
    }
  }
}
